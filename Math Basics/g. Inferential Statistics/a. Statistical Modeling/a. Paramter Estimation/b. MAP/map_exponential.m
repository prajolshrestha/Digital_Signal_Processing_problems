%% MAP for exponential distribution
% Sample data (assumed to follow an Exponential distribution)
data = [1.2, 2.5, 3.1, 0.9, 4.0, 2.2, 3.7, 1.8, 2.3, 3.9];

% Number of data points
n = length(data);

% Define the likelihood function for an Exponential distribution
likelihood = @(lambda) prod(exppdf(data, 1/lambda));

% Initial guess for the rate parameter (lambda)
initial_lambda = 1 / mean(data);

% Prior information (Gamma distribution as a conjugate prior for Exponential)
alpha_prior = 2;    % Prior shape parameter (pseudo-counts)
beta_prior = 1;     % Prior rate parameter (pseudo-rate)

% Define the prior function for the rate parameter lambda (Gamma distribution)
prior = @(lambda) gampdf(lambda, alpha_prior, 1/beta_prior);

% Define the posterior function (posterior = likelihood * prior)
posterior = @(lambda) likelihood(lambda) .* prior(lambda);

% Define the negative log-posterior function for minimization
neg_log_posterior = @(lambda) -log(posterior(lambda));

% Perform Maximum A Posteriori (MAP) estimation using fminsearch
estimated_lambda = fminsearch(neg_log_posterior, initial_lambda);

disp(['Estimated rate parameter (lambda): ', num2str(estimated_lambda)]);


%% plot
lambda_values = linspace(0.01,10,1000);
posterior_pdf = gampdf(lambda_values,estimated_lambda);
plot(lambda_values, posterior_pdf);
xlabel('Rate Parameter (\lambda)');
ylabel('Probability Density');
title('Posterior Distribution (MAP) for Exponential Distribution');
grid on;









