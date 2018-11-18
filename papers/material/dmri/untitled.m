if 0
    %{
    load ../K-tFOCUSS/cart_ktFOCUSS/full_ktDATA.mat;
    %}
    %-{
    fid1 = fopen(strrep('../dataset/heartDataRealPart.bin', '/', filesep),'rb'); % real part of the data
    fid2 = fopen(strrep('../dataset/heartDataImagPart.bin', '/', filesep),'rb'); % imag part of the data

    kt=fread(fid1, inf, 'single')+1i.*fread(fid2, inf, 'single');
    kt=reshape(kt, 256, 256, 25);

    fclose(fid1); clear fid1;
    fclose(fid2); clear fid2;
    %}

    [m,n,k] = size(kt);
    x=152;
    for t=1:k
        kt(:, :, t)=fft2(kt(:, :, t));
    end
    
    truth=ifft(ifft(kt, [], 2), [], 1);
    for i=1:k, tmp=truth(:, :, i); tmp=tmp./max(abs(tmp(:))); truth(:, :, i)=tmp; end
    
    diff=squeeze(truth(:, x, 2:end)-truth(:, x, 1:(end-1)));
    
    figure;
    subplot(1,3,1);
    imshow(abs(diff));
    subplot(1,3,2);
    plot(sort(abs(diff(:)), 'descend'));
    subplot(1,3,3);
    errorbar(mean(abs(diff), 1), std(abs(diff), 1, 1), 'xr');
end

if 0
%    img=imread('/home/hmj/Downloads/splitBregman/splitBregmanROF_mex/cameraman.tif');
%    img=double(img)./256;

%    img2=zeros(size(img));
%    img2(64:192, 64:192)=img(64:192, 64:192);

%    img4=zeros(size(img));
%    img4(96:160, 96:160)=img(96:160, 96:160);

    pat=zeros(256, 1);pat(1:4:256)=1;
    P(:, 1)=pat; for i=2:256, P(:, i)=circshift(P(:, i-1), 1); end
    %imshow(ifft2(P.*fft2(img2)));
    
    delta=zeros(256,256); 
    delta(1,1)=1;
    psf=abs(ifft2(ifftshift(P.*fftshift(fft2(delta)))));
    
    
    foo=ifft2(fft2(psf)*diag(exp(-1j*2*pi*[0:255]/256)));
    
%    m = 255;
%    n = 0;
%    for u=1:256
%        for v=1:256
%            e(u, v)=exp(-1j*2*pi*(m*(u-1)+n*(v-1))/256);
%        end
%    end
%    E=ifft2(e);
    
%    foo=conv2(E, psf);
    foo=abs(foo);
    foo=foo./max(foo(:));
    imshow(foo);
    
end

if 0
    clear
    p=zeros(256, 1);
    %p(1:8)=1;p(end-7:end)=1;
    p(120:135)=1;
    P=repmat(p, 1, 256);

    load(strrep('../K-tFOCUSS/cart_ktFOCUSS/full_ktDATA.mat', '/', filesep))
    K0=kt(:, :, 1);
    K=kt(:, :, 2);
    K1=kt(:, :, end);

    K0=fftshift(K0);
    K=fftshift(K);
    K1=fftshift(K1);

    %imghat=ifft2(ifftshift(K));
    %imghat=ifft2(ifftshift(K.*P));
    %imghat=RIGR(K0, K.*P);
    imghat=RIGR2(K0, K1, K.*P);

    x=abs(imghat);x=x./max(x(:));imshow(x);
end

if 0
%%
    clear
    load(strrep('../K-tFOCUSS/cart_ktFOCUSS/full_ktDATA.mat', '/', filesep))
    

    %kt(:, :, 25)=[];
    %kt(:, :, 17:end)=[];

%    for i=1:size(kt, 3)
%        kt(:, :, i)=fftshift(kt(:, :, i));
%    end

%%
    pat=zeros(256, 1);
    pat(1:8)=1;
    pat(end-7:end)=1;
    Pt(:, :, 1)=repmat(pat, 1, 256);
    for i=2:size(kt, 3)
        Pt(:, :, i)=Pt(:, :, i-1);
    end

    pat=zeros(256, 1);pat(1:4:256)=1;
    Pa(:, :, 1)=repmat(pat, 1, 256);
    for i=2:size(kt,3)
        Pa(:, :, i)=circshift(Pa(:, :, i-1), 1);
    end
    clear pat
    
