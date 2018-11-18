function x=focuss(problem)

factor = 0.5;
lambda = 0.0;
Mouter = 2;
Minner = 20;
tol=1e-3;

if isfield(problem, 'factor'), factor = problem.factor; end
if isfield(problem, 'lambda'), lambda = problem.lambda; end
if isfield(problem, 'Mouter'), Mouter = problem.Mouter; end
if isfield(problem, 'Minner'), Minner = problem.Minner; end
if isfield(problem, 'tol'),    tol=problem.tol;         end

w=abs(problem.x0) .^ factor;
w=w/max(w);
%G=diag(w.*w);

for outer=1:Mouter
    A = @(z) problem.A*((w.*w).*(problem.A'*z))+lambda*z;
    [y, ~, ~]=cgsolve(A, problem.y, tol, Minner, 0);
    x=(w.*w).*(problem.A'*y);

    w=abs(x) .^ factor;
    w=w/max(w);
%    G=diag(w.*w);
end
