clc
close all
% clear

%% PARAMETERS

Fn1 = 100;   % Signal 1 frequency
Fn2 = 500;   % Signal 1 frequency
Fs = 5000;  % Sampling frequency

%%

dt = 1/Fs;
t = (0:dt:2*pi)';

Hd = iir_200_5000;

sim('iir_example_sim');
