function img=rigr(K0, K)

[N, M]=size(K0);

S=abs(ifft2(ifftshift(K0)));
I=find(sum(abs(K), 2)>0);

B=ifft(K(I, :), [], 2);
tmp=repmat(I-1, 1, length(I));

for i=1:N
    T(:, :, i) = exp(-2*pi*1j*(tmp-tmp')*(i-1)/N);
end
for k=1:M
    A=zeros(length(I));
    for i=1:N
        A = A + T(:, :, i)*S(i, k);
    end
    A = A / N;
    C(:, k) = A \ B(:, k);
end

tmp=(1:N)'-1;
img=zeros(N, M);
for m=1:length(I)
    img = img + exp(2*pi*1j*tmp*(I(m)-1)/N)*C(m, :);
end
img = (img.*S)/N;


