function X=kalman(Y, M, lx)

[m, n, k]=size(Y);

Y=ifft(Y, [], 2);
Y=Y.*M;

if nargin < 3 || isempty(lx)
    lx=1:n;
end

tic;

X=zeros(size(Y));
for i=1:length(lx)
    x=lx(i);

    t=1;

    X(:, x, t)=ifft(squeeze(Y(:, x, t)));
%    X(:, x, t)=csmri(FFT1D([m, 1], [], 1), FWT1D('Daubechies', 4, 4), squeeze(Y(:, x, t)));

    Q=X(:, x, t);
    Q=Q./max(abs(Q(:)));
    Q=diag(abs(Q));
    sigma = sqrt(min(diag(Q)));
    Q = Q - 2*(1/sqrt(m))*sigma*sigma*eye(size(Q));

    P = (sum(M(:, x, t))/numel(M(:, x, t))) * Q;
    u = squeeze(X(:, x, t));
    for t=2:k
        
%        A = eye(m);
        
        A=blockmatch(ifft(squeeze(Y(:, x, t))), ifft(squeeze(Y(:, x, t-1))), 3);
%        A=motion(csmri(FFT1D([m, 1], [], 1), FWT1D('Daubechies', 4, 4), squeeze(Y(:, x, t))), u, 3);

        u = A*u;
        P = A*P*A'+Q;
        
        G=Msp(squeeze(M(:, x, t)));
        H=G*fft(eye(m));
        y=G*squeeze(Y(:, x, t));

        S = H * P * H' + sigma * sigma * eye(size(H, 1));
        K = (P * H') / S;
        u = u + K * (y - H * u);

        P = P + K * (0 - H * P);

        X(:, x, t) = u;
    end
end

tElapsed=toc;
disp(['Kalman: ' num2str(tElapsed)]);
