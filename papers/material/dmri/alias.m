function M=alias(X, P)

[m, n]=size(P);

if size(X, 2) ~=2, error('bad arg'); end
if (min(X(:, 1)) < 1) || (max(X(:, 1)) > m) || ...
   (min(X(:, 2)) < 1) || (max(X(:, 2)) > n)
    error('bad arg');
end

C=numel(P)/sum(P(:));

k=1;
M=[];
delta=zeros(m, n);
for i=1:size(X, 1)
    delta(X(i, 1), X(i, 2))=1;
    psf=abs(ifft2(ifftshift(P.*fftshift(fft2(delta))))); 

    psf=psf./max(psf(:));
    [~, idx]=sort(psf(:), 'descend');
    idx(C+1:end)=[];
    for j=1:length(idx)
        [M(k, 1) M(k, 2)]=ind2sub([m n], idx(j));
        k = k + 1;
    end
    delta(X(i, 1), X(i, 2))=0;
end