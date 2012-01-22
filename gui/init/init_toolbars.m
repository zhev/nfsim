function [h_zoom_all, h_draw_circle] = init_toolbars
%hToolbar = findall(gcf, 'tag', 'FigureToolBar');
hToolbar = uitoolbar;
Cdata = imread('zoom_all.png');

h_zoom_all = uipushtool(...
    'parent'    , hToolbar,...
    'CData'     , Cdata,...
    'TooltipString', 'Zoom All',...
    'ClickedCallback'  , @zoom_all_call);

Cdata = imread('draw_circle.png');

h_draw_circle = uitoggletool(...
    'parent'    , hToolbar,...
    'CData'     , Cdata,...
    'TooltipString', 'Draw Circle',...
    'OnCallback'  , @draw_circle_call,...
    'OffCallback' , '');