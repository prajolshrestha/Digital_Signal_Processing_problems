%% Find negative extrema in a 2D function

% learn: log, bsxfun, min, max, sub2ind

%% 
x = linspace(-1,4.100);
y = linspace(-1,2,80);

f = abs(log(bsxfun(@times,x',y)));%matrix

figure(1),clf
surf(y,x,f)
shading interp
xlabel('x'),ylabel('y'),zlabel('f')

% Find max
[val,idx] = max(f); %max value of each column

maxval = max(max(f))
[xi,yi] = find(f == maxval)
f(xi,yi)


% Find min
minval = min(min(f))
[xi,yi] = find(f == minval)
f(xi,yi)

hold on
plot3(x(xi),y(yi),f(xi,yi)','ro',MarkerFaceColor='r',MarkerSize=12)

%% find points below a threshold of 0.01

[xi,yi] = find(f < minval + 0.01);
size(f(xi,yi))

% convert matrix indices to linear indices
idx = sub2ind(size(f),xi,yi);

plot3(x(xi),y(yi),f(idx)','ro',MarkerSize=12,MarkerFaceColor='r')








