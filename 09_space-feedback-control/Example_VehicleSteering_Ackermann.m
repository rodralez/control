%---------------------------------------------------
% Vehicle steering 
% Ackermann's method

clc
clear
close all

%---------------------------------------------------
% Model parameters
%---------------------------------------------------

a=2;
b=4;
v0=12;

%---------------------------------------------------
% Model matrices
%---------------------------------------------------

A=[0 v0;0 0];
B=[a*v0/b v0/b]';

C = [1 0];
D = 0;

%---------------------------------------------------
% Reachability
%---------------------------------------------------

Wr = [B A*B];

r = rank(Wr);

if(r == 2)
    disp('The system is controllable.')
else
    disp('The system is not controllable.')
end

%---------------------------------------------------
% Ackermann's method
%---------------------------------------------------

%---------------------------------------------------
% Characteristic polynomial
%---------------------------------------------------

syms s real

CP = det(s*eye(2) - A)

% Since CP = s^2 = ... 
%          = s^n + a1 s^(n-1) + a2 s^(n-2) + ... + an

a1 = 0;
a2 = 0;
ap = [a1 a2];

%---------------------------------------------------
% Desired Characteristic polynomial
%---------------------------------------------------

zeta = 1;

wn = 1;

DP = s^2 + 2 * zeta * wn * s + wn^2

% Since DP = s^2 + 2*s + 1 = s^2 = ... 
%          = s^n + p1 s^(n-1) + p2 s^(n-2) + ... + pn

p1 = 2;
p2 = 1;
p = [p1 p2];

%---------------------------------------------------
% Control design
%---------------------------------------------------

Wr_tilde = [1 a1; 0 1]^(-1);

K = [p - ap] * Wr_tilde * Wr^(-1)

A1 = A - (B * K);
kr = -(C * (A1)^(-1) * B)^(-1)

%---------------------------------------------------
% Closed-loop poles
%---------------------------------------------------

clp = eig(A1)

%---------------------------------------------------
% Simulink, Step response
%---------------------------------------------------

% Chance matrices C and D for Simulink
C=eye(2);
D=[0 0]';

time = 0:0.1:30;

sim('VehicleSteering_sim.slx', time)

%---------------------------------------------------
% Plot
%---------------------------------------------------

figure
plot (time, u(:,2))
title ('Control signal')
grid on

figure
plot (time, x1.signals(1).values)
hold on
plot (time, x1.signals(2).values)
title ('Lateral position')
grid on

