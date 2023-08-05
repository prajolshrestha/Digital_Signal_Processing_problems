%% MAP for Poisson Distribution
% parameter λ represents the average rate of occurrences.

% When we use a Gamma prior for λ, 
% it means we are expressing our prior belief that λ follows a Gamma distribution
% with shape parameter α_prior and rate parameter β_prior. 
% The choice of these hyperparameters (α_prior and β_prior) depends on 
% the prior knowledge or assumptions about the rate of occurrences. 
% A Gamma distribution allows for a flexible range of prior beliefs, 
% as it can take on various shapes, including exponential and uniform distributions as special cases.

% Sample data (count data following Poisson distribution)
data = [3, 1, 4, 2, 5, 2, 6, 3, 5, 2];
n = length(data);

%%
% Define Prior distribution
alpha_prior = 1; % Prior shape parameter % large means non-informative
beta_prior = 1; %Prior rate parameter % large means non-informative
prior = @(lambda) gampdf(lambda, alpha_prior, 1/beta_prior); 

% Define likelihood function 
likelihood = @(lambda) prod(poisspdf(data,lambda));

% Define Posterior and neg_log for minimization
posterior = @(lambda) prior(lambda) * likelihood(lambda);
neg_log_posterior = @(lambda) -log(posterior(lambda));

% Perform MAP 
initial_lambda = mean(data);
estimated_lambda = fminsearch(neg_log_posterior,initial_lambda);
disp(['Estimated Poisson Parameter (lambda): ' num2str(estimated_lambda)])

%% Plot

x_values = linspace(0.01,20,1000);
pmf_values = gampdf(x_values,estimated_lambda);
%posterior_pdf = posterior(lambda_values);
%normalized_posterior_pdf = posterior_pdf / trapz(lambda_values, posterior_pdf);
figure(1),clf
bar(x_values,pmf_values)
xlabel('Count Values')
ylabel('Probability')
title('MAP for Poisson Distribution (PMF)')
