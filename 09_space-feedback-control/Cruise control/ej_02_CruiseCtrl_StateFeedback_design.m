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

Au = [A zeros(2,1); 
      C 0 ];

Bu = [ B ; 0 ];

Fu = [ 0 0 -1 ]';

Cu = [0 1 0];

% H=[0 -g 0]';

%-----------------------------------------------------
% Control design part
% ACKERMANN
%-----------------------------------------------------

omega = 0.6;
zeta = 1/sqrt(2);

syms s k1 k2 k3 real

% Open-loop charasteristic polynomial
CP = det ( s*eye(3) - Au );
CP = collect(simplify(CP))

% CP  = s^3 + (3131*s^2)/2500 + (3*s)/1000 + 0
a = [(3131)/2500 (3)/1000 0];  

% Desired charasteristic polynomial
DP = (s^2 + 2 * omega * zeta * s+ omega^2) * ( s + (3*zeta*omega) );
DP = collect(simplify(DP))

% DP = s^3 + (3*2^(1/2)*s^2)/2 + (36*s)/25 + (81*2^(1/2))/250
p = [ (3*2^(1/2))/2  (36)/25  (81*2^(1/2))/250];  

v = p - a;

Wr = [Bu Au*Bu (Au^2)*Bu];
rank_wr = rank(Wr);

if(rank_wr == 3)
    disp('The system is controllable.')
else
    disp('The system is not controllable.')
end

Wr_tilde = ( eye(3) + diag(ones(1,2)*a(1), 1) + diag(a(2), 2))^(-1);
    
Ku = v *  Wr_tilde * Wr^(-1)

A1 = Au - (Bu * Ku);    

% kr = -(Cu * (A1)^(-1) * Bu)^(-1)

poles = eig(A1)

%---------------------------------------------------`
% For simulation purposes (do not modify)
%---------------------------------------------------

B1=[B H];                   % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
C1=eye(2);                  % Output all state variables from the model
D1=zeros(2);                % Corresponding D matrix

TStart = 0;
TFinal = 100;

time = sim('CruiseCtrl_StateFeedback_Int.slx', [TStart TFinal] );

figure
plot(velocity.time, velocity.signals.values)
grid on
title ("VELOCITY")

figure
plot(control.time, control.signals.values)
grid on
title ("CONTROL ACTION")

save_system('CruiseCtrl_StateFeedback_Int.slx', 'CruiseCtrl_StateFeedback_Int.mdl', 'ExportToVersion', 'R2014A_MDL')

