%data
a = complex(4,3)
b = complex(7,8)

% all operation are done by matlab

%add
z1 = a+b

%substract
z2 = a-b

%complex conjugate
acl = conj(a)

%magnitude squared
amag1 = a*conj(a)
amag2 = abs(a)^2

%mul
z3 = a*b

%division
z4 = a/b

%magnitude
amag3 =abs(a)

%phase
aphase = angle(a)

figure(1), clf
plot(real(a),imag(a),'s',MarkerSize=12,MarkerFaceColor='k')
xlim([-5,5]),ylim([-5,5])
title('cartesian coordinate system')
grid on,axis square
hold on

%draw line using polar notation
h = polar([0 aphase],[0 amag3],'r')

%only polar cordinates
figure(2),clf
h = polar([0 aphase],[0 amag3],'r')
title('polar or euler coordinate ')