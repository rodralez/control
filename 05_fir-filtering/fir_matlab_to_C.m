% fir_matlab_to_C: script to compare FIR filters implemented in C and MATLAB 
% languages.
%
% Version: 002
% Date:    2019/04/15
% Author:  Rodrigo Gonzalez <rodralez@frm.utn.edu.ar>
% URL:     https://github.com/rodralez/control

clc
close all
clear

%% PARAMETERS

Fn1 = 500;   % Signal 1 frequency
Fn2 = 60;    % Signal 2 frequency
Fs = 10000;  % Sampling frequency

%%

dt = 1/Fs;
t = (0:dt:pi)';

signal = sin(2 * pi * Fn1 * t) + 0.5 * sin(2 * pi * Fn2 * t); 

%% MATLAB-to-C, SINGLE PRECISION

% Input arguments must be in float

input_f = single(signal);

output_c = fir_matlab_wrapper( input_f );

%% FIR MATLAB FILTERING, DOUBLE PRECISION


%% PLOT

N = 1000;

figure
subplot(2,1,1)
plot(t(1:N), input_f(1:N), '-b')
legend('ORIGINAL SIGNAL')
subplot(2,1,2)
plot(t(1:N), output_c(1:N), '-g')
legend('FILTERED SIGNAL')

