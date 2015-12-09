function [] = world_dimension_call(src, eventdata)
%% get data
S = guidata(src);

world = S.world;

%% graphics
h_dlg = dialog(...
    'units'     , 'pixels',...
    'position'  , [300, 300, 300, 100],...
    'menubar'   , 'none',...
    'name'      , 'Select Space Dimension',...
    'numbertitle','off',...
    'resize'    , 'off');

h_ok = uicontrol(...
    'Parent'    , h_dlg,...
    'units'     , 'normalized',...
    'position'  , [0.4, 0.1, 0.2, 0.2],...
    'string'    , 'OK',...
    'callback'  , @ok_call);

uicontrol(...
    'Parent'    , h_dlg,...
    'style'     , 'text',...
    'units'     , 'pixels',...
    'position'  , [10, 50, 200, 15],...
    'string'    , 'Space Dimension',...
    'Callback'  , '');

% ndim defined?
if ~isfield(world, 'ndim')
    warning('Space dimension not initialized at startup.')
    %S.world.ndim = 2; % init space dim
else
    ndim = world.ndim; % already defined
    ndim_old = ndim;
end

h_space_dim = spinner(...
     'Parent'   , h_dlg,...
     'Position' , [200, 50, 60, 40],...
     'Min'      , 2,...
     'Max'      , 3,...
     'StartValue',ndim,...
     'Step'     , 1,...
     'Callback' , @space_dim_call);

    function [] = space_dim_call(src, eventdata)
        selected_dim = get(h_space_dim, 'Value');
        ndim = selected_dim;
        %update_guidata(S)
        check_navigate_ability(S);

        % for now 3D world not implemented yet, warn & restore to 2 dim
        %helpdlg('3D worlds not yet fully supported. Dimension reset to 2.')
        %ndim = 2;
        %set(h_space_dim, 'Value', 2);
        %set(h_space_dim, 'String', 2);
    end

    function [] = ok_call(src, eventdata)
        if ndim ~= ndim_old
            S = init_application_data(S);
        end
        
        world.ndim = ndim;
        
        %% data out
        S.world = world;
        update_guidata(S)

        % update graphics when dim change has been implemented

        check_navigate_ability(S);
        closereq;
    end
end