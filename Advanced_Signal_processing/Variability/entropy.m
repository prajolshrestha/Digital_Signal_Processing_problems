clear,clf
%%
% generate data
N = 1000;
numbers = ceil( 8*rand(N,1).^2);

% get count and prob
u = unique(numbers);
probs = zeros(length(u),1);

for ui = 1:length(u)
    probs(ui) = sum(numbers == u(ui)) / N;
end

entropee = -sum(probs .* log2(probs+eps)); %eps to solve NAN error

figure(1),clf
bar(u,probs)
title(['Entropy= ' num2str(entropee)])
ylabel('Prob')

%% example2: spike times

%generate spike times series
[spikets1, spikets2] = deal(zeros(N,1));

%nnon random
spikets1( rand(N,1)>.9 ) = 1;

% equal probability
spikets2( rand(N,1)>.5 ) = 1; % last ma we get high entropy ie, 1

%probabilities
probs1 = [sum(spikets1==0) sum(spikets1==1) ] / N;
probs2 = [sum(spikets2==0) sum(spikets2==1) ] / N;

% compute entropy
entropee1 = -sum(probs1 .* log2(probs1+eps));
entropee2 = -sum(probs2 .* log2(probs2+eps));

figure(2),clf
subplot(211)
plot(1:N,spikets1,1:N,spikets2)

subplot(212)
bar([entropee1 entropee2])
set(gca,'xlim',[0 3],'XTickLabel',{'TS1';'TS2'})
ylabel('Entropy')

%% example3: analog time series

load v1_laminar.mat

%compute event-related potential
erp = mean(csd,3);

%number of bins
nbins = 50;

%initialize
entro = zeros(size(erp,1),1);

%compute entropy for each channel

for chani = 1:size(erp,1)
    %find boundries
    edges = linspace(min(erp(chani,:)),max(erp(chani,:)),nbins);

    %bin the data
    [nPerBin, bins] = histcounts(erp(chani,:),edges);
    
    %convert to probability
    probs = nPerBin ./ sum(nPerBin);

    %compute entropy
    entro(chani) = -sum(probs .* log2(probs+eps));
end

figure(3),clf
plot(entro,1:16,'ks-')
xlabel('Entropy')
ylabel('Channel')

% How to know good nbins?
% loop over bin counts
nbins = 4:50;

entro = zeros(size(erp,1),length(nbins));

for bini = 1: length(nbins)
    
    %compute entropy as above
    for chani = 1: size(erp,1)
        edges = linspace(min(erp(chani,:)),max(erp(chani,:)),nbins(bini));
        [nPerBin,bins] = histcounts(erp(chani,:),edges);
        probs = nPerBin ./ sum(nPerBin);
        entro(chani,bini) = -sum(probs .* log2(probs+eps));
    end
end

% image of entropy by channel and bin count
figure(4), clf
contourf(nbins,1:16,entro,40,'linecolor','none')
xlabel('Number of bins'), ylabel('Channel')
title('Entropy as a function of bin count and channel')
colorbar

% plot of the same data
figure(5), clf
plot(entro,1:16,'s-','linew',3,'markerfacecolor','w')
xlabel('Entropy'), ylabel('Channel')














