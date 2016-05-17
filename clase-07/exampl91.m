%Example 9.1
%Continuous Optimal Linear Quadratic Regulator (LQR) Design

A = [ 0 1; -1 -2 ]
B = [ 0; 1]
Q = [ 1 0; 0 1 ]
R = [1]

[K,P,E] = lqr(A,B,Q,R)
