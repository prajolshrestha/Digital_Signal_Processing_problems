%% Data Transformations

% learn: hist, sqrt, log, tiedrank, atanh

%% 
data = exp(2+randn(10000,1)/2);
[yo,xo] = hist(data,100);

% apply log
datalog = log(data);
[yl,xl] = hist(datalog,100);

% apply square root
datasqt = sqrt(data);
[ys,xs] = hist(datasqt,100);

% apply rank (order)
datarnk = tiedrank(data);
[yr,xr] = hist(datarnk,100);
 
figure(1), clf, hold on
plot(xo,yo,'k')
plot(xl,yl,'r')
plot(xs,xr,'g')
plot(xr,yr,'b')
xlim([0 100]), ylim([0 800])
legend({'Original';'Log';'Square root';'Ranked'})
xlabel('value'),ylabel('count')


%% Transform any distribution to Gaussian ('normal')

% rank transform the data
% scale the ranked values to a range of -1 to +1
% apply the inverse hyperbolic tangent

N  = 10000;

% create non normal data
data = linspace(100,.001,N) .* rand(1,N);

figure(2),clf
subplot(221)
plot(data)
title('Data')

subplot(222)
hist(data,round(N/2))
title('Data distribution')

% Now transform
% rank:
dataR = tiedrank(data);

% scale:
dataR = dataR/N; % scale to max of 1
dataR = dataR*2; % scale to 0 to 2
dataR = dataR - 1; % scale to [-1 1]

% inverse hyperbolic tangent
dataR = atanh(dataR);

subplot(223)
plot(dataR)
title('Transformed data')

subplot(224)
hist(dataR,round(N/20))
title('Transformed distribution')


























