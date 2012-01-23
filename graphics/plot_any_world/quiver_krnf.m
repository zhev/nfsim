function [varargout] = quiver_krnf(ax, domain, resolution, qd, obstacles, k)
%QUIVER_KRNF    plot KRNF negated gradient field over 2D domain
%
% usage
%    H = QUIVER_KRNF(DOMAIN, RESOLUTION, QD, OBSTACLES, K)
%
% input
%   domain = [xmin, xmax, ymin, ymax]
%   resolution = [nx, ny]
%   qd = destination
%      = [#dim x 1]
%   obstacles = obstacle structure array as returned by
%               CREATE_HETEROGENOUS_OBSTACLES
%   k = tuning parameter
%
% output
%   h = handle to quiver object
%
% See also SURFC3_KRNF, DOMAIN2GRAD_KRNF, QUIVERMD.
%
% File:      quiver_krnf.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2012.01.22
% Language:  MATLAB R2011b
% Purpose:   plot KRNF negated gradient field over 2D rectangular domain
% Copyright: Ioannis Filippidis, 2012-

[x, grad_krnfx] = domain2grad_krnf(domain, resolution, qd, obstacles, k);
h = quivermd(ax, x, -grad_krnfx);

if nargout == 1
    varargout{1, 1} = h;
end