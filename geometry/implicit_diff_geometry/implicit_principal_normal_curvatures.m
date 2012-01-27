function [K, R, V] = implicit_principal_normal_curvatures(grad, Hessian)
% K = normal curvature of implicitly defined surface
%
% File:      implicit_principal_normal_curvatures.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.24
% Language:  MATLAB R2011b
% Purpose:   calculate principal normal curvatures and directions
%            together with associated principal radii of normal curvature
% Copyright: Ioannis Filippidis, 2012-

g = grad;
H = Hessian;

ng = size(g, 2);
K = nan(1, ng);
R = nan(1, ng);
V = cell(1, ng);
if iscell(H)
    nH = size(H, 2);
    
    if nH ~= ng
        error('Gradients and Hessian matrices for different # points.')
    end
    
    for i=1:ng
        curH = H{1, i};
        curg = g(:, i);
        
        [curK, curR, curV] = calc_curvature(curg, curH);
        
        K(:, i) = curK;
        R(:, i) = curR;
        V(1, i) = curV;
    end
else
    [K, R, V] = calc_curvature(g, H);
end

function [K, R, V] = calc_curvature(g, H)
% tangent plane well-defined ?
if norm(g) == 0
    K = nan;
    R = nan;
    V = {nan};
    return
end

n = normvec(g, 'p', 2);

Pg = reduced_orthogonal_projector(n);
Hg = Pg.' *H *Pg;

[V, D] = eig(Hg);

e = diag(D);

K = e /norm(g, 2);
R = 1 ./K;

V = {Pg *V}; % surface tangent space to ambient space
