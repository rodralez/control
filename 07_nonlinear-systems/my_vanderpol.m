
close all
clc
clear all

fs = 15;
fs1 = 13;
lw = 2.5;

tspan = [0, 20];
mu = 1;
ode = @(t,x) [x(2); mu*(1-x(1)^2)*x(2)-x(1)];
% suma = @(x1,x2) (x1 + x2);

x0 = [0; 0];

[~, x] = ode45(ode, tspan, x0);



%% Plot of the solution
subplot(2,2,1)
plot(x(:,1), x(:,2), 'Linewidth', 2), hold on, plot(x(1,1), x(2,2), 'or', 'Linewidth', lw)
set(gca,'fontsize', fs1)
xlabel('X1')
ylabel('X2')
title('Oscilador de Van der Pol, \mu = 1, x0 = [0; 0]', 'FontSize', fs)

x0 = [2; 0];
[~, x] = ode45(ode, tspan, x0);

subplot(2,2,2)
plot(x(:,1), x(:,2), 'Linewidth', 2), hold on, plot(x(1,1), x(2,2), 'or', 'Linewidth', lw)
set(gca,'fontsize', fs1)
xlabel('X1')
ylabel('X2')
title('Oscilador de Van der Pol, \mu = 1, x0 = [2; 0]', 'FontSize', fs)


x0 = [2; 2];
[~, x] = ode45(ode, tspan, x0);

subplot(2,2,3)
plot(x(:,1), x(:,2), 'Linewidth', 2), hold on, plot(x(1,1), x(2,2), 'or', 'Linewidth', lw)
set(gca,'fontsize', fs1)
xlabel('X1')
ylabel('X2')
title('Oscilador de Van der Pol, \mu = 1, x0 = [2; 2]', 'FontSize', fs)

x0 = [-2; -2];
[~, x] = ode45(ode, tspan, x0);

subplot(2,2,4)
plot(x(:,1), x(:,2), 'Linewidth', 2), hold on, plot(x(1,1), x(2,2), 'or', 'Linewidth', lw)
set(gca,'fontsize', fs1)
xlabel('X1')
ylabel('X2')
title('Oscilador de Van der Pol, \mu = 1, x0 = [-2; -2]', 'FontSize', fs)