%% Ground truth
    for i=1:size(kt, 3)
        xt0(:, :, i)=ifft2(kt(:, :, i));
    end
%    xf0=fft(tmp, [], 3);

%% Aliased
    for f=1:size(kt, 3)
        xt1(:, :, f)=ifft2(kt(:, :, f).*Pa(:, :, f));
    end
%    xf1=fft(tmp, [], 3);

%% Un-aliased
    xtpca=ktpca(kt, Pt, Pa, 10);
    
%     foo=abs(xtpca);
%     for i=1:size(xtpca,3)
%         tmp=foo(:, :, i); 
%         tmp=tmp./max(tmp(:)); 
%         foo(:, :, i)=tmp; 
%     end
%     implay(foo);
    
    x=128;
    figure;
    
%% Ground truth
    foo=squeeze(xt0(:, x, :));
    foo=foo./max(abs(foo(:)));
    subplot(1,3,1)
    imshow(abs(foo));
%    imshow(abs(fftshift(foo, 2)));

%% Aliased
    foo=squeeze(xt1(:, x, :));
    foo=foo./max(abs(foo(:)));
    subplot(1,3,2);
    imshow(abs(foo));
%    imshow(abs(fftshift(foo, 2)));
    
%% Un-aliased
    foo=squeeze(xtpca(:, x, :));
    foo=foo./max(abs(foo(:)));
    subplot(1,3,3);
    imshow(abs(foo));
%    imshow(abs(fftshift(foo, 2)));

%    save('/home/hmj/xtpca.mat', 'xtpca');

%    saveas(gcf, '/home/hmj/ktpca.jpg');    
%    sendmail('hongmingjian@gmail.com', 'Matlab', 'ktpca', {'/home/hmj/ktpca.jpg'});
end

%%
if 1
   
    addpath(strrep('../csmri', '/', filesep));
    addpath(strrep('../csmri/utils', '/', filesep));

%    addpath(strrep('../../lib/NESTA_v1.1', '/', filesep));

    clear
    
    %-{
    fid1 = fopen(strrep('../dataset/heartDataRealPart.bin', '/', filesep),'rb'); % real part of the data
    fid2 = fopen(strrep('../dataset/heartDataImagPart.bin', '/', filesep),'rb'); % imag part of the data
    kt=fread(fid1, inf, 'single')+1i.*fread(fid2, inf, 'single');
    kt=reshape(kt, 256, 256, 25);
    fclose(fid1); clear fid1;
    fclose(fid2); clear fid2;

    for t=1:25
        kt(:, :, t)=fft2(kt(:, :, t));
    end
    roi=[101 48 75 100];
    x=152;
    T=[7 11 24];
    opts.xfmWeight = 2;
    opts.TVWeight  = 0;      
    %}
    %{
    load(strrep('../K-tFOCUSS/cart_ktFOCUSS/full_ktDATA.mat', '/', filesep))
    roi=[100 62 78 96];
%    roi=[112 80 66 76];
    x=128;
    T=[5 15 22];
    opts.xfmWeight = 2;
    opts.TVWeight  = 0;
    %}    
    %{
    vr=VideoReader('../dataset/elgar.avi');
    kt=read(vr, [1 inf]);
    kt=squeeze(kt(:, :, 1, :));
    kt=double(kt)./255;
    for i=1:size(kt, 3)
        kt(:, :, i)=fft2(kt(:, :, i));
    end
    x=80;
    opts.xfmWeight = 2;
    opts.TVWeight  = 0.05;    
    %}
    %{
    load(strrep('../dataset/larynx.mat', '/', filesep));
    for i=1:10
        kt(:, :, i)=fft2(larynximage(:, :, i));
    end
    %}
    
    [m, n, k]=size(kt);
 
    M=Random_DownsamplingMASK(m, n, 1, 4);
    M=cat(3, M, Random_DownsamplingMASK(m, n, 1, 4));
