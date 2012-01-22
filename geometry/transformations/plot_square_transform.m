% File:         plot_square_transform.m
% Programmer:   John Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:         2010.09.15
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      plot diffeomorphism
% Copyright:    John Filippidis, 2010-

function [] = plot_square_transform
    close all
    
    % Compute a diffeomorphism from a square to a square which leave
    % the boundary fixed.
    
    N = 20; % num of grid points
    epsilon = 0.1; % displacement for each small diffeomorphism
    num_comp = 15; % number of times the diffeomorphism is composed with itself

    S = linspace(-1, 1, N);

    [X, Y] = meshgrid(S);

    Z = X; W = Y;

    % take num_comp compositions of the same small diffeomorphism
    for iter = 1:num_comp
      for i=1:N
         for j=1:N

            [Z(i, j), W(i, j)] = small_diffeo(Z(i, j), W(i, j), epsilon);

         end
      end
    end

    % graphing settings
    lw = 2;
    mycolor = [1, 0, 0.1];
    small = 0.1;

    figure;
    
    % Initial domain
    subplot(1,2,1)
    %clf;
    hold on;
    for i=1:N
      plot(X(:, i), Y(:, i), 'linewidth', lw, 'color', mycolor);
      plot(X(i, :), Y(i, :), 'linewidth', lw, 'color', mycolor);
    end
    axis([-1-small, 1+small, -1-small, 1+small]);
    axis equal;
    axis off;

    % Final domain
    subplot(1,2,2)
    %clf;
    hold on;
    for i=1:N
      plot(Z(:, i), W(:, i), 'linewidth', lw, 'color', mycolor);
      plot(Z(i, :), W(i, :), 'linewidth', lw, 'color', mycolor);
    end
    axis([-1-small, 1+small, -1-small, 1+small]);
    axis equal;
    axis off;
end
 
function [z, w] = small_diffeo(x, y, epsilon)
 
   A1=epsilon*(cos(pi*x)+1)*(cos(pi*y)+1)/4.0;
   A2=epsilon*cos(pi*x/2)*cos(pi*y/2);
 
   A = (A1+A2)/2;
 
   z = x +(-y)*A;
   w = y +( x)*A;
end
