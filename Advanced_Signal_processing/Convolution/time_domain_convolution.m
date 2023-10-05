clear,clf
%% convolution intuition
signal = [ zeros(1,30) ones(1,2) zeros(1,20) ones(1,30) 2*ones(1,10) zeros(1,30) -ones(1,10) zeros(1,40)];
kernel = exp( -linspace(-2,2,20).^2);
kernel = kernel ./ sum(kernel);

figure(1),clf
subplot(311)
plot(kernel,'k')
xlim([0 180])
title('Kernel')

subplot(312)
plot(signal,'k')
xlim([0 180])
title('Signal')

subplot(313)
plot(conv(signal,kernel,'same'))
title('Convolution')

%% more detail

signal = zeros(1,20);
signal(8:15) = 1;

kernel = [1 .8 .6 .4 .2];

%convolution size
nSign = length(signal);
nKern = length(kernel);
nConv = nSign + nKern - 1;

figure(2),clf
subplot(311)
plot(signal,'o-','MarkerFaceColor','g','MarkerSize',9)
set(gca,'ylim',[-.1 1.1],'xlim',[1 nSign])
title('signal')

subplot(312)
plot(kernel,'o-','MarkerFaceColor','r',MarkerSize=9)
set(gca,'ylim',[0 1.1],'xlim',[1 nSign])
title('Kernel')

subplot(313)
plot(conv(signal,kernel,'same'),'o-','MarkerFaceColor','b',MarkerSize=9)
set(gca,'ylim',[0 4])
title('Convolution Result')


%% Even more detail! (with animation)

half_kern = floor(nKern/2);
%flipped kernel
kflip = kernel(end:-1:1)-mean(kernel); %mean centered kernel gives edge detection

%zero padded signal for convolution
data4conv = [zeros(1,half_kern) signal zeros(1,half_kern)];

%initialize conv result
conv_res = zeros(1,nConv);

figure(3),clf,hold on
plot(data4conv,'o-',MarkerFaceColor='g',MarkerSize=9)
hkern = plot(kernel,'o-',LineWidth=2,MarkerFaceColor='r',MarkerSize=9);
hcres = plot(kernel,'s-',LineWidth=2,MarkerFaceColor='k',MarkerSize=15);
set(gca,'ylim',[-1 1]*3,'XLim',[0 nConv])
plot([1 1]*(half_kern+1),get(gca,'ylim'),'k--')
plot([1 1]*(nConv-half_kern),get(gca,'YLim'),'k--')
legend({'Signal';'Kernel (flip)';'Convolution'})

% run convolution
for ti = half_kern+1:nConv-half_kern
    % get chunk of data
    temp = data4conv(ti-half_kern:ti+half_kern);
    % compute dot product
    conv_res(ti) = sum(temp .* kflip);

    %update plot
    set(hkern,'XData',ti-half_kern:ti+half_kern,'YData',kflip);
    set(hcres,'XData',half_kern+1:ti,'YData',conv_res(half_kern+1:ti))

    pause(.5)
end

%cut off edges
conv_res = conv_res(half_kern+1:end-half_kern);

%% shortcut using matlab
figure(4), clf
matlab_conv = conv(signal,kernel-mean(kernel),'same');
plot(conv_res,'o-')
hold on
plot(matlab_conv,'o-')
legend({'Convolution'; 'Convolution (shortcut/matlab)'})
title('Time domain Convolution')
%they are same
































