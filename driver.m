global u1 u2 x0 K m g
K = 0.89;
m = 1.4;
g = 9.81;
u1 = g*m/K;
u2 = 0;
x0 = [0 0 0 0 0 0];
% samping frequency
t_delta = 0.3;

% initialize figure with key listener
fig = figure('KeyPressFcn',@keypress);

for i = 1:50
    % increment time interval for ode solver
    tspan = [t_delta*(i-1),t_delta*i];
    % plot the trajectory between sampled signals
    plotTrajectories(tspan)
    hold on
    % time delay to read input signal
    pause(2)
end 
%end