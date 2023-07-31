function [dx,ddx] = diffx(x)
% [dx,ddx] = diffx(x)
% 
% Return the first and second derivatice of the input signal x
% with the same size as vector x. Final values are repeated.
%
% INPUT:
%              x - must be a numeric vector
% OUTPUTS:
%              dx - 1st derivative of x
%              ddx - 2st derivative of x
%
% SHRESTHA, Inc.
%

%% do input checks

if ~isnumeric(x)
    help diffx
    error('Input must be numeric')
end

if sum(size(x)>1)>1
    help diffx
    error(' Input must be a column vector.')
end

%% force the vector to be a column input

%x= x(:);

%% compute the 1st derivative

dx = diff(x);
dx = [dx dx(end)];

%% Compute the 2nd derivative

ddx = diff(x,2);
ddx = [ddx ddx(end)];
















