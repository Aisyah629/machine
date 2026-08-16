function main()
    % Signal Processing and Filtering Tool
    
    % Parameters
    fs = 1000; % Sampling frequency
    t = 0:1/fs:1-1/fs; % Time vector
    
    % Generate signal
    signal = sin(2*pi*50*t) + sin(2*pi*120*t);
    
    % Add noise
    noise = 0.5 * randn(size(t));
    noisy_signal = signal + noise;
    
    % Plot original and noisy signal
    figure;
    subplot(2,1,1);
    plot(t, signal);
    title('Original Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    subplot(2,1,2);
    plot(t, noisy_signal);
    title('Noisy Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    % Design filters
    lowpass_cutoff = 80;
    highpass_cutoff = 100;
    
    % Design lowpass filter
    lp_filter = designfilt('lowpassfir', 'PassbandFrequency', lowpass_cutoff, 'StopbandFrequency', lowpass_cutoff + 10, 'SampleRate', fs);
    
    % Design highpass filter
    hp_filter = designfilt('highpassfir', 'PassbandFrequency', highpass_cutoff, 'StopbandFrequency', highpass_cutoff - 10, 'SampleRate', fs);
    
    % Apply filters
    lowpass_filtered = filter(lp_filter, noisy_signal);
    highpass_filtered = filter(hp_filter, noisy_signal);
    
    % Plot filtered signals
    figure;
    subplot(2,1,1);
    plot(t, lowpass_filtered);
    title('Lowpass Filtered Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    subplot(2,1,2);
    plot(t, highpass_filtered);
    title('Highpass Filtered Signal');
    xlabel('Time (s)');
    ylabel('Amplitude');
    
    % Display message
    disp('Signal processing and filtering complete.');
end

% Run main function
main();
