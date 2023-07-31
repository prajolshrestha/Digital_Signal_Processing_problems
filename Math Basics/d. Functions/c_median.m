% Find and Extract a Function Core

%% edit median

x = randn(1001,1);
x = sort(x);
half = floor(length(x)/2);
y = x(half+1)