%    M=cat(3, M, Random_DownsamplingMASK(m, n, 1, 2));
    M=cat(3, M, Random_DownsamplingMASK(m, n, k-2, 4));
%    M=cat(3, M, Random_DownsamplingMASK(m, n, k-3, 12));

    truth=ifft(ifft(kt, [], 2), [], 1);
    for i=1:k, tmp=truth(:, :, i); tmp=tmp./max(abs(tmp(:))); truth(:, :, i)=tmp; end
    focuss=ktfocuss(kt, M, []);
    for i=1:k, tmp=focuss(:, :, i); tmp=tmp./max(abs(tmp(:))); focuss(:, :, i)=tmp; end
    kalman=kalman(kt, M, []);
    for i=1:k, tmp=kalman(:, :, i); tmp=tmp./max(abs(tmp(:))); kalman(:, :, i)=tmp; end
    proposed=kalman2(kt,M,20);
    for i=1:k, tmp=proposed(:, :, i); tmp=tmp./max(abs(tmp(:))); proposed(:, :, i)=tmp; end
    

    if exist('x', 'var')
        h = figure;

        foo0=squeeze(truth(:, x, :));
        figure(h);
        subplot(1,7,1)
        imshow(abs(foo0));
        title('Ground Truth');

        foo3=squeeze(focuss(:, x, :));
        figure(h);
        subplot(1,7,2);
        imshow(abs(foo3));
        title('k-t FOCUSS');    
        figure(h);
        subplot(1,7,3);
        imshow(abs(foo3-foo0));

        foo4=squeeze(kalman(:, x, :));
        figure(h);
        subplot(1,7,4);
        imshow(abs(foo4));
        title('Kalman');        
        figure(h);
        subplot(1,7,5);
        imshow(abs(foo4-foo0));
        %-{
        foo5=squeeze(proposed(:, x, :));
        figure(h);
        subplot(1,7,6);
        imshow(abs(foo5));
        title('Proposed');
        figure(h);
        subplot(1,7,7);
        imshow(abs(foo5-foo0));
        %}
    end
      
    if exist('roi', 'var')
        truth1=truth(roi(2):(roi(2)+roi(4)), roi(1):(roi(1)+roi(3)), :);
        focuss1=focuss(roi(2):(roi(2)+roi(4)), roi(1):(roi(1)+roi(3)), :);
        kalman1=kalman(roi(2):(roi(2)+roi(4)), roi(1):(roi(1)+roi(3)), :);
        proposed1=proposed(roi(2):(roi(2)+roi(4)), roi(1):(roi(1)+roi(3)), :);
                
        figure; box on; hold on;
        for i=1:k
            foo0=truth1(:, :, i);
            foo3=focuss1(:, :, i);
            foo4=kalman1(:, :, i);
            foo5=proposed1(:, :, i);
            e3(i)=(norm(foo3(:)-foo0(:))/norm(foo0(:)))^2;
            e4(i)=(norm(foo4(:)-foo0(:))/norm(foo0(:)))^2;
            e5(i)=(norm(foo5(:)-foo0(:))/norm(foo0(:)))^2;
        end
        plot(e3, 'g.-');
        plot(e4, 'c.-');
        plot(e5, 'r.-');
        legend('k-t FOCUSS', 'Kalman', 'Proposed');
        xlabel('Time \rightarrow');
        xlim([0 k+1]);
        ylabel('NMSE');

%         figure;
%         xxx=proposed;
%         for i=roi(2):(roi(2)+roi(4)), xxx(i, roi(1))=1; end
%         for i=roi(2):(roi(2)+roi(4)), xxx(i, roi(1)+roi(3))=1; end
%         for i=roi(1):(roi(1)+roi(3)), xxx(roi(2), i)=1; end
%         for i=roi(1):(roi(1)+roi(3)), xxx(roi(2)+roi(4), i)=1; end        
        
        if 0
            for i=1:length(T)
                figure('Name', ['Frame ' num2str(T(i))]);
                subplot(2, 4, 1);imshow(abs(truth1(:, :, T(i))))
                subplot(2, 4, 2);imshow(abs(focuss1(:, :, T(i))))
                subplot(2, 4, 3);imshow(abs(kalman1(:, :, T(i))))
                subplot(2, 4, 4);imshow(abs(proposed1(:, :, T(i))))
                %subplot(2, 4, 5);
                subplot(2, 4, 6);imshow(abs(focuss1(:, :, T(i))-truth1(:, :, T(i))))
                subplot(2, 4, 7);imshow(abs(kalman1(:, :, T(i))-truth1(:, :, T(i))))
                subplot(2, 4, 8);imshow(abs(proposed1(:, :, T(i))-truth1(:, :, T(i))))
            end
        end
    end
