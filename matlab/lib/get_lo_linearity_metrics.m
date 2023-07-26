function [second_derivative_smooth] = get_lo_linearity_metrics(one_sweep_samples,midpoint)
%GET_LO_LINEARITY_METRICS Computes the sweep rate of a Phase-Locked Loop (PLL) 
% that generates RF sweeps in both directions.
%
% This function takes as input the in-phase and quadrature (IQ) samples of the frequency 
% sweep and the midpoint of the sweep, and calculates the sweep rate of the PLL.
%
% Inputs:
% - one_sweep_samples: IQ samples of the frequency sweep.
% - midpoint: midpoint of the frequency sweep.
%
% Output:
% - second_derivative_smooth: The smooth sweep rate of the PLL, specifically the second 
%                             derivative of the instantaneous frequency.
%
% The function starts by calculating the instantaneous frequency of the input signal, then 
% applies smoothing to this frequency data. The second derivative of the smoothed 
% instantaneous frequency is then computed for the downsweep, which gives the sweep rate 
% of the PLL. This is returned as the output.

smooth_fac = min(2000, numel(one_sweep_samples)*0.01);  % Defines smoothing factor

% Calculate instantaneous frequency
inst_freq = diff(unwrap(angle(one_sweep_samples)));   
inst_freq = [0;inst_freq];                             % Add 0 at the start

% Apply double smoothing to the instantaneous frequency
inst_freq_smooth = smooth(inst_freq,smooth_fac);       
inst_freq_smooth = smooth(inst_freq_smooth,smooth_fac);

% Restrict instantaneous frequency data to downsweep
inst_freq_smooth_ds = inst_freq_smooth(midpoint:end);

% Calculate second derivative of the smoothed instantaneous frequency
inst_two_derivative = diff(inst_freq_smooth_ds);
inst_two_derivative = [0;inst_two_derivative];         % Add 0 at the start
inst_two_derivative_smooth = inst_two_derivative; % This is the sweep rate

% Restrict the output to the first 3.5e4 elements
max_elem = min(3.5e4, length(inst_two_derivative_smooth));
second_derivative_smooth = inst_two_derivative_smooth(1:max_elem);

end

