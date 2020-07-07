%---------------------------------------------------
% Vehicle steering 
% Pole placement design

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

%---------------------------------------------------
% Control design
%---------------------------------------------------

zeta=1;
wn=4;

K = [b*wn^2/v0^2 (2*zeta*wn*b/v0-a*b*wn^2/v0^2)];

kr = b*wn^2/v0^2;

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
% Closed-loop poles
%---------------------------------------------------

A1 = A - (B * K);

poles = eig(A1)

%---------------------------------------------------
% Simulink, Step response
%---------------------------------------------------

% Change matrices C and D for Simulink

C=eye(2);
D=[0 0]';

TStart = 0;
TFinal = 30;

time = sim('VehicleSteering_sim.slx', [TStart TFinal] );

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
