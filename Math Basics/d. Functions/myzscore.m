function y = myzscore(x,varargin)
% y = myzscore(x,varargin)
% 
% INPUTS:
%       x - (required) a vector or matrix    
%
%
% OUTPUT:
%       y - zscore of given vector or matrix
%
% SHRESTHA, Inc.

%% Error handeling
if ~isnumeric(x)
    error('Enter correct numeric values')
end


%% main 

m = mean(x);
s = std(x);
s1 = s;
s1(s1 == 0) = 1;
y = (x-m) ./ s1;


