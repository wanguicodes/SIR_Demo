 % SIR_sensitivity.m
% Code to test sensitivity of Susceptible, Immune, and Recovered model to
% various parameters

% Define Initial Conditions - (ADJUST THIS SECTION)
S = 9; 
I = 1;
R = 0;
y0 = [S, I, R];

% Define Rate Constants - (ADJUST THIS SECTION)
b = 1/4; % Infection rate constant
k = 1/5; % recovery rate constant 
p = [b, k];

% Define Simulation & Sensitivity Conditions (ADJUST THIS SECTION)
Tspan = 19;

% Simulation Settings
ParamDelta = 0.10;
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);

% Base Case
p_base = [y0, p];
[T_base,Y_base] = ode45(@SIR_eqns,[0 Tspan],p_base(1:end-length(p)),options,p_base(end-length(p)+1:end));
[max_base maxind_base] = max(Y_base(:,2)); % maximum infected
tmax_base = T_base(maxind_base); % time when maximum people are infected


% Run Perturbation cases
max_pert = zeros(size(p_base));
tmax_pert = zeros(size(p_base));
Sens = zeros(2,length(p_base));

%figure()
%hold on
for i=1:length(p_base)
    p_pert = p_base;
    p_pert(i) = p_base(i)*(1+ParamDelta);
    [T_pert, Y_pert] = ode45(@SIR_eqns,[0 Tspan],p_pert(1:end-length(p)),options,p_pert(end-length(p)+1:end));
    [max_pert(i) maxind_pert] = max(Y_pert(:,2)); % maximum infected
    tmax_pert(i) = T_pert(maxind_pert); % time when maximum people are infected
    Sens(1,i) = ((max_pert(i) - max_base)/max_base)/ParamDelta;
    Sens(2,i) = ((tmax_pert(i) - tmax_base)/tmax_base)/ParamDelta;

    %plot(T,Y(:,2))
end

plabels = {'S_initial', 'I_initial', 'R_initial', 'infection_rate(b)', 'recovery_rate(k)'}';
Senslabels = {'Maximum Infected', 'Time Until Max Infected'}';

h2=figure; % heatmap figure
hm = heatmap(plabels, Senslabels, Sens);
set(gcf,'color','w');
hm.FontSize = 16;
xlabel("Parameter Varied (Input)")
ylabel("Metric Affected (Output)")
title("Normalized Sensitivity")


