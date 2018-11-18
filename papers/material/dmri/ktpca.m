function X=ktpca(Y, Pt, Pa, npc)

[m, n, k]=size(Y);

Yt=Y.*Pt;
tmp=repmat(fftshift(hamming(size(Yt, 1))), 1, size(Yt, 2));
for f=1:k
    Yt(:, :, f)=ifft2(Yt(:, :, f).*tmp);
end
Yt=fft(Yt, [], 3);

tmp=[];
for x=1:n
    tmp=[tmp; Yt(:, x, :)];
end
[U, S, B]=svds(squeeze(tmp), npc);

B=B';
lambda0 = 0;
for i=1:npc
    lambda0 = lambda0 + B(:, i)'*B(:, i);
end
    
tmp=U*S;
for pc=1:npc
    Wt(:, :, pc)=reshape(tmp(:, pc), m, n);
end

Ya=Y.*Pa;
for f=1:k
    Ya(:, :, f)=ifft2(Ya(:, :, f));
end
Ya=fft(Ya, [], 3);

tic

X=zeros(size(Y));
yf=alias([1, 1], squeeze(Pa(:, 1, :)));
for x=1:n
    tmp=Ya(:, x, :);
    tmp=tmp(:);
    tmp=tmp./max(abs(tmp));
    lambda = lambda0 * var(tmp) / k;
    for y=1:m
        for f=1:k
            %%
            % M=[];
            % Bf=[];
            % for i=1:size(yf, 1)
            %     M=blkdiag(M, diag(squeeze(Wt(yf(i, 1), x, :))));
            %     Bf=blkdiag(Bf, B(:, yf(i, 2))');
            % end
            % M=abs(M);
            % M2=M*M;
            % E=ones(1, size(yf, 1))*Bf;
            % tmp=Bf*M2*E'*inv(E*M2*E'+lambda)*Ya(y, x, f);;
            % X(y, x, f)=tmp(1);
            
            %%
            a=zeros(size(yf, 1),1);
            for i=1:size(yf, 1)
                a(i)=B(:, yf(i, 2))'*((abs(squeeze(Wt(yf(i, 1), x, :))).^2) .* B(:, yf(i, 2)));
            end
%            if yf(1,1) ~= y || yf(1, 2) ~= f
%                error('error');
%            end
            X(y, x, f)=(a(1)/(sum(a)+lambda))*Ya(y, x, f);

            %%
            for i=1:size(yf, 1)
                yf(i, 2)=yf(i, 2)+1;
                if yf(i, 2) > k, yf(i, 2)=1; end
            end
        end
        for i=1:size(yf, 1)
            yf(i, 1)=yf(i, 1)+1;
            if yf(i, 1) > m, yf(i, 1)=1;end
        end
    end
end

toc

X=ifft(X, [], 3);
