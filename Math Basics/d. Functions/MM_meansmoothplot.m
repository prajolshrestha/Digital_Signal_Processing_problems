function y = MM_meansmoothplot(x,varargin)
%  y = MM_meansmoothplot(x,varargin)
% Smooth an input vector, and optionally make a plot of the data.
%
% INPUTS:
%        x - (required) vector to smooth
%        k - (required) smoothing kernel (default:5)
% makeplot - (optional) 1 for plot, 0 for no plot (default:0)
%    title - (optional) string for the plot title
%
%
% OUTPUT:
%      y - smoothed vector
%
% SHRESTHA, INC.

%% check input and assign default parameters

k = 5;
makeplot = 0;
plottitle = 'Title';

if length(varargin)>0 && ~isempty(varargin{1})
    k = varargin{1};
end

if length(varargin) > 1 && ~isempty(varargin{2})
    makeplot = varargin{2};
end
if length(varargin) > 2 && ~isempty(varargin{3})
    plottitle = varargin{3};
end

%% smooth the time series

kh = floor(k/2);
y = x;

for i = kh+1:length(x)-kh-1
    y(i) = mean( x(i-kh:i+kh));
end

%% make a plot if requested

if makeplot
    figure
    plot(1:length(x),x,1:length(y),y)
    title(plottitle)
    legend({'Original';'Smoothed'})
end


















