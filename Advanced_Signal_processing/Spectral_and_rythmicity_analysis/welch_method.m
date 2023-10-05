clear
%% data
load EEGrestingState.mat
n = length(eegdata); %120 seconds
timevec = (0:n-1)/srate;

figure(1),clf
plot(timevec,eegdata)
title('Time domain')

%% Normal FFT

eegdataX = fft(eegdata);
eegdataPow = abs(eegdataX/n).^2;
hz = linspace(0,srate/2,floor(n/2)+1);

figure(2),clf
plot(hz,eegdataPow(1:length(hz)))


%% Welch method "manual"

%window length
winlen = 1*srate;

%number of overlap
nOverlap = round(winlen/2);

% starting points of window
winonsets = 1:nOverlap:length(eegdata)-winlen;

% diff length signal require diff freq vector
hzw = linspace(0,srate/2,floor(winlen/2)+1);

%initialize
eegPow = zeros(1,length(hzw)); %half of window size
hannw = 0.5 - cos(2*pi*linspace(0,1,winlen))./2;

for i = 1:length(winonsets) %238 ota loop
    %each window ko data
    window = eegdata(winonsets(i):winonsets(i)+winlen-1);

    %hann window
    window = window .* hannw;

    %fft
    tempdata = abs(fft(window)/winlen).^2;
    
    % enter into matrix
    eegPow = eegPow + tempdata(1:length(hzw));

end

eegpoW = eegPow / length(winonsets);

figure(3),clf,hold on
plot(hz,eegdataPow(1:length(hz)),'k')
plot(hzw,eegpoW/10,'r')
set(gca,'xlim',[0,40])









%% Welch method "matlab function used"

figure(4),clf
winlen = 1*srate;
nfft = srate*1;
hannw= 0.5 - cos(2*pi*linspace(0,1,winlen))./2;

pwelch(eegdata,hannw,round(winlen/4),nfft,srate)
%set(gca,'xlim',[0,40])



