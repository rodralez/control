clc
clear
close all

%---------------------------------------------------
% Model parameters
%---------------------------------------------------

m=20000;                % Vehicle mass [kg]
k=2000;                 % Engine torque gain factor [Nm/rad]
r=4;                    % Gear ratio (for a specific gear) [-]
tau=0.8;                % Engine time constant [s]
g=9.82;                 % Gravity [m/s^2]
rho=1.2;                % Air density [kg/m^3]
CD=0.5;                 % Drag coefficient [-]
Af=4;                   % Front area [m^2]
rw=0.5;                 % Wheel radius [m]
f=0.015;                % Rolling resistance coefficient [-]\\

alpha = 2 * pi/180;

%---------------------------------------------------
% Equilibrium point 
%---------------------------------------------------
% x2e=                  % Vehicle velocity [m/s]
% x1e=                  % Wheel force [N]
% ue=                   % Pedal position [rad]
% de=                   % Slope [rad]

x2e=20;                 
x1e=0.5*rho*CD*Af*x2e^2+m*g*f;
ue=rw*x1e/k/r;
de=0;

%---------------------------------------------------
% Linear longitudinal vehicle dynamics model 
% A, B, C, D and H matrices
%---------------------------------------------------

A=[[-1/tau 0];[1/m -rho*CD*Af*x2e/m]];
B=[k*r/tau/rw 0]';
H=[0 -g]';
C=[0 1];
D=[0];

%-----------------------------------------------------
% Control design part
% Enter your control design here
%-----------------------------------------------------

omega = 0.6;
zeta = 1/sqrt(2);

syms s k1 k2 real

K = [k1 k2];

DP = s^2 + 2 * omega * zeta * s + omega^2;
DP = collect(simplify(DP))

CP = det (s*eye(2) - A + B*K);
CP = collect(simplify(CP))

% DP = s^2 + (3*2^(1/2)*s)/5 + 9/25
% CP = s^2 + (20000*k1 + 3131/2500)*s + 48*k1 + k2 + 3/1000
sol = solve( [ (3*2^(1/2))/5 == (20000*k1 + 3131/2500);  48*k1 + k2 + 3/1000 == 9/25 ] , [k1, k2] );

K = [ double(sol.k1) double(sol.k2) ]

A1 = A - (B * K);
kr = -(C * (A1)^(-1) * B)^(-1)

poles = eig(A1)

%---------------------------------------------------
% For simulation purposes (do not modify)
%---------------------------------------------------

B1=[B H];                   % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
C1=eye(2);                  % Output all state variables from the model
D1=zeros(2);                % Corresponding D matrix

TStart = 0;
TFinal = 100;

time = sim('CruiseCtrl_StateFeedback.slx', [TStart TFinal] );

figure
plot(velocity.time, velocity.signals.values)
grid on
title ("VELOCITY")

save_system('CruiseCtrl_StateFeedback.slx', 'CruiseCtrl_StateFeedback.mdl', 'ExportToVersion', 'R2014A_MDL')


