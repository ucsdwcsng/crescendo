%% Analysis of Local Oscillator (LO) Stability
% This script applies the get_lo_stability_metrics function to reference samples from multiple
% LO frequency downsweeps, with each sample taken at the midpoint of each downsweep. This analysis
% allows for the assessment of LO stability across multiple sweeps.
%
% The script then creates boxplots for the phase standard deviation and frequency drift. These plots
% provide a visualization of the stability of the LO over time.

% Clear all variables
clearvars;

% Define the directory where the data files are stored
folder_name = "../data/sweep_lo_stability/";

% List of filenames to be loaded and analyzed
filename_list = ["sweep_lo_stability_2msGHz_3762.5.mat",...
    "sweep_lo_stability_5msGHz_3762.5.mat",...
    "sweep_lo_stability_6msGHz_3762.5.mat",...
    "sweep_lo_stability_7msGHz_3762.5.mat",...
    "sweep_lo_stability_10msGHz_3762.5.mat",...
    "sweep_lo_stability_19msGHz_3762.5.mat",...
    "sweep_lo_stability_29msGHz_3762.5.mat",...
    "sweep_lo_stability_40msGHz_3762.5.mat"];


% Initialize the output vectors
set_time_vec = [];
phase_diff_vec = [];
freq_drift_vec = [];
settled_std_vec = [];

% Loop over each file in the filename_list
for filename = filename_list(2:end)
    % Display the current filename being processed
    disp(filename)
    
    % Load the current data file
    load(folder_name+filename);
    
    % Apply the get_lo_stability_metrics function to the loaded data
    % The input to the function is the phase angle of the midpoint reference sample of each
    % downsweep (downsweep_ref_samples), and the corresponding time vector (time_vec)
    [settling_time, phase_diff_to_settle, freq_drift_to_settle, settled_std] = ...
        get_lo_stability_metrics(angle(downsweep_ref_samples),time_vec);
    
    % Append the metrics to their respective vectors
    set_time_vec = [set_time_vec;settling_time];
    phase_diff_vec = [phase_diff_vec;phase_diff_to_settle];
    freq_drift_vec = [freq_drift_vec;freq_drift_to_settle];
    settled_std_vec = [settled_std_vec;settled_std];
end

% Plot the boxplot for the standard deviation of the phase
figure(1)
boxplot(sort([settled_std_vec]), 'Notch','off', 'PlotStyle', 'traditional',...
    'Labels',{'Phase STD'})
ylabel('Phase (Radian)')
plot_magic('aspect_ratio',[3 3],'fontSize',20); % Custom function for plot formatting

% Plot the boxplot for the frequency drift
figure(2)
boxplot(abs([freq_drift_vec]*1e3), 'Notch','off', 'PlotStyle', 'traditional',...
    'Labels',{'Freq Drift'})
ylabel('Freq (mHz)')
plot_magic('aspect_ratio',[3 3],'fontSize',20); % Custom function for plot formatting
