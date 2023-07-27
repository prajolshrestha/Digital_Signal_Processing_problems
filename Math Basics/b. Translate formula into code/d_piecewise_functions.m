%% Piecewise Function

x = linspace(-10,20,1000);
y = zeros(size(x));

for i = 1: length(x)

    % piece 1
    if x(i)<-1
        y(i) = sin(2*pi*x(i)*4);
    % piece 2
    elseif x(i)> -1 && x(i)<= 0
        y(i) = 0;

    % piece 3
    elseif x(i)> 0 && x(i)<= 3
        y(i) = x(i);

    % piece 4
    elseif x(i)> 3 && x(i)<= 10
        y(i) = exp(x(i)./10);
        
    % piece 5
    elseif x(i)> 10
        y(i) = 1 - x(i) ./10;
    end
end

figure(1),clf
plot(x,y,'r-^')
title('Piecewise Function')

%% dsearchn

t = [1 3 4 5 6 7];

find(t ==4)
find(t == 4.01) % nope

idx = dsearchn(t',4.01);
t(idx)


%% better way to built a piecewise function

% find idx of breakpoints
xidx = dsearchn(x',[-1 0 3 10]');

% piece 1
y(1:xidx(1)) = sin(2*pi*4*x(1:xidx(1)));

% piece 2
y(xidx(1)+1:xidx(2)) = 0;
% piece 3
y(xidx(2)+1:xidx(3)) = x(xidx(2)+1:xidx(3));
% piece 4
y(xidx(3)+1:xidx(4)) = exp(x(xidx(3)+1:xidx(4))/10);
% piece 5
y(xidx(4)+1:end) = 1 - x(xidx(4)+1:end)./10;

figure(2),clf
plot(x,y,'r-^')
title('Piecewise Function')


%% Another example

t = -3:.01:3;

tidx = [1 dsearchn(t',0) length(t)];

f(tidx(1):tidx(2)) = sin( t(tidx(1):tidx(2)) );

f( tidx(2)+1:tidx(3) ) = t( tidx(2)+1:tidx(3) );

figure(3),clf
plot(t,f)

% shortcut

f2 = (t<=0).* sin(t) + (t>0) .* t;

figure(4),clf
plot(t,f2)



















