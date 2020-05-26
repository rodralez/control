clc
clear
close all

%%

A = [0 1 ; 0 -1];
B = [0 1]';
C = [1 0];
D = 0;

%% PUNTO A, Observability

Wo = [C ; C*A];
no = rank(Wo)

%% PUNTO B
syms l1 l2 s real

L = [l1 l2]';

CP = det(s*eye(2) - A + L*C);
CP = collect(CP)

PC = (s + 4)^2;
PC = collect(PC)

% s^2 + (l1 + 1)*s + l1 + l2
% s^2 + 8*s + 16

l1 = 8-1;  l2 = 16;

%% PUNTO C

C1 = [0 1];

Wo = [C1 ; C1*A];
no1 = rank(Wo)

C2 = [1 1];

Wo = [C2 ; C2*A];
no2 = rank(Wo)

%% Controlability

Wr = [B  A*B];
nr = rank(Wr)

%% PUNTO D

syms k1 k2 s real

K = [k1 k2];

CP = det(s*eye(2) - A + B*K);
CP = collect(CP)

PC = (s + 4)^2;
PC = collect(PC)

% s^2 + (k2 + 1)*s + k1 
% s^2 + 8*s + 16;

k2 = 8-1;  k1 =16;
kr = -(C * (A)^(-1) * B)^(-1);

K = [k1 k2];
Ef = eig(s*eye(2) - A + B*K)

CP = det(s*eye(2) - A + L*C);
CP = collect(CP)

PC = (s + 4*4)^2;
PC = collect(PC)

% s^2 + (l1 + 1)*s + l1 + l2
% s^2 + 32*s + 256

l1 = 32 -1;   l2 = 256 - l1;


