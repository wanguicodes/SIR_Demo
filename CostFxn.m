function CostOut = CostFxn(params,texp,yexp)

% Define Initial Conditions
y0 = yexp(1,:); 

% Define Rate Constants
b = params(1);
k = params(2); 
p = [b, k];

% Define Simulation Time
Tspan = max(texp);

% Run Simulation
options = odeset('MaxStep',5e-2, 'AbsTol', 1e-5,'RelTol', 1e-5,'InitialStep', 1e-2);
[T,Y] = ode45(@SIR_eqns,[0 Tspan],y0,options,p);

for j=1:length(texp)
    teval = abs(T-texp(j));
    [tmin tindex] = min(teval);
    CostOut(j,:) = Y(tindex,:) - yexp(j,:);
end

end
