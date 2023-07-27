%% Circular p-value and its Approximation

% Implement 2-parameter p-value computaion and its approximation
% for a range of input parameters

% learn: exp, sqrt, contourf

%% 

n = 1:100;
z = linspace(0,1,99);

[pfull,papprox] = deal(zeros(length(n),length(z)));

for ni = 1:length(n)
    for zi = 1:length(z)

        pfull(ni,zi) =  exp(sqrt(1+4*n(ni)+4*(n(ni).^2 - (n(ni)*z(zi)).^2))-(1+2*n(ni)));
        papprox(ni,zi) = exp(-n(ni)*z(zi).^2);
    end
end

figure(1),clf
subplot(131)
contourf(z,n,pfull,40,'linecolor','none')
colorbar
title('Full formula')
axis square
set(gca,'clim',[0 1])

subplot(132)
contourf(z,n,papprox,40,'linecolor','none')
colorbar
title('Approximation')
axis square
set(gca,'clim',[0 1])

subplot(133)
contourf(z,n,pfull-papprox,40,'linecolor','none')
colorbar
title('Difference')
axis square
set(gca,'clim',[-1 1]/20)


