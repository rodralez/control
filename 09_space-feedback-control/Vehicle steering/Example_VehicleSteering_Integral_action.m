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

Au = [A zeros(2,1); C zeros(1) ]
Bu = [B; 0]
Cu = [0 1 0];
H = [0 0 -1]';

%---------------------------------------------------
% Reachability
%---------------------------------------------------

Wr = [Bu (Au * Bu) (Au^(2) * Bu) ];

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

CP = det(s*eye(3) - Au)

% Since CP = s^3 = ... 
%          = s^n + a1 s^(n-1) + a2 s^(n-2) + ... + an

a1 = 0;
a2 = 0;
a3 = 0;
ap = [a1 a2 a3];

%---------------------------------------------------
% Desired characteristic polynomial
%---------------------------------------------------

zeta=1;
wn=4;

pi = 3*wn*zeta;

DP = (s+pi) * (s^2 + 2 * zeta * wn * s + wn^2);

collect(simplify(DP))

% DP = s^3 + (3311*s^2)/250 + (42133163*s)/781250 + 36732234/390625
%    = s^n + p1 s^(n-1) + p2 s^(n-2) + ... + pn

p1 = (3311)/250 ;
p2 = (42133163)/781250;
p3 = 36732234/390625;

p = [p1 p2 p3];

%---------------------------------------------------
% Control design
%---------------------------------------------------

Wr_tilde = [1 a1 a2; 0 1 a1; 0 0 1 ]^(-1);

Ku = (p - ap) * Wr_tilde * Wr^(-1)

A1 = Au - (Bu * Ku);

%---------------------------------------------------
% Closed-loop poles
%---------------------------------------------------

% Check if poles are corectly placed.

poles = eig(A1)

%---------------------------------------------------
% Simulink, Step response
%---------------------------------------------------

% Change matrices for Simulink
C = eye(2);
D = [0 0]';

TStart = 0;
TFinal = 30;
 
time = sim('VehicleSteering_sim_Int.slx', [TStart TFinal] );

%---------------------------------------------------
% Plot
%---------------------------------------------------

figure
plot (time, u(:,2))
title ('Control signal')
grid on

figure
plot (time, x1.signals(1).values, '--')
hold on
plot (time, x1.signals(2).values)
title ('Lateral position')
grid on
legend('Reference', 'Lateral position')
