% SIR_main.m
% Code to model Susceptible, Immune, and Recovered groups during  epidemic

% Define Initial Conditions - (ADJUST THIS SECTION)
S = 9; 
I = 1;
R = 0;
y0 = [S, I, R];

% Define Rate Constants - (ADJUST THIS SECTION)
b = 1/4; % Infection rate constant
k = 1/5; % recovery rate constant 
p = [b, k];

% Define Simulation Time - (ADJUST THIS SECTION)
Tspan = 25;

% Run Simulation
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
[T,Y] = ode45(@SIR_eqns,[0 Tspan],y0,options,p);

% Plot Results
key = ["susceptible", "infected", "recovered"]; 

figure()
set(gcf,'color','w', 'DefaultAxesFontSize',18);
plot(T, Y(:,1),'b',T,Y(:,2),'r',T,Y(:,3),'g','LineWidth',2)
legend(key)
xlabel("Time")
ylabel("# of People")


