% EJERCICIO 3

clc
clear
close all

%% Problem Description

At = [0 1;  0 -1;];

B = [0 1]';

C = [1 0 ];

D = 0;

H = [0 1]';

%% Specify the process noise covariance (Q), or how much dod you trust the model?

[n, p] = size(B);
Q = 0.1 * eye(p); % A number greater than zero

% Q = H * 0.1 * H';

%% Specify the sensor noise covariance (R), or how much dod you trust the output sensor?

[m, ~] = size(C);
R = 2 * eye(m); % A number greater than zero

%% 

dt = 0.5;
t = (0:dt:50)';
u = sin(t/5);

%% Generate process noise and sensor noise vectors:

N = length (t);

P_0 = diag([1 0.1].^2);     % Initial (prior) error covariance
x_0 = [2 0];                % Initial (prior) condition on the state

% Preallocate
X  = zeros(n, N);
Xn = zeros(n, N);

% Process noise sequence
MU = zeros (N, p);
v = mvnrnd (MU, Q);

% Propagate prior information
% Xn(:, 1) =  mvnrnd(x_0, P_0)';
% X(:, 1)  =  mvnrnd(x_0, P_0)';

Xn(:, 1) =  x_0;
X(:, 1)  =  x_0;

for i = 2:N
    
    A = expm(At * dt);
    
    Xn(:, i) = A * Xn(:, i-1) + B * u(i) + (v(i,:))';
    X (:, i) = A * X (:, i-1) + B * u(i);
end

%% Then, generate the noisy plant response:

% Preallocate
Y  = zeros(m, N);
Yn = zeros(m, N);

% Measurement noise sequence
MU = zeros (N, m);
w = mvnrnd (MU, R);

for i = 1:N
    
    Yn(:, i) = C * Xn(:, i) + (w(i,:))';
    Y(:, i)  = C * Xn (:, i) ;
end

%%  Next, implement the filter recursions in a FOR loop:

% Preallocation
Yk = zeros(length(t),1);
ycov = zeros(length(t),1);
Py = zeros(length(t),1);
Ke = zeros(n, length(t));
Xk = zeros(n, length(t));
xv = zeros(n, length(t));

x = Xn(:, 1);
P = P_0;

for i=2:length(t)
    
    % Prediction update
    A = expm(At * dt);
    x = A * x + B * u(i);    % x[n|n]
    P = A*P*A' + B*Q*B' * dt;     % P[n|n]
    
    xv(:,i) = x;
    
    % Time update
    K = P * C' / (C * P * C' + R);  % CAUTION: matrix inverse.
    x = x + K * ( Yn(i) - C*x);     % x[n|n-1]
    P = (eye(n) - K*C) * P;         % P[n|n-1]
    
    Xk(:,i) = x;
    Ke(:,i) = K;
    Yk(i) = C*x;
    Py(i) = C*P*C';
end
%% 

% Now, compare the true response with the filtered response:
figure
plot(t, Y, 'b', t, Yn, 'or', t, Yk, 'g--'),
xlabel('No. of samples'), ylabel('Output')
title('Response with time-varying Kalman filter')
legend('True', ' Noisy', 'Kalman')

figure
plot(t, Y-Yn,'r--', t, Y-Yk','g--'),
xlabel('No. of samples'), ylabel('Error')
legend('Noisy', 'Kalman')

%% 

figure
plot(t, Py, '-o' ), ylabel('Error Covar'),

%% Compare covariance errors:

diff_n = Y - Yn;
diff_k = Y - Yk';

% Root mean squarred error
rmse_n = sqrt(mean(diff_n .^2)) ;
rmse_k = sqrt(mean(diff_k .^2)) ;

%% 
% RMSE before filtering (measurement error):
%%
rmse_n
%% 
% RMSE after filtering (estimation error):
%%
rmse_k
%% 
% Kalman gain matrix
%%
figure
plot(t, Ke, '-o'), ylabel('Kalman Gain'),
legend('k1', 'k2')