%% Maximum A Posteriori estimation for fitting a normal distribution:
%  to a set of datapoints with known prior info. about the parameters

%% Data
data =  [2.3, 3.1, 4.5, 2.8, 3.9, 3.0, 3.7, 4.1, 3.5, 2.6];

figure(1),clf
hist(data)


%%

% In Bayesian statistics, the prior distribution represents your beliefs or knowledge
% about the parameters before observing the data.
%
% When the prior information is strong (e.g., narrow prior distribution with low standard deviation), 
% it can have a significant influence on the estimated parameters. 
%
% On the other hand, when the prior information is weak (e.g., wide prior distribution with high std), 
% the data will have a larger impact on the estimation.

% Prior information about parameters (mean and std)
prior_mean = 3.0;
prior_std = 0.5;  % note: lower std ((low variance)narrow prob. distr.) means we have strong prior belief,
                  %       thus, impacts significant.

% Define prior function
prior = @(mu,sigma) normpdf(mu,prior_mean,prior_std) * (1/sigma);

% Define Likelihood function
likelihood = @(mu,sigma) prod(normpdf(data,mu,sigma));

% Define Posterior function (posterior = likelihood * prior)
posterior = @(mu,sigma) likelihood(mu,sigma) * prior(mu,sigma);

% Define negative log-likelihood function for minimization
neg_log_likelihood = @(params) -log(posterior(params(1),params(2)));

%initial guess for mean and std
initial_mu = mean(data);
initial_sigma = mean(data);
% perform MAP 
estimated_params = fminsearch(neg_log_likelihood,[initial_mu,initial_sigma]);

% Extract estimated mean and std
disp(['Estimated mean (mu): ', num2str(estimated_params(1))]);
disp(['Estimated std (sigma): ', num2str(estimated_params(2))]);



%% Plot 

% Generate x values and PDF values based on estimated parameters
x_values = linspace(min(data)-1, max(data)+1, 100);
pdf_values = normpdf(x_values, estimated_params(1), estimated_params(2));

figure(2),clf
plot(x_values,pdf_values);
xlabel('Data Points');
ylabel('Probability Density');
title('Normal Distribution PDF');
grid on;











