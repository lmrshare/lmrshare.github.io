clear
p=path;

s='../csmri';
if isempty(strfind(p, s))
    addpath(s);
end
s='../csmri/utils';
if isempty(strfind(p, s))
    addpath(s);
end

if 0
    load D:\my\uq\lib\K-tFOCUSS\cart_ktFOCUSS\full_ktDATA.mat
else
    load D:\my\uq\data\heartData.mat
    for i=1:25
        x=heartData(:, :, i);
        kt(:, :, i)=fft2(x./max(abs(x(:))));
    end
end

imSize=size(kt);
imSize(end)=[];

for i=1:25
    if i==1
        tmp=ifft2(kt(:, :, i)); % to image space
        tmp=tmp./max(abs(tmp(:)));
        tmp=abs(tmp);
        imgref(:, :, i)=tmp;
        imgzf(:, :, i)=tmp;
        imghat(:, :, i)=tmp;
        imgsample(:, :, i)=ones(size(tmp));
        
        continue
    end
    
    if i==-1
        tmp=ifft2(kt(:, :, i)); % to image space
        tmp=tmp./max(abs(tmp(:)));
        tmp=abs(tmp);
        imgref(:, :, i)=tmp;
        
        tmp=zeros(256,1);
        tmp(64:191)=1;
        tmp=repmat(tmp, 1, 256);
        imgsample(:, :, i)=tmp;
        
        tmp=fftshift(fft2(imgref(:, :, i)));
        y=tmp.*imgsample(:, :, i);
        tmp=ifft2(ifftshift(y));
        tmp=tmp./max(abs(tmp(:)));
        tmp=abs(tmp);
        imgzf(:, :, i)=tmp;
        
        tmp=RIGR(fftshift(fft2(imgref(:, :, 1))), y);
        tmp=tmp./max(abs(tmp(:)));
        tmp=abs(tmp);
        imghat(:, :, i)=tmp;
        
        % motion estimation
        diff=abs(imghat(:, :, i)-imghat(:, :, i-1));
        level=graythresh(diff);
        mask=imfilter(im2bw(diff, level), fspecial('gaussian', [7 7], 2));
        [r,c]=find(mask);
        mask=zeros(imSize);
        mask(min(r):max(r), min(c):max(c))=1;
        imgmask(:, :, i)=mask;
        
        continue
    end
    
    tmp=ifft2(kt(:, :, i)); % to image space
    tmp=tmp./max(abs(tmp(:)));
    tmp=abs(tmp);
    imgref(:, :, i)=tmp;
    
    pdf1=genPDF(imSize, 2, 0.5, 2, 0, 0);
    imgsample(:, :, i)=genSampling(pdf1, 10, 60);
    
    tmp=fftshift(fft2(imgref(:, :, i)));
    y=tmp.*imgsample(:, :, i);
    tmp=ifft2(ifftshift(y));
    tmp=tmp./max(abs(tmp(:)));
    tmp=abs(tmp);
    imgzf(:, :, i)=tmp;
    
    idx=find(imgsample(:, :, i)==1);
    Mx=@(z) z(idx);
    Mxt=@(z) subsasgn(zeros(imSize), substruct('()', {idx}), z);

    % motion estimation
    diff=abs(imgzf(:, :, i)-imghat(:, :, i-1));
    level=graythresh(diff);
    mask=imfilter(im2bw(diff, level), fspecial('gaussian', [7 7], 2));
    [r,c]=find(mask);
    mask=zeros(imSize);
    mask(min(r):max(r), min(c):max(c))=1;
    imgmask(:, :, i)=mask;
    %figure,imshow(mask);
        
    phi=FFT2D(imSize, imSize);
    psi=Weight(imgmask(:, :, i));
    
    % formulate the problem
    problem.A=ComposeA(Mx, Mxt, phi, psi);
    problem.y=Mx(y-phi*imghat(:, :, 1));
    problem.x0=psi*imgzf(:, :, i);
    problem.xtrue=psi*(imgref(:, :, i)-imghat(:, :, 1));
    problem.TV=TVOP(imSize);
    problem.TVWeight=0.002;    % TV penalty
    problem.xfmWeight=0.5;   % L1 penalty
    
    % Parameters being fed into the Non-Linear CG
    params.Itnlim = 16;
    params.gradToll = 1e-30;
    params.l1Smooth = 1e-15;
    params.pNorm = 1;
    % and line search parameters
    params.lineSearchItnlim = 150;
    params.lineSearchAlpha = 0.01;
    params.lineSearchBeta = 0.6;
    params.lineSearchT0 = 1;
    
    problem.xhat=fnlCg(problem.x0, problem, params);
    
    hat=psi'*problem.xhat;
    hat=abs(hat);
    hat=hat./max(hat(:));
    hat=hat+imghat(:, :, i-1);
    hat=hat./max(hat(:));
    imghat(:, :, i)=hat;
    
end