% Find the Point Closest to a Specified Value

% learn: min-abs,dsearchn,ind2sub

%% Vector Example 1
list = 1:5;

% find index
find(list == 3)

find(list == 3.1)

%% Vector Example 2
loglist = logspace(log10(1), log10(10), 58);

figure(1),clf
subplot(211)
plot(loglist,'o-')
plot(loglist - 4,'s-')
plot(abs(loglist-4),'s-')

% method 1
[val,idx] = min(abs(loglist-4));
loglist(idx)

% method 2: Euclidean distance
[val,idx] = min(sqrt( (loglist -4).^2));
loglist(idx)

% method 3
find(loglist == 4)%none
idx = dsearchn(loglist',4)

hold on
plot(idx,loglist(idx),'ro',MarkerSize=10,MarkerFaceColor='r')

subplot(212),hold on
plot(loglist,'s-')
plot(idx,loglist(idx),'ro',MarkerSize=10,MarkerFaceColor='r')
plot(get(gca,'xlim'), [1 1]*4,'k--')

%% Matrix Example 1:
m = 5;
n = 10;

%reshape our vector to matrix
A = reshape( loglist(1:m*n), [m,n]);

% above solution won't work here
%idx = dsearchn(A,4)

% try 'Vectorizing' the matrix
idx = dsearchn(A(:),4); %nope

% convert vector to matrix indices
[xi,yi] = ind2sub(size(A),idx); % gives row and column number

% now we can see the value at that element
A(xi,yi)

















