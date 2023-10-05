clear, clf
%% data
load filtering_codeChallenge.mat

time = (0:length(x)-1)/fs;
hz = linspace(0,fs/2,floor(length(time)/2)+1);
%% plot
figure(1),clf
subplot(2,2,1:2)
plot(time,x,time,y,'k')
legend({'Original';'Filtered'})
title('Time domain')

xX = abs(fft(x)).^2;
yY = abs(fft(y)).^2;
subplot(2,2,3:4)
plot(hz,xX(1:length(hz)),hz,yY(1:length(hz)),'k')
legend({'Original';'Filtered(Original solution)'}),xlim([0 80])
title('F domain')

%%
%filter in two parts and add at the end
frange{1} = [5 16];
frange{2} = [26 32];


%draw boundryline in plot
colorz = 'rm';
hold on
for fi = 1:length(frange)
    plot([1 1]*frange{fi}(1),get(gca,'ylim'),[colorz(fi) '--'])
    plot([1 1]*frange{fi}(2),get(gca,'ylim'),[colorz(fi) '--'])
end

%filtered_signal = cell(2,1);
filtered_signal = zeros(length(x),2);

for filteri = 1:length(frange)
    order = round(14*fs/frange{1}(1));
    fkern = fir1(order,frange{filteri}/(fs/2));
    %filtered_signal{filteri} = filtfilt(fkern,1,x);
    filtered_signal(:,filteri) = filtfilt(fkern,1,x);

end
%add filtered signal
%fsig = filtered_signal{1} + filtered_signal{2}; 
fsig = filtered_signal(:,1) + filtered_signal(:,2); 
fsigX = abs(fft(fsig)).^2;

figure(2), clf
subplot(211)
plot(time,x,time,fsig,'k')


subplot(212)
plot(hz,xX(1:length(hz)),hz,fsigX(1:length(hz)),'k')
xlim([0 80])
legend({'Original';'Filtered by Prajol'})
title('F domain')

%method 2: filter the data between 5 and 35 Hz, and then notch out 20-25 Hz



