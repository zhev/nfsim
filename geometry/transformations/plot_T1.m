% File:         plot_T1.m
% Programmer:   Ioannis Filippidis, Mechanical Engineer, jfilippidis@gmail.com
% Date:         2010.09.18
% Language:     MATLAB, program version: 7.11 (2010b)
% Purpose:      plot radius transformation function T1
% Copyright:    Ioannis Filippidis, 2010-

function plot_T1(ri, r_in, r_out)
    theta = 0;

    % Radius transformation function T^1(r,\theta) vs r
    figure;
        r1 = linspace(r_in, r_out);
        
        r1_new = zeros( size(r1) );
        r1_dif = zeros( size(r1) );
        for i=1:length(r1)
            a = Ti(r1(i), theta, ri, r_in, r_out);
            r1_new(i) = a(1,1);
            f = JTi(r1(i), theta, ri, r_in, r_out);
            r1_dif(i) = f(1,1);
        end
        
        plot(r1 ./r_in, r1_new ./ri, 'b-')
        hold on
        plot( [0, r_out] ./r_in, [r_out, r_out] ./ri, 'r--') % y = r_{out} /\rho_i
        plot( [r_out, r_out] ./r_in, [0, r_out] ./ri, 'r--') % x = r_{out} /r_in
        
        plot( [r_in, r_out] ./r_in, [ri, r_out] ./ri, 'm--') % ri /\rho_i = r/r_in line
        plot( [r_out, 1.1*r_out] ./r_in, [r_out, 1.1*r_out] ./ri, 'b-') % part of identity map
        grid on
        
        tex_plot_annot(gca,...
            '$\frac{r_i(r)}{\rho_i}$ radius transformation function',...
            '$\frac{r}{r_{in}}$ (-)',...
            '$\frac{r_i(r)}{\rho_i}$ (-)',...
            {'$\frac{r_i(r)}{\rho_i} = \frac{T^1(r,\theta)}{\rho_i}$', '$\frac{r_{out}}{\rho_i}$'})
        
    % Radius transformation function derivative T^1_r(r,\theta) vs r
    figure;
        plot(r1 ./r_in, r1_dif, 'b')
        hold on
        plot( [r_out, r_out] ./r_in, [0, max(r1_dif)], 'r--') % x = r_{out} /r_in
        plot( [r_out, 1.1*r_out] ./r_in, [1, 1], 'b-') % identity map
        grid on
        
        tex_plot_annot(gca,...
            '$\frac{\partial r_i(r)}{\partial r}$ function',...
            '$\frac{r}{r_{in}}$ (-)',...
            '$\frac{\partial\rho(r)}{\partial r}$ ($\frac{1}{L}$)',...
            [])
end
