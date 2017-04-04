clc
close all
clear

%% PARAMETERS

Fn1 = 500;   % Signal 1 frequency
Fn2 = 60;   % Signal 1 frequency
Fs = 10000;  % Sampling frequency

%%

dt = 1/Fs;
t = (0:dt:2*pi)';

signal = sin(2 * pi * Fn1 * t) + 0.5 * sin(2 * pi * Fn2 * t); 

signal_w = [t, signal];

Hd = myfir_kaiser_50N_60_600_Hz;

sim('fir_example_sim');

plot (signal_sim, 'b') 
hold on 
plot (signal_ma_sim, 'r') 
legend('Original signal', 'FIR signal')