end

%%
if 0
    addpath(strrep('../csmri', '/', filesep));
%    addpath(strrep('../../lib/NESTA_v1.1', '/', filesep));

    clear
    
    %-{
    fid1 = fopen(strrep('../dataset/heartDataRealPart.bin', '/', filesep),'rb'); % real part of the data
    fid2 = fopen(strrep('../dataset/heartDataImagPart.bin', '/', filesep),'rb'); % imag part of the data

    kt=fread(fid1, inf, 'single')+1i.*fread(fid2, inf, 'single');
    kt=reshape(kt, 256, 256, 25);

    fclose(fid1); clear fid1;
    fclose(fid2); clear fid2;

    for t=1:size(kt, 3)
        kt(:, :, t)=fft2(kt(:, :, t));
    end
    x=152;
    opts.xfmWeight = 2;
    opts.TVWeight  = 0;          
    %}    
    %{
    vr=VideoReader('../dataset/elgar.avi');
    kt=read(vr, [1 inf]);
    kt=squeeze(kt(:, :, 1, :));
    kt=double(kt)./255;
    for i=1:size(kt, 3)
        kt(:, :, i)=fft2(kt(:, :, i));
    end
    x=80;
    opts.xfmWeight = 2;
    opts.TVWeight  = 0.05;
    %}
    %{
    load(strrep('../K-tFOCUSS/cart_ktFOCUSS/full_ktDATA.mat', '/', filesep))
    x=128;
    opts.xfmWeight = 2;
    opts.TVWeight  = 0;
    %}
    %{
    load(strrep('../dataset/larynx.mat', '/', filesep));
    for i=1:10
        kt(:, :, i)=fft2(larynximage(:, :, i));
    end
    %}
    
    [m, n, k]=size(kt);

    xt0=ifft(ifft(kt, [], 2), [], 1);
    truth=squeeze(xt0(:, x, :));
    truth=truth./max(abs(truth(:)));

    N=50;
    for a=1:N
        M=Random_DownsamplingMASK(m, n, 1, 2);
    %    M=cat(3, M, Random_DownsamplingMASK(m, n, 1, 4));
        M=cat(3, M, Random_DownsamplingMASK(m, n, 1, 4));
        M=cat(3, M, Random_DownsamplingMASK(m, n, k-2, 8));
    %    M=cat(3, M, Random_DownsamplingMASK(m, n, k-3, 16));

        focuss=ktfocuss(kt, M, x);
        foo3=squeeze(focuss(:, x, :));
        foo3=foo3./max(abs(foo3(:)));

        kalman=kalman(kt, M, x);        
        foo4=squeeze(kalman(:, x, :));
        foo4=foo4./max(abs(foo4(:)));
        
        proposed=kalmancs(kt, M, x, opts);
        foo6=squeeze(proposed(:, x, :));
        foo6=foo6./max(abs(foo6(:)));

        for i=1:k
            e3(a, i)=(norm(foo3(:, i)-truth(:, i))/norm(truth(:, i)))^2;
            e4(a, i)=(norm(foo4(:, i)-truth(:, i))/norm(truth(:, i)))^2;
            e6(a, i)=(norm(foo6(:, i)-truth(:, i))/norm(truth(:, i)))^2;
        end
    end
    
    figure; box on; hold on
    errorbar(mean(e3), std(e3), '*-g');
    errorbar(mean(e4), std(e4), 'o-b');         
    errorbar(mean(e6), std(e6), '^-r');
    legend('k-t FOCUSS', 'Kalman', 'proposed');
    xlabel('Time \rightarrow');
    xlim([0 k+1]);
    ylabel('NMSE');    
end