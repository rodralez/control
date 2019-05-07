clc
clear
close all
% Filename: examp73.m
%Example 7.3 Transfer Function to z-Transform
%Continuous and Discrete Step Response

num = 1;

den = [ 1 1 ];

Ts = 0.01; % seconds

H = tf(num, den);

[Hz]= c2d(H,Ts,'zoh');

numd = Hz.num;
dend = Hz.den;

printsys(num, den,'s')

% printsys(numd,dend,'z')

t = 0:Ts:10;

subplot(121), step(H, t);

subplot(122), dstep(numd,dend, length(t));

nd = cell2mat(numd);
dd = cell2mat(dend);

figure
freqz(nd,dd);

[Z, P, K] = tf2zp( nd,dd);

figure
zplane(Z,P)


% The continuous to discrete command c2dm employs a number of conversio