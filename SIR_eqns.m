function [dydt] = SIR_eqns(t,y,p)
% SIR Model equations

% Rename variables
S = y(1);
I = y(2);
R = y(3); 

b = p(1);
k = p(2);
 
% Equations
dydt = zeros(3,1);
dydt(1) = - b*S*I; 
dydt(2) = + b*S*I - k*I;
dydt(3) =         + k*I;
end

