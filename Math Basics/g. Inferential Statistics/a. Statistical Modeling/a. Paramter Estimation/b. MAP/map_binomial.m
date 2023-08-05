%% MAP for Binomial Distribution (extension of Bernoulli Distribution)

% Sample binary data (0s and 1s)
data = [0, 1, 0, 1, 1, 1, 0, 0, 1, 1];

% Number of trials (total number of data points)
n_trials = length(data);

% Number of successes (number of 1s in the data)
n_successes = sum(data);

% Define the likelihood function for a Binomial distribution
likelihood = @(p) binopdf(n_successes,n_trials,p);

% Initial guess for the probability parameter (p)
initial_p = n_successes / n_trials;

% Prior information (Beta distribution as a conjugate prior for Binomial)
alpha_prior = 2;    % Prior shape parameter (pseudo-counts for successes)
beta_prior = 2;     % Prior shape parameter (pseudo-counts for failures)

% Define the prior function for the probability parameter p (Beta distribution)
prior = @(p) betapdf(p, alpha_prior, beta_prior);

% Define the posterior function (posterior = likelihood * prior)
posterior = @(p) likelihood(p) .* prior(p);

% Define the negative log-posterior function for minimization
neg_log_posterior = @(p) -log(posterior(p));

% Perform Maximum A Posteriori (MAP) estimation using fminsearch
estimated_p = fminsearch(neg_log_posterior, initial_p);

disp(['Estimated probability parameter (p): ', num2str(estimated_p)]);

%% Plot

x_values = linspace(0,1,1000);
pdf_values = posterior(x_values);
plot(x_values,pdf_values)
xlabel('Probability Parameter (p)');
ylabel('Probability Density');
title('Posterior Distribution (MAP) for Binomial Distribution');
grid on;











