
% fp_precision.m compara dos precisiones en punto fijo y punto
% flotante
%
% Version: 001
% Date:    2020/03/18
% Author:  Rodrigo Gonzalez <rodralez@frm.utn.edu.ar>

clc
clear
close all

% Fixed-point quantizer

q = quantizer('fixed', 'floor', 'saturate', [5 1]);      % [wordlength fractionlength]

u = linspace(-15, 15, 1000);

y1 = quantize(q, u);

figure
plot(u,y1); title(tostring(q))
grid on
ylim([-8.5 8]);

% Floating-point quantizer

q = quantizer('float', 'nearest', [6 5]);      % [wordlength exponentlength]

y2 = quantize(q,u);

figure
plot(u,y2); title(tostring(q))
grid on