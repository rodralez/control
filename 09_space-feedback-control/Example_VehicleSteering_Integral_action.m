%---------------------------------------------------
% Vehicle steering 
% Integral action

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

A = [0 v0;0 0];
B = [a*v0/b v0/b]';
C = [1 0];
D = 0;

Ag = [A zeros(2,1); C zeros(1) ]
Bg = [B; 0]
Cg = [0 1 0];
H = [0 0 -1]';

%---------------------------------------------------
% Reachability
%---------------------------------------------------

Wr = [Bg (Ag * Bg) (Ag^(2) * Bg) ];

r = rank(Wr);

if(r == 3)
    disp('The system is controllable.')
else
    disp('The system is not controllable.')
end

%---------------------------------------------------
% Ackerman
%---------------------------------------------------

%---------------------------------------------------
% Characteristic polynomial
%---------------------------------------------------

syms s real

CP = det(s*eye(3) - Ag)

% Since CP = s^3 = ... 
%          = s^n + a1 s^(n-1) + a2 s^(n-2) + ... + an

a1 = 0;
a2 = 0;
a3 = 0;
ap = [a1 a2 a3];

%---------------------------------------------------
% Desired Characteristic polynomial
%---------------------------------------------------

zeta = 0.77;
wn = 3.44;
pi = 3*wn*zeta;

DP = (s+pi) * (s^2 + 2 * zeta * wn * s + wn^2);

collect(simplify(DP))

% Since DP = s^3 + 5*s^2 + 7*s + 3 = ... 
%          = s^n + p1 s^(n-1) + p2 s^(n-2) + ... + pn

p1 = 5;
p2 = 7;
p3 = 3;

p = [p1 p2 p3];

%---------------------------------------------------
% Control design
%---------------------------------------------------

Wr_tilde = [1 a1 a2; 0 1 a1; 0 0 1 ]^(-1);

K = [p - ap] * Wr_tilde * Wr^(-1)

A1 = Ag - (Bg * K);
kr = 1; % -(Cg * (A1)^(-1) * Bg)^(-1)

%---------------------------------------------------
% Closed-loop poles
%---------------------------------------------------

% Check if poles are corectly placed.

clp = eig(A1)

%---------------------------------------------------
% Simulink, Step response
%---------------------------------------------------

% Chance matrices C and D for Simulink
A = Ag;
B = Bg;
C = eye(3);
D = [0 0 0]';

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

