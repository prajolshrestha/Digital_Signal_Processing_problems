%% Measures of central Tendency

% Compute mean, median, mode of a log-normal distribution.

% learn: hist, sort, mean, median, mode, unique, max

%% data

data = round( exp(2+randn(101,1)/2));

figure(1), clf
histogram(data,20)

%% mean

n = numel(data);
m1 = sum(data) / n

m = mean(data)

%% median

datasort = sort(data);
med1 = datasort(ceil((n/2)+1)) %ceil, round, floor, fix

med = median(data)

%% mode
u = unique(data);
numnums = zeros(size(u));
for i =1: length(u)
   numnums(i) =  sum(data == u(i));
end

[~,maxidx ] = max(numnums);
mo1 = u(maxidx)
%shortcut
mo = mode(data)

%% Plot

hold on

plot([1 1]*m, get(gca,'YLim'),'k--','linew',.5)
plot([1 1]*med, get(gca,'YLim'),'r--','linew',.5)
plot([1 1]*mo, get(gca,'YLim'),'g--','linew',.5)

legend({'Data';'mean';'median';'mode'})
xlabel('value'),ylabel('Count')





