clear
close all
clc

% dot v = u - abs(v) * v 

u = 10; 
x1 = @ (t, v) (u - abs(v) * v);
[t1, y1] = ode45(x1, [0 3], 0);

u = 1; 
x1 = @ (t, v) (u - abs(v) * v);
[t2, y2] = ode45(x1, [0 3], 0);

figure
plot(t1, y1);
hold on
plot(t2, y2, '--g')
legend('u=10', 'u=1')