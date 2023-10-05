%%
load denoising_codeChallenge.mat

figure(1),clf
subplot(211)
plot(origSignal)
title('Original Signal')

subplot(212)
plot(cleanedSignal)
title('Cleaned signal')

%% median
figure(2)
histogram(origSignal)

n = length(origSignal);
threshold = 5;
k_med = 20;
indx = find(abs(origSignal)>threshold);
filt_sig = origSignal;

for i = 1:length(indx)
    l_bound = max(1,indx(i)-k_med);
    u_bound = min(n,indx(i)+k_med);
    filt_sig(indx(i)) = median(filt_sig(l_bound:u_bound));

end

figure(3),clf
plot(filt_sig)

%mean
k_mean = 200;
for i = 1:n
    l_bound = max(1,i-k_mean)
    u_bound = min(n,i+k_mean)
    filt_sig(i) = mean(filt_sig(l_bound:u_bound));

end

figure(4),clf,hold on
plot(filt_sig)
plot(cleanedSignal)
%% gaussian
fwhm = 15; %try different points(5---95)

%normalized time vector in indices
k = 100;
gtime = -k:k;

%create gaussian window
gauswin = exp(- (4*log(2)*gtime.^2) / fwhm^2);
gauswin = gauswin / sum(gauswin);

% initialize filtered signal vector
filtsigG = origSignal;

%implement the weighted running mean filter
for i = k+1:length(origSignal)-k-1
    filtsigG(i) = sum(origSignal(i-k:i+k).*gauswin);
end

figure(5),clf
plot(filtsigG)

n = length(origSignal)
k_mean = 200;
for i = 1:n
    l_bound = max(1,i-k_mean)
    u_bound = min(n,i+k_mean)
    filtsigG(i) = mean(filtsigG(l_bound:u_bound));

end

figure(6),clf,hold on
plot(filtsigG)
plot(cleanedSignal)
legend({'Filtered sig';'Cleaned signal'})

