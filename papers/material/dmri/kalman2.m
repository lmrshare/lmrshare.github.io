function X=kalman2(Y, M, niter)

if nargin < 3, niter = 1; end

[m, n, k]=size(Y);

Y=ifft(Y, [], 2);
Y=Y.*M;
X=zeros(size(Y));

t=1;
for x=1:n
    X(:, x, t)=ifft(squeeze(Y(:, x, t)));
%    X(:, x, t)=csmri(FFT1D([m, 1], [], 1), FWT1D('Daubechies', 4, 4), squeeze(Y(:, x, t)));
end

for x=1:n
    tmp=X(:, x, t); 
    tmp=tmp./max(abs(tmp(:)));
    tmp=diag(abs(tmp));
    sigma(x) = sqrt(min(diag(tmp)));
    Q(:, x, :) = tmp - 2*(1/sqrt(m))*sigma(x)*sigma(x)*eye(size(tmp));
    P(:, x, :) = (sum(M(:, x, t))/numel(M(:, x, t))) * squeeze(Q(:, x, :));
end

for t=2:k
    Xt = ifft(squeeze(Y(:, :, t)), [], 1);

    for iter=1:niter
        [U, ~, V]=svd(Xt*squeeze(X(:, :, t-1))');%?
        W = U*V';
        fprintf(1, 'iter=%d,,norm(Xt-W*Xt_1)=%.2f\n', iter,norm(Xt-W*squeeze(X(:, :, t-1))));% if the error is more random or not,so "norm" may not be feasible
        
        Ptmp=P;
        % one frame namely update Xt
        for x=1:n
            Xt(:, x) = W*squeeze(X(:, x, t-1));
            Ptmp(:, x, :) = W*squeeze(Ptmp(:, x, :))*W'+squeeze(Q(:, x, :));
 
            G=Msp(squeeze(M(:, x, t)));
            H=G*fft(eye(m));
            y=G*squeeze(Y(:, x, t));

            K = (squeeze(Ptmp(:, x, :)) * H') / (H * squeeze(Ptmp(:, x, :)) * H' + sigma(x) * sigma(x) * eye(size(H, 1)));
            Ptmp(:, x, :) = squeeze(Ptmp(:, x, :)) + K * (0 - H * squeeze(Ptmp(:, x, :)));

            Xt(:, x) = Xt(:, x) + K * (y - H * Xt(:, x));
        end
        %
    end
    
    P=Ptmp;

    X(:, :, t) = Xt;
end