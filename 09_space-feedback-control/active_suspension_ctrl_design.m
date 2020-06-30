clc
clear
close all

load roaddist.mat

%---------------------------------------------------
% Ejercicio 5
%---------------------------------------------------

mc = 401;                         % Quarter car mass [kg]
mw = 48;                          % Wheel mass [kg]
ds = 2200;                        % Suspension damping coefficient [Ns/m]
cs = 23000;                       % Suspension spring coefficient [N/m]
cw = 250000;                      % Wheel spring coefficient [N/m]
tau = 0.001;                      % Actuator time constant [s]

%---------------------------------------------------
% The active suspension model
% A, B, C, and H matrices
%---------------------------------------------------

% A = ;
% B = ;  
% C = ;
% H = ;  

%---------------------------------------------------
% Enter your control design here
%---------------------------------------------------

% Qx =
% Qu =
% K =

%---------------------------------------------------
% For simulation purposes (do not modify)
%---------------------------------------------------

B1 = [B H];                   % Put the B and H matrix together as one matrix B1 (for Simulink implementation purposes) 
C1 = eye(5);                  % Output all state variables from the model
D1 = zeros(5,2);              % Corresponding D matrix
