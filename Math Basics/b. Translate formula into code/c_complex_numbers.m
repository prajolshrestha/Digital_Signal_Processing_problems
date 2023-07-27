%% complex numbers

a = 2;
b = -3;

c1 = a + 1i*b;
c2 = complex(a,b);


%% Euler's Formula

m = 3; %magnitude
p = 2*pi/3; %phase

e1 = m*exp(1i*p);
e2 = m * (cos(p) + 1i*sin(p));


%revover parameters
m1 = sqrt(real(e1)^2 + imag(e1)^2);
m2 = abs(e2);
 
p1 = atan(imag(e1)/real(e1));
p2 = angle(e2);








