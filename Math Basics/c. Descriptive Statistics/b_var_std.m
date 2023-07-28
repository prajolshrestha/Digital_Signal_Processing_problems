% Variance and std

%learn: var, std
%% data

data = round( exp(2+randn(101,1)/2));

figure(1), clf
histogram(data,20)

%% 

v = var(data);

%% 

s = std(data);

%% Exercies: Generate 5 random integers with variance 10.

v1 = sqrt(10).*randn(1,5)
v1 = round(v1)
std(v1),var(v1)
v1a = sort(v1,'ascend');
v1d = sort(v1,'descend');



