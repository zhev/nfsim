function [grad] = numgrad_makrnfsd(q, r, curi, qdi, dci,...
    k, lambda, h, dh)
% inputs
%   q = configurations of ALL agents
%     = [#dim x #agents]
%
%   r = sphere radii of all agents
%     = [1 x #agents]
%
%   i = index of current agent \in[1,2,...,#agents]
%
%   qdi = destination configuration of agent i
%       = [#dim x 1]
%
%   dci = sensing/communication radius of current agent > 0
%
%   k, lambda, h = Multi-Agent NF parameters
%                  k >= 2, lambda > 0, h > 0
%
%   dh = numerical gradient perturbation scalar
%      > 0 (and sufficiently small for robust numerical results)
%
% output
%   grad = agent gradient
%        = [#dim x 1]
%
% See also MAKRNFSD, NUMGRAD_MAKRNFSDC.
%
% File:      numgrad_makrnfsd.m
% Author:    Ioannis Filippidis, jfilippidis@gmail.com
% Date:      2011.09.02 - 2011.09.20
% Language:  MATLAB R2011a
% Purpose:   MAKRNFSD numerical gradient for 1 agent
% Copyright: Ioannis Filippidis, 2011-

qi = q(:, curi);
pt = numgradpt(qi, dh);

n = size(pt, 2);

f = nan(1, n);
for j=1:n
    q(:, curi) = pt(:, j);
    f(1, j) = makrnfsd(q, r, curi, qdi, dci, k, lambda, h);
end

grad = numgrad(f, dh);
