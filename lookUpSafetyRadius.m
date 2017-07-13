% will need to update the input state variables to be compared against
% grided values
function [safeX, safeY] = lookUpSafetyRadius(xvel, yvel, file)
    gridData = importdata(file);   
    for i = 1:length(gridData)
        % will need to be careful here when dealing with corners
        if (abs(xvel)>=gridData(i, 1) & abs(xvel)<=gridData(i, 2) & abs(yvel)>=gridData(i, 3) & abs(yvel)<=gridData(i, 4))
            safeX = gridData(i, 5);
            safeY = gridData(i, 6);
        end 
    end
end
