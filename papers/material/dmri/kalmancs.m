function X=kalmancs(Y, M, lx, opts)

%-{
xfmWeight = 2;
TVWeight  = 0;
maxIt     = 10;
tol       = 0.05;
if nargin < 4, opts=[]; end
if isfield(opts, 'xfmWeight'), xfmWeight = opts.xfmWeight; end
if isfield(opts, 'TVWeight'),  TVWeight=opts.TVWeight;     end
if isfield(opts, 'maxIt'),     maxIt = opts.maxIt;         end
if isfield(opts, 'tol'),       tol=opts.tol;               end

[m, n, k]=size(Y);

Y=ifft(Y, [], 2);
Y=Y.*M;

if nargin < 3 || isempty(lx)
    lx=1:n;
end

h = waitbar(0,'Please wait...', 'Name', ['Recoverying...']);

tic
X=zeros(size(Y));
for i=1:length(lx)
    x=lx(i);

    t=1;

%    X(:, x, t)=ifft(squeeze(Y(:, x, t)));
    X(:, x, t)=cs(FFT1D([m, 1], [], 1), FWT1D('Daubechies', 4, 4), squeeze(Y(:, x, t)));

    Q=X(:, x, t);
    Q=Q./max(abs(Q(:)));
    Q=diag(abs(Q));
    sigma = sqrt(min(diag(Q)));
    Q = Q - 2*(1/sqrt(m))*sigma*sigma*eye(size(Q));

    P = (sum(M(:, x, t))/numel(M(:, x, t))) * Q;
    for t=2:k
        G=Msp(squeeze(M(:, x, t)));
        H=G*fft(eye(m));
        y=G*squeeze(Y(:, x, t))-H*squeeze(X(:, x, t-1));

        % Parameters of the Non-Linear CG
        params.Itnlim = 8;
        params.gradToll = 1e-30;
        params.l1Smooth = 1e-15;
        params.pNorm = 1;

        % and line search parameters
        params.lineSearchItnlim = 150;
        params.lineSearchAlpha = 0.1;
        params.lineSearchBeta = 0.6;
        params.lineSearchT0 = 1;

        problem.A=H;
        problem.y=y;
        problem.TV=TV1D();

        problem.xfmWeight = xfmWeight;        % weighted-L2 penalty
        problem.TVWeight  = TVWeight;         % TV penalty

        P1=P;
        prev_u=zeros(m, 1);
        for It=1:maxIt
            problem.W=inv(P1);
            u=fnlCg1(prev_u, problem, params);

            if norm(u-prev_u)/norm(u) < tol
%                disp(['t=' num2str(t) ', outer=' num2str(It)]);
                break;
            end
            prev_u = u;

            tmp=u;
            tmp=tmp./max(abs(tmp(:)));
            tmp=abs(tmp);
            P1 = P + diag(tmp);
        end
        X(:, x, t) = u + squeeze(X(:, x, t-1));

%         tmp=u;
%         tmp=tmp./max(abs(tmp(:)));
%         tmp=abs(tmp);
%         Q = Q + diag(tmp);

        S=H*P*H'+sigma*sigma*eye(size(H, 1));
        P=P-P*H'*(S\H)*P;

        P = P + Q;
    end
    waitbar(i/length(lx), h);
end

close(h);

tElapsed=toc;
disp(['kalmancs: ' num2str(tElapsed)]);
%}
