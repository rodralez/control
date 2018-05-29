clc
clear
close all

%'K' and 'a' values to test
K = 2:0.2:3; 
a = 0.5:0.2:1.5; 

% Evaluate closed-loop unit-step response at each 'K' and 'a' combination
% that will yield the maximum overshoot less than 10%

t = 0:0.01:5;

Gp = tf([1.2],[0.36 1.86 2.5 1]);

k = 0;

MK = max(size(K));
MA = max(size(a));

solution = zeros(MK*MA, 3);

for i = 1:MK;
    for j = 1:MA;
        
        Gc = tf( K(i)*[1 2*a(j) a(j)^2], [1 0] ); % controller
        G = (Gc * Gp) / (1 + Gc*Gp); % closed-loop transfer function
        y = step(G,t);
        m = max(y);
        k = k+1;
        if m < 1.10
            solution(k,:) = [K(i) a(j) m];
        end
    end
end

ilx =  (solution(:,3) > 0 & solution(:,3) < 1.1);
% [f,~] = find ( min(solution(:,3)) );

SOL = solution(ilx, :);

% solution % Print solution table

sortsolution = sortrows(SOL,3) % Print solution table sorted by
% column 3

% Plot the response with the largest overshoot that is less than 10%
K = sortsolution(end,1)

a = sortsolution(end,2)

Gc = tf(K*[1 2*a a^2], [1 0]);
G = (Gc * Gp) / (1 + Gc*Gp);
figure
step(G,t)
grid % See Figure 8–20
