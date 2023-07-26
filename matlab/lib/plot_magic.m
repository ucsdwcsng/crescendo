function [param_in] = plot_magic(fig_han, ax_han, param_in)
%PLOT_MAGIC Function to standardize MATLAB figure properties such as size, line width, font size, grid.
% The function takes in optional parameters and updates the properties of the figure and axes accordingly.
% 
% Arguments:
% fig_han (optional): Handle to the figure. Default is current figure (gcf).
% 
% ax_han (optional): Handle to the axes. Default is current axes (gca).
% 
% param_in (struct, optional): Structure containing parameters to modify figure and axes properties. Fields are:
% - aspect_ratio: Two-element vector [width, height] defining the aspect ratio of the figure. Default is [4,3].
% - size_flag: String defining the size of the figure. Available options are 'big', 'med' or 'none'. Default is 'none'.
% - pixelDensity: Scalar defining the pixel density per unit of the aspect ratio. Default is 200.
% - lineWidth: Scalar defining the line width of all line objects in the axes. Default is 3.
% - fontSize: Scalar defining the font size of the axes. Default is 18.
% - gridFlag: String defining if the major grid lines should be displayed. Default is 'on'.
% - minorGridFlag: String defining if the minor grid lines should be displayed. Default is 'on'.
%
% Output:
% param_in: The updated parameters structure.
%
% Usage:
% To customize properties, provide a structure. For example:
% plot_magic(gcf, gca, struct('aspect_ratio',[6 4],'size_flag','big','pixelDensity',300,'lineWidth',2,'fontSize',20,'gridFlag','off','minorGridFlag','on'))
%
% This will modify the current figure and axes to have a 6:4 aspect ratio, big size, 300 pixel density, 2 line width, 20 font size, no major grid lines but with minor grid lines.
%
% Created by: Anonymous

arguments
    fig_han = gcf;
    ax_han = gca;
    param_in.aspect_ratio = [4 3];
    param_in.size_flag = ['none'];
    param_in.pixelDensity = 200; % Pixels pre 1 unit of aspect ratio
    param_in.lineWidth = 3;
    param_in.fontSize = 18;
    param_in.gridFlag = 'on';
    param_in.minorGridFlag = 'on';
end

if(~isempty(fig_han))
    fig_han.Position = [fig_han.Position(1:2) param_in.aspect_ratio*param_in.pixelDensity];
end

switch(param_in.size_flag)
    case 'big'
        param_in.lineWidth = 3;
        param_in.fontSize = 18;
    case 'med'
        param_in.lineWidth = 2;
        param_in.fontSize = 12;
    otherwise
end

set(findall(ax_han, 'Type', 'Line'),'LineWidth',param_in.lineWidth);
set(ax_han,'fontsize', param_in.fontSize);

grid(ax_han, param_in.gridFlag);
if(param_in.minorGridFlag == "on")
    grid(ax_han, 'minor');
end


end

