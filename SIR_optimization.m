% SIR_optimization.m
% Code to optimize parameters for model

% % % % % Experimental Data from BUGSS Lab - (ADJUST THIS SECTION WITH YOUR DATA)
texp = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10,11,12,13,14]'; % # of entries here should match length of S, I, R
Sexp = [20, 18, 14, 6, 2, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0]';
Iexp = [1, 3, 6, 11, 12, 12, 12, 10,10, 8, 2, 1, 1, 1, 0]';
Rexp = [0, 0, 1, 4, 7, 8, 9, 11, 11, 13, 19, 20, 20, 20, 21]';
yexp = [Sexp, Iexp, Rexp];


% Exerimental data from Finley Lab (DrEAMM Data)
% texp = [0:19]';
% Sexp = [15, 11, 7, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]';
% Iexp = [1, 5, 7, 10, 11, 9, 8, 4, 4, 3, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1]';
% Rexp = [0, 0, 2, 4,  5, 7, 8, 12, 12, 13, 14, 14, 14, 15, 15, 15, 15, 15, 15, 15]';
% yexp = [Sexp, Iexp, Rexp];

% Set initial parameter guesses and bounds
x0 = [1/4, 1/5]; % [b, k]
lb = [1/20, 1/20];
ub = [10, 10];

% Optimization
options = optimoptions('lsqnonlin','Display','iter');
optimal = lsqnonlin(@CostFxn,x0,lb,ub,options,texp,yexp);
%optimal = lsqnonlin(@CostFxn,x0,options,texp,yexp);
    
% Simulation
y0 = yexp(1,:);
p = optimal; %[b, k]
Tspan = max(texp);
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
[T_opt,Y_opt] = ode45(@SIR_eqns,[0 Tspan],y0,options,p);


% Plotting
key = ["Susceptible","Infected","Recovered"];
figure(1)
set(gcf,'color','w', 'DefaultAxesFontSize',18);
plot(texp, yexp(:,1),'bo',texp,yexp(:,2),'ro',texp,yexp(:,3),'go','LineWidth',2)
hold on
plot(T_opt, Y_opt(:,1),'b',T_opt,Y_opt(:,2),'r',T_opt,Y_opt(:,3),'g','LineWidth',2)
title(sprintf("Calculated infection rate (b) = %f, recovery rate (k) = %f", optimal(1), optimal(2)));
xlabel("Time")
ylabel("# of people")
legend(key)
hold off

optimal