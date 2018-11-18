clear
load d:\my\work\007\sol_yxzt_pat1

% 0 -------- UNFOLDing a real cardiac cine
% non-zero - showing the idea behind the UNFOLD
ideaonly=1;
 
% Used ONLY when `ideaonly' is non-zero
% 0 -------- UNFOLDing constant signal
% non-zero - UNFOLDing time-varying signal
dynamic = 0;


T=20; % number of frames
N=256;

for i=1:T
    tmp=sol_yxzt(:, :, 1, i);
    tmp=tmp./max(tmp(:));
    xtref(:, :, i)=tmp;
end

% patterns
p1=zeros(N, 1); p1(1:2:end)=1;
p2=zeros(N, 1); p2(2:2:end)=1;

%Fermi filter to preserve the DC-component
tmp=linspace(0, 1, 20);
tmp=tmp(:);
f1=1./(1+exp((tmp-0.79)./0.022));
f2=1./(1+exp((flipud(tmp)-0.79)./0.022));
f=abs(f1-f2);

if ideaonly == 0
    % zero-fill recovery
    for i=1:T
        ktref(:, :, i)=fft2(xtref(:, :, i));
        if mod(i, 2) == 1
            p=repmat(p1, 1, N);
        else
            p=repmat(p2, 1, N);
        end;
        xtalias(:, :, i)=2*real(ifft2(ktref(:, :, i).*p));
    end
    
    % UNFOLD pixel by pixel
    for i=1:N
        for j=1:N
            t=xtalias(i,j, :);
            t=t(:);
            Ft=fft(t);
            
            Ft=Ft.*f;
            
            xthat(i, j, :)=real(ifft(Ft));
        end
    end
    implay(xthat)   
else %if ideaonly ~= 0
    col=128; % take 128th column as the example
    if dynamic == 0
        % each column is the same
        tmp=xtref(:, col, 1);
        X=repmat(tmp(:), 1, T);
    else
        % columns change with time
        for i=1:T
            tmp=xtref(:, col, i);
            X(:, i)=tmp(:);
        end
    end
    
    % to k-space
    K=fft(X); % cannot use the fft2!!!
    
    % under-sampling
    Ku=K.*repmat([p1 p2], 1, T/2);
    
    % zero-fill recovery
    Xu=2*real(ifft(Ku));
    
    % take 128th point as the example
    n0=128; %n1=mod(N/2+n0, N);
    
    if dynamic == 0
        x=X(:, 1); % any column suffices
        
        x1=Xu(:, 1);
        x2=Xu(:, 2);
        
        % just for verification, MBZ
        norm((x+circshift(x, N/2)) - x1)
        norm((x-circshift(x, N/2)) - x2)
        
        % to Fourier domain
        t=Xu(n0, :)';
        Ft=fft(t);
        figure;  stem(Ft);
        hold on; stem(f, 'r');
        legend('Spectrum', 'Fermi filter');
        xlabel('frame');
        
        % verify that Ft(1) is the DC-component
        %mean(t)-mean(ifft(Ft.*f))
        
        % XXX - how to verify the Ft(T/2+1) is the Nyquist-component?
    else
        % to Fourier domain
        t=Xu(n0, :)';
        Ft=fft(t);
        figure;  stem(Ft);
        hold on; stem(f, 'r');
        legend('Spectrum', 'Fermi filter');
        xlabel('frame');
    end
    
    % filter the Nyquist-component out
    dc=Ft.*f;
    
    % recover x from the DC-component
    norm(real(ifft(dc))-X(n0, :)') % show the error(owing to frequency leakage)
    
    figure;  stem(real(ifft(dc)));
    hold on; stem(X(n0, :), 'r');
    legend('recovered', 'reference');
    xlabel('frame');
end
