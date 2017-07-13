function [t,x] = ...
    ODE_model(tspan)
global x0 u1 u2 K m g
n0 = 55;
d0 = 70;
d1 = 17;

dynamics = @(t, y)[y(3); 
                   y(4);
                   (K*u1/m )*sin(y(5)); 
                   -g + (K*u1/m)*cos(y(5)); 
                   y(6); 
                   n0*u2-d0*y(5)-d1*y(6)];
               
[t,x] = ode45(@(t,x) dynamics(t,x), tspan, x0);

% initial conditions for the next iteration of the solver are where we left
% off
x0 = x(length(x), :);
end