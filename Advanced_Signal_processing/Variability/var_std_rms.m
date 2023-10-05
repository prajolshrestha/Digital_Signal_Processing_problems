clear, clf
%% 
n =2000;
p = 20;

%amplitude modulator
ampmod = interp1(rand(p,1)*30, linspace(1,p,n),'nearest')';
ampmod = ampmod + mean(ampmod)/3*sin(linspace(0,6*pi,n))';

signal = ampmod .* randn(size(ampmod));
signal = signal + linspace(-10,20,n)'.^2;

figure(1),clf,hold on
plot(signal)
plot(signal -mean(signal))
legend({'signal';'mean centered signal'})
%% compute windowed variance

k = 25;
[var_ts,std_ts,rms_ts] = deal(zeros(n,1));

for i = 1:n
    low_bnd = max(1,i-k);
    up_bnd = min(n,i+k);

    tempsig = signal(low_bnd:up_bnd);
    
    %var
    var_ts(i) = var(tempsig);
    
    %std
    std_ts(i) = std(tempsig);

    %rms
    rms_ts(i) = sqrt(mean(tempsig.^2));


end

figure(2),clf,hold on
plot(var_ts,'k')
plot(std_ts,'r')
plot(rms_ts,'b')
legend({'variance';'std';'RMS'})















