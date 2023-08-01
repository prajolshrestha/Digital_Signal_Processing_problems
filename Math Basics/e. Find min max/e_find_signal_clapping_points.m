%% Find signal clipping points

% learn: diff,mode,find

%%

t = linspace(0,4*pi,10000);
s = sin(2*t-pi/2);
s(s<0) = 0;
s = 1-s;

figure(1),clf
plot(t,s,'ks-')

%% find flat transitions
% try 1st and second derivatives and 
% then try change from modal values

sd2 = diff(s~=mode(s));

hold on
%plot(t(1:end-2),abs(sd2)*400,'r^-')

plot(t(1:end-1),abs(diff(s ~= mode(s))))

%
changeidx = find(sd2);
changeidx(sd2(changeidx)<0) = changeidx(sd2(changeidx)<0) +1;

%plot the circles where signal saturates
plot(t(changeidx),s(changeidx),'ro')










