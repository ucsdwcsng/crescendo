%%
% This script iteratively loads and analyzes Phase-Locked Loop (PLL) frequency sweep data
% files stored in a designated directory. It applies the get_lo_linearity_metrics function
% to calculate the sweep rate of each PLL sweep, then plots this data.

% Define the directory where the data files are stored
clearvars;
folder_name = "../data/sweep_lo_linearity/";

% List of filenames to be loaded and analyzed
filename_list = ["sweep_lo_linearity_5msGHz_3762.5.mat",...
    "sweep_lo_linearity_6msGHz_3762.5.mat",...
    "sweep_lo_linearity_7msGHz_3762.5.mat",...
    "sweep_lo_linearity_10msGHz_3762.5.mat",...
    "sweep_lo_linearity_19msGHz_3762.5.mat",...
    "sweep_lo_linearity_29msGHz_3762.5.mat",...
    "sweep_lo_linearity_40msGHz_3762.5.mat"];



% Define the sweep speeds corresponding to the files (ms/GHz)
sweep_speeds = [5, 6, 7, 10, 19, 29, 40];
% Convert the sweep speeds to GHz/sec
sweep_speeds = 1./(sweep_speeds * 1e-3);
 
% Initiate a new figure
figure(3);

% Index to keep track of the current file
idx = 1;

% Loop over each file in the filename_list
for filename = filename_list(1:end)
    % Display the current filename being processed
    disp(filename)
    
    % Load the current data file
    load(folder_name+filename);
    
    % Apply the get_lo_linearity_metrics function to the loaded sweep data
    [second_derivative_smooth] = get_lo_linearity_metrics(single_sweep,midpoint);
    
    % Create a time vector for plotting
    time_vec_us = [0:(length(second_derivative_smooth)-1)]/200e6 * 1e6;
    
    % Plot the sweep rate data
    plot(time_vec_us,-second_derivative_smooth*200e6*200e6/(2*pi)/4/1e9)
    hold on;
    
    % Get the color of the current plot line
    lineColor = get(gca, 'Children');
    lineColor = get(lineColor(1), 'Color');
    
    % Create a vector for the y-axis and plot it against the time vector
    yaxis_vec = time_vec_us./time_vec_us;
    plot(time_vec_us, yaxis_vec*sweep_speeds(idx), '--', 'LineWidth', 2, 'Color', lineColor)
    
    % Increment the index
    idx = idx+1;
end

% Turn off hold so that future plots don't overlay on the current figure
hold off;

% Set labels for the plot
ylabel('Sweep Rate (GHz/sec)')
xlabel('Time (us)')

% Automatically adjust the axis limits to fit the data
axis tight

% Apply formatting to the plot 
plot_magic('FontSize',24,'aspect_ratio',[8 10]);
