%Example 9.2
%Discrete Solution of Riccati Equation
%Optimal Tracking Control Problem
clc
clear
close all

A=[ 0 1; -1 -1 ];
B=[ 0; 1];
Q=[ 10 0; 0 1 ];
R=1;
F=[ 0.9859 -0.27; 0.08808 0.76677 ];
G=[ -0.9952 0.01409; -0.04598 -0.08808 ];
S=[ 0; 0];
Ts = 0.1;
N = 200;
[AD,BD] = c2d(A,B,Ts);
% AD =  expm(A*Ts);
% BD = F1 * B * Ts;
RD = (Ts*R);

K = zeros(N,2);
V = zeros(N,1);
RIN = zeros(N,2);

%Initialize
T = 0;
V(1) = 0;
P = [ 0 0; 0 0 ];
H = BD' * P;
X = RD + H*BD;
Y = H * AD;
K(1,:) = X \ Y;

%Discrete reverse-time solution of the Riccati equations (9.29)
%and (9.30)
%Discrete reverse-time solution of the state tracking equations
%(9.53) and (9.54)

for i=1:N
    
    L = Ts * Q + K(i,:)' * RD * K(i,:);
    M = AD - BD * K(i,:);
    PP1 = L + M' * P * M;
    
    %Value of Riccati matrix at time (N-(k'1))T
    RIN(i,:) = [ sin(0.6284*T); 0.6*cos(0.6284*T) ]';
    SP1 = F * S + G * RIN(i,:)';
    V(i+1) = -R^(-1) * B' * SP1;
    
    %Value of command vector at time (N-(k+1))T
    S = SP1;
    T = T + Ts;
    P = PP1;
    H = BD' * P;
    X = RD + H * BD;
    Y = H * AD;
    K(i+1,:) = X \ Y;
end

x = zeros(N,2);
x(1,:) = [0 0];
uop = zeros(N,1);

for i=1:N
    
    uop(i) = V(i) - K(i,:) * x(i,:)';
    x(i+1,:) = (AD * x(i,:)' + BD * uop(i))';    
end

t = 0:Ts:20;

figure
plot(t(1:end-1), RIN(:,1), '--r', t, x(:,1) )
title('X1')

figure
plot(t(1:end-1), RIN(:,2), '--r', t, x(:,2) )
title('X2')

figure
plot(t(1:end-1), uop)
title('UOP')

