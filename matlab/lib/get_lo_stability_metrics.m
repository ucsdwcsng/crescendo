function [settling_time, phase_diff_to_settle, freq_drift_to_settle, settled_std] = get_lo_stability_metrics(reference_phase_vec,time_vec)
%GET_LO_STABILITY_METRICS Estimates the stability of a Local Oscillator (LO) once settled.
%
% This function takes as input the phase vector of the reference signal and the corresponding
% time vector, and calculates various metrics related to the stability of the LO.
%
% Inputs:
% - reference_phase_vec: Phase vector of the reference signal.
% - time_vec: Corresponding time vector.
%
% Outputs:
% - settling_time: Time taken for the LO to settle.
% - phase_diff_to_settle: Phase difference from the beginning to the settling point.
% - freq_drift_to_settle: Frequency drift from the beginning to the settling point.
% - settled_std: Standard deviation of the phase after settling, providing a measure of stability.
%
% The function uses the phase of the reference signal to estimate when the LO has settled
% by assuming that the last 10% of the phase data represents the settled phase. The difference
% between the phase of the reference signal and the settled phase is then calculated, smoothed,
% and compared to a tolerance level to determine when the LO has settled.

% Unwrap the reference phase vector
reference_phase_vec = unwrap(reference_phase_vec);

% Define magic numbers
settling_factor = 0.9;             % Fraction of phase data assumed to represent settled phase
settling_tolerance = 0.02;         % Tolerance level for determining when LO has settled (radian)
settled_index_select = 1;          % Index for selecting settled phase
first_reliable = 10;               % Index for the first reliable data point

% Estimate settled phase
num_phases = length(reference_phase_vec);
settled_phase = mean(reference_phase_vec(round(num_phases*settling_factor):end));

% Calculate difference from settled phase
smoothed_reference = smooth(reference_phase_vec,10);
settled_difference = abs(smoothed_reference - settled_phase);

% Find indices where difference from settled phase is below tolerance
settled_indices = find( (settled_difference < settling_tolerance), 100, 'first');
settled_indices = settled_indices(settled_indices>first_reliable);

% Select the index representing when the LO has settled
where_settled = settled_indices(settled_index_select);

% Calculate metrics related to LO stability
settling_time = time_vec(where_settled) - time_vec(1);
phase_diff_to_settle = smoothed_reference(where_settled) - smoothed_reference(first_reliable);
freq_drift_to_settle = (1/(2*pi))*phase_diff_to_settle/(time_vec(where_settled) - time_vec(first_reliable));

% Calculate standard deviation of phase after settling
settled_std = std(reference_phase_vec(where_settled:end));

end
