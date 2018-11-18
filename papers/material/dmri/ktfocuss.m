function X=ktfocuss(Y, P, lx)

pred=1;

[m, n, k]=size(Y); 
Y=ifft(Y, [], 2);
Y=Y.*P;

if pred == 1
    DC=sum(Y,3);
    SM=sum(P,3); 
    SM(SM==0)=1;
    DC=DC./SM;
end

if nargin < 3 || isempty(lx)
    lx=1:n;
end

tic;

X=zeros(size(Y));
for i=1:length(lx) 
    x=lx(i);

    M=squeeze(P(:, x, :));
    idx=find(M==1);
    Mx=@(z) z(idx);
    Mxt=@(z) subsasgn(zeros(size(M)), substruct('()', {idx}), z);

    phi=FFT1D([m, k], [], 1);
    psi=FFT1D([m, k], [], 2);

    data=squeeze(Y(:, x, :)); 

    if pred == 1
        baseline=repmat(DC(:, x), 1, k);
        data = data - baseline;
    end

    problem.A=ComposeA(Mx, Mxt, phi, psi); 
    problem.y=Mx(data);
    problem.x0=problem.A'*problem.y; 
%    problem.x0=psi*zeros(m, k);
    problem.x0=problem.x0(:);

    X(:, x, :)=psi'*focuss(problem);

    if pred == 1
        X(:, x, :)=X(:, x, :)+reshape(ifft(baseline, [], 1), size(X(:, x, :)));
    end
end

tElapsed=toc;
disp(['k-t FOCUSS: ' num2str(tElapsed)]);
