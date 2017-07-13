function plotTrajectories(tspan)  
    global x0
    
    xBoundRight = 1;
    xBoundLeft = -1;
    yBoundTop = 1;
    yBoundBottom = -1;
    
    currentX = x0(1);
    currentY = x0(2);
    
    % look up safety radii in x and y directions
    [safeX, safeY] = lookUpSafetyRadius(x0(3), x0(4), 'safety_radii.dat');
    
    
    % will need to look safety radii for x-vel, y-vel? 
    % have another file for ODE_safetyActionDynamic?
    % where custom LQR will be used to emphasize stabilization of
    % veloctities
    % alernatively, maybe only one input signal can be allowed per interval
    
   

    % if we are too close to the obstacle start safety action]
    % since assume that the origin of the system is half way from either
    % constraint, then xBoundLeft is a negative number
    % for now ignore the negative direction abs(xBoundLeft - currentX) < safeX
    if (xBoundRight - currentX < safeX | yBoundTop - currentY < safeY)
        [t,y]=ODE_safetyActionStatic(tspan);
         fprintf(1, 'Executing safety action\n');
    else 
        [t,y]=ODE_model(tspan);
         fprintf(1, 'Free cruising mode\n');
    end
    
    
    % plot all 6 model state variables against time
%     ttls = {'x', 'y', 'x-vel', 'y-vel', 'roll', 'roll-vel'};
%     
%     for k = 1:6
%          subplot(3,2,k);
%       
%          plot(y(:,k), t)
%          hold on; 
%        
%          title(ttls{k});
%          ylabel('time');
%     
%     end 

    % plot x vs y in real time
    plot(y(:,1), y(:,2));
    hold on;
    xlabel('x');
    ylabel('y');
    
end