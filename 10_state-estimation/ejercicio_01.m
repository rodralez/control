clc
clear
close all

%% SYSTEM

c = 1;
m = 1;

A = [0 1;  0 -c/m;];
B = [0 1/m]';
C = [1 0];
D = 0;

%% PUNTO A, Controlability

Wr = [B  A*B];
nr = rank(Wr)

%% PUNTO B

syms k1 k2 s real

K = [k1 k2];

CP = det(s*eye(2) - A + B*K);
CP = collect(CP)

DP = (s + 4)^2;
DP = collect(DP)

% CP = s^2 + (k2 + 1) * s + k1 
% DP = s^2 + 8 * s + 16;

k1 = 16;
k2 = 8 - 1;  

kr = -(C * (A)^(-1) * B)^(-1);

K = [k1 k2];

%% PUNTO C, Observability

Wo = [C ; C*A];
no = rank(Wo)

%% PUNTO D

syms l1 l2 s real

L = [l1 l2]';

CP = det(s*eye(2) - A + L*C);
CP = collect(CP)

DP = (s + 4 * 4)^2;
DP = collect(DP)

% CP = s^2 + (l1 + 1)*s + l1 + l2
% PC = s^2 + 32*s + 256

l1 = 32 - 1;  
l2 = 256 - l1;

L = [l1 l2]';

%% 

KP = eig(s*eye(2) - A + B*K)

LP = eig(s*eye(2) - A + L*C)

