function img=rigr2(K0, K1, K)

I=sum(abs(K), 2)>0;
P=zeros(size(K));
P(I, :)=1;

img=rigr(K1-K0, K-K0.*P)+ifft2(ifftshift(K0));
