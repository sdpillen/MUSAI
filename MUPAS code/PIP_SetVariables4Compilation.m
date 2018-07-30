%% set variables in workspace before compiling (if necessary)
timeinsecondsandtriggerchannel = [0,1;0.1,2];
phasecondition = 1;
amplitudeinterval = [0 10000];
amplitudeinterval_percentiles = [0.25 0.75]; % ??? what to put in here (TOB 2017-07-24) ???
reset = 0;
closedloopmode = 0;
marker_id = 0;
fft_bin_indices_zero_based = [8 13];
fir_filter_coefficients = get(design(fdesign.bandpass('n,fst1,fp1,fp2,fst2', 128, 4, 8, 12, 16, 1000), 'firls', 'FilterStructure', 'dffirt'), 'Numerator');
forecast_offset_ms = 0;

%%% Spatial filters

%% C3
% spatial_filter = [zeros(1,4) 1 zeros(1,59) 0]; % row vector with 64 elements (as applied to EEG channels only)

%% C3 Hjorth filter
% N = 65; chan_center = 5; chan_surround = [21 23 25 27];
N = 8; chan_center = 1; chan_surround = [3 4 5 6]; % for SCREEN
spatial_filter = zeros(1,N); spatial_filter(chan_center) = 1; spatial_filter(chan_surround) = -1/length(chan_surround);

%% set params
% optimize 50 Hz :-)
% tg.setparam('fir_filter_coefficients', get(design(fdesign.bandpass('n,fst1,fp1,fp2,fst2', 128, 40, 45, 55, 60, 1000), 'firls', 'FilterStructure', 'dffirt'), 'Numerator'))
% individual alpha
% tg.setparam('fft_bin_indices_zero_based', [10 11])