%% Replace Image Pixels in an intensity Range

% learn: imagesc, hist,repmat

%%

car = imread('car.jpg');

% sum all color dimensions
carS = sum(car,3);

figure(1),clf
subplot(311)
imagesc(car)
axis image, axis off

% show the histogram of intensoty values
subplot(312)
[y,x] = hist(carS(:),100);
plot(x,log(y),'k')
xlabel('Pixel Intensity'),ylabel('log-count')
title('Pixel intensity histogram')

% pick color range based on histogram
crange = [200 500];

% bonus: plot lines at the boundries
hold on 
%plot([1 1]*crange(1), get(gca,'ylim'),'r--')
%plot([1 1]*crange(2), get(gca,'ylim'),'r--')

plot([crange; crange],repmat(get(gca,'ylim'),2,1)','r--')%shortcut

% find those pixels in the image
inrange = carS>crange(1) & carS<crange(2);

% the new RGB values
newCvals = [200 20 255];

carNew = car;
% loop through color channels and replace
for i = 1:3
    temp = squeeze(car(:,:,i));

    %replace target pixels with the specific RGB values
    temp(inrange) = newCvals(i);

    % put thet temp sclice back to car matrix
    carNew(:,:,i) = temp;

end

subplot(313)
imagesc(carNew)
axis image, axis off








