clc
close all
clear

%% PARAMETERS

Fn = 100;   % Signal frequency
Fs = 5000;  % Sampling frequency
SNR = 20;   % Signal-to-noise ratio
N = 10;     % MA order

%%

dt = 1/Fs;
t = (0:dt:2*pi)';

signal = sin(2 * pi * Fn * t); 

signal_w = [t, signal];

[signal_n, var_n] = my_noise (signal, SNR);

sim('fir_ma_example_sim');

plot(signal_n_sim, 'g')
hold on 
plot (signal_sim, 'b') 
plot (signal_ma_sim, 'r') 
legend('Noisy signal', 'Original signal', 'MA signal')
