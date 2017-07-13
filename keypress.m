% key control setup:
% left/right keys control u1
% up/down keys control u2
function keypress(varargin)
global u1 u2 K m g
u_base_range = [   g*m/K-0.5   g*m/K+0.5;      % u1-bound
                 -pi/16 pi/16;];    % u2-bound
u1_delta = 0.1;
u2_delta = pi/160;
key = get(gcbf,'CurrentKey');
if strcmp(key,'rightarrow')
    % incremenet u1
    if u1 < u_base_range(3)
        u1 = u1 + u1_delta
    end
elseif strcmp(key,'leftarrow')
    % decrement u1
    if u1 > u_base_range(1)
        u1 = u1 - u1_delta
    end
elseif strcmp(key,'uparrow')
    % increment u2
    if u2 < u_base_range(4)
        u2 = u2 + u2_delta
    end
elseif strcmp(key,'downarrow')
    % decrement u2
    if u2 > u_base_range(2)
        u2 = u2 - u2_delta
    end
end
end
