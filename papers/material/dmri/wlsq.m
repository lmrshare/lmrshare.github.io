function x=wlsq(H, y, P, opts)
%
%   min x'*P^(-1)*x
%   s.t.
%       Hx=y
%

if nargin < 4
    opts=[];
end

lambda = 0.0;
Minner = 60;
tol=1e-6;

if isfield(opts, 'lambda'), lambda = opts.lambda; end
if isfield(opts, 'Minner'), Minner = opts.Minner; end
if isfield(opts, 'tol'),    tol=opts.tol;         end

P = P + P';

A = @(z) H*P*H'*z + lambda*z;
[x, ~, ~] = cgsolve(A, y, tol, Minner, 0);
x = P*H'*x;
