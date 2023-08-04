%% Maximum likelihood estimation for Normal distribution

data =  [2.3, 3.1, 4.5, 2.8, 3.9, 3.0, 3.7, 4.1, 3.5, 2.6];

% define likelihood function for a normal distribution
likelihood = @(mu,sigma) prod(normpdf(data,mu,sigma)); %inline function define gareko

% initial guess for mean and std
initial_mu = mean(data);
initial_sigma = std(data);

% Define the negative log-likelihood function for minimization
neg_log_likelihood = @(params) -log(likelihood(params(1),params(2)));

% perform MLE using fminsearch
estimated_params = fminsearch(neg_log_likelihood,[initial_mu,initial_sigma]);

% extract the estimated mean and std
estimated_mu = estimated_params(1);
estimated_sigma = estimated_params(2);

disp(['Estimated mean (mu): ', num2str(estimated_mu)])
disp(['Estimated standard deviation (std): ', num2str(estimated_sigma)])
