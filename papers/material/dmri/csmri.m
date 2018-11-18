function xhat=csmri(phi, psi, y, M, opts)

if nargin < 4 || isempty(M)
    M=zeros(size(y));
    M(y~=0)=1;
end

if nargin < 5
    opts=[];
end

maxIt     = 3;
xfmWeight = 0.05;
TVWeight  = 0.02;

if isfield(opts, 'maxIt'),     maxIt = opts.maxIt;         end
if isfield(opts, 'xfmWeight'), xfmWeight = opts.xfmWeight; end
if isfield(opts, 'TVWeight'),  TVWeight=opts.TVWeight;     end

idx=find(M==1);
Mx=@(z) z(idx);
Mxt=@(z) subsasgn(zeros(size(M)), substruct('()', {idx}), z);

problem.A=ComposeA(Mx, Mxt, phi, psi);
problem.y=y;
if nargin < 4, problem.y=Mx(problem.y); end
problem.TV=TV1D();

problem.xfmWeight = xfmWeight;       % L1 penalty
problem.TVWeight = TVWeight;         % TV penalty

% Parameters being fed into the Non-Linear CG
params.Itnlim = 8;
params.gradToll = 1e-30;
params.l1Smooth = 1e-15;
params.pNorm = 1;

% and line search parameters
params.lineSearchItnlim = 150;
params.lineSearchAlpha = 0.01;
params.lineSearchBeta = 0.6;
params.lineSearchT0 = 1 ;

% Kick it off
xhat=problem.A'*problem.y;
xhat=zeros(size(xhat));
for inner=1:maxIt
    xhat=fnlCg(xhat, problem, params);
end
xhat=psi'*xhat;
