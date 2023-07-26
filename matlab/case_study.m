clearvars
%% Parameters
num_steps = 60;  % Number of frequency steps in a sweep
num_gains = num_steps; % Number of gain steps corresponding to the frequency steps
num_samples_per_step = 6144; % Number of I/Q samples per frequency step
num_samples_per_sweep = num_samples_per_step*num_steps; % Total number of I/Q samples per sweep
nfft = num_samples_per_step; % Number of points in FFT
num_bins_good = nfft/2; % Number of useful FFT bins
fft_window = blackmanharris(num_samples_per_step); % Windowing function for FFT (not used in the current code)

header_floats = 2; % Number of float values in the header of each data block in the binary file
header_cmplx = header_floats/2; % Number of complex values in the header of each data block in the binary file

% Uncomment one to analyze and plot
% folder_name = "../data/lte_spee_test/";% 9(a)
folder_name = "../data/courtyard_walk/";% 9(b)
% folder_name = "../data/playground_walk/"; % 9(c)

%% Set up gain and iq file readers
% File readers for the I/Q data and gain data are set up. 
% They read data from binary files using functions read_float_binary 
% and read_complex_binary.
gain_filename = folder_name + "attenuation.bin";
iq_data_filename = folder_name + "sweep_iq_data.bin";

gain_streamer = file_iq_streamer(gain_filename, 0, 0, @read_float_binary);
iq_streamer = file_iq_streamer(iq_data_filename, 0, 0, @read_complex_binary);

%% Read I/Q sample, take FFT and plot 
% The script reads the I/Q samples and header from the binary file. 
% It then reshapes the I/Q samples matrix, takes an FFT of each column 
% (corresponding to I/Q samples per frequency step), and converts the FFT bins to 
% dBm scale to create a PSD matrix. 
% The PSD data are then accumulated for every 10th sweep (for speed)

% This I/Q was captured using the Signal Hound SM200C running in I/Q
% Frequency hop mode.

time_vec = [];
psd_mat = [];
tic;
idx= 0;
while iq_streamer.eof_flag == 0
    try
        iq_header = iq_streamer.read_n_samples(header_cmplx);
        iq_header = [real(iq_header);imag(iq_header)];
        
        iq_samples = iq_streamer.read_n_samples(num_samples_per_sweep);
        iq_samples_rsh = reshape(iq_samples, num_samples_per_step,[]);
        freq_transform = fftshift(fft(iq_samples_rsh,nfft,1),1)/(nfft);
        freq_transform = freq_transform(round(nfft*0.25):round(nfft*0.75),:);
        freq_transform = freq_transform(1:num_bins_good,:);
        psd_db = reshape(10*log10(abs(freq_transform).*2),[],1);

        if mod(idx,10) == 0
            time_vec = [time_vec,iq_header];
            psd_mat = [psd_mat,psd_db];
        end
        idx = idx+1;
    catch
        break
    end
end
toc;

freq_vec = (0:(size(psd_mat,1)-1)) * 200/nfft + 150;


%% Plot PSD
% A 2-D plot is generated with time on the x-axis and frequency on the y-axis. 
% The color represents the PSD value.
figure(1)
imagesc(time_vec(1,:)-time_vec(1,1),freq_vec,psd_mat);
xlabel("Time (s)")
ylabel("Frequency (MHz)")
colormap("jet")

a=colorbar;
ylabel(a,'Power (dBm)','FontSize',18,'Rotation',270);
caxis([-70, -0])
a.Label.Position(1) = 4.3;

plot_magic();

%% Read gains and plot
% The script reads the gain values and header from the binary file. 
% The gain data are accumulated for each sweep.
% A 2-D plot is generated with time on the x-axis and frequency on the y-axis. 
% The color represents the gain value.
time_vec = [];
gain_mat = [];
while gain_streamer.eof_flag == 0
    try
        gain_header = gain_streamer.read_n_samples(header_floats);
        time_vec = [time_vec,gain_header];
        gain_vec = gain_streamer.read_n_samples(num_gains);
        gain_mat = [gain_mat,gain_vec];
    catch
        break
    end
end

figure(2)
imagesc(time_vec(1,:)-time_vec(1,1),150:100:6050,gain_mat*5);
xlabel("Time (s)")
ylabel("Frequency (MHz)")
colormap("jet")

a=colorbar;
caxis([0, 30])
ylabel(a,'Attenuation (dB)','FontSize',18,'Rotation',270);
a.Label.Position(1) = 4;

plot_magic();

