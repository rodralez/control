

s = tf('s');

tf1 = s^3 + 6* s^2 + 5*s - 30

% [y,t] = step (tf1)

% impulse (tf1)

num = [6.3223 18 12.811];
den = [1 6 11.3223 18 12.811];
step(num,den)
grid
title('Unit-Step Response')