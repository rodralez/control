clc
close all
clear

%% PARAMETERS

Fn = 100;   % Signal frequency
Fs = 50000;  % Sampling frequency
SNR = 20;   % Signal-to-noise ratio
N = 50;     % MA order

%%

dt = 1/Fs;
t = (0:dt:1)';

signal = sin(2 * pi * Fn * t); 

signal_w = [t, signal];

[signal_n, var_n] = my_noise (signal, SNR);

sim('fir_ma_example_sim');

plot(t(N/2+1:end), signal_n_sim(1:end-N/2), 'g')
hold on 
plot (t,signal_sim, 'b') 
plot (t,signal_ma_sim, 'r') 
legend('Noisy signal', 'Original signal', 'MA signal')
