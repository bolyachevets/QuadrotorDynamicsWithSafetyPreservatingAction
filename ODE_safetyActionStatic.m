function [t,x] = ...
    ODE_safetyActionStatic(tspan)

global x0 K m g

n0 = 55;
d0 = 70;
d1 = 17;

% base thrust
u_0 = 0;

% linearize around u_0, u1_bar in Fig. 3 in Mitchell et al, 2016
u_0 = u_0 + g;

% linearize about roll angle theta_0 (rad), x5_bar in Fig. 3
theta_0 = 0;

% Based on dynamics used onboard a quadrotor at University of Berkley,
% linearized about roll angle theta_0 and total thrust (g + u0).

% my version of linearization

A = [0 0 1 0   0                      0;
     0 0 0 1   0                      0;
     0 0 0 0 K/m * u_0*cos(theta_0)   0;
     0 0 0 0 -K/m * u_0*sin(theta_0)   0;
     0 0 0 0   0                      1;
     0 0 0 0 -d0                    -d1; ];

B = [0                                              0;
     0                                              0;
     K/m * sin(theta_0)                             0;
     K/m * cos(theta_0)                             0;
     0                                              0;
     0                                             n0 ] ;

const = [ 0;
          0;
          -K/m * u_0 * theta_0 * cos(theta_0);
           K/m * u_0 * theta_0 * sin(theta_0) - g;
          0;
          0 ];
     
% Continuous LQR
Q = [8  0   8  0 0  0;
     0  8   0  0 0  0;
     8  0  16  0 0  0;
     0  0   0 16 0  0;
     0  0   0  0 1  0;
     0  0   0  0 0  1;];
R = diag([128 512]);
N = zeros(6,2);
% cost matrices were chosen to penalize x2 and u2

format long;
Gain = lqr(A, B, Q, R, N);

dynamics = @(t, y)[y(3); 
                   y(4);
                   (-K*Gain(1,:)*y/m + g)*sin(y(5)); 
                   -g + (g - K*Gain(1,:)*y/m)*cos(y(5)); 
                   y(6); 
                   -n0*Gain(2,:)*y-d0*y(5)-d1*y(6)];


[t,x] = ode45(@(t,x) dynamics(t,x), tspan, x0);

% initial conditions for the next iteration of the solver are where we left
% off
x0 = x(length(x), :);

end 
      
  