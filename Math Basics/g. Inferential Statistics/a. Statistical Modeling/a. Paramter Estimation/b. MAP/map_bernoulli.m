%% MAP for bernoulli distribution

% Sample data
data = [0,1,0,1,1,1,0,0,1,1];
n = length(data);

%%
% % Define Prior distribution (simple mixture of two Bernoulli distributions)
% prior_p_0 = 0.8;
% prior_p_1 = 0.2; % if p_0 and p_1 is same  then its uninformative
% prior = @(p) prior_p_0 * (1-p) + prior_p_1 * p; %prior distribution is a simple mixture of two Bernoulli distributions with different prior probabilities for the two possible outcomes.  

% Define Prior distribution (Beta Distribution)
alpha_prior = 1; % Prior pseudo-counts for successes
beta_prior = 1; % Prior pseudo-counts for failures
prior = @(p) betapdf(p, alpha_prior, beta_prior);

% Define likelihood function
likelihood = @(p) prod(p.^data .* (1-p).^(data));

% Define Posterior Distribution & Define neg-log posterior
posterior = @(p) prior(p) * likelihood(p);
neg_log_posterior = @(p) -log(posterior(p));

% Estimate
initial_p = sum(data)/n;
estimated_p = fminsearch(neg_log_posterior,initial_p);

disp(['Estimated probability parameter (p): ' num2str(estimated_p)]);

%% plot

x_values = [0,1];
pmf_values = estimated_p.^x_values .* (1-estimated_p).^(1-x_values);

figure(1),clf
bar(x_values,pmf_values)
xlabel('outcomes')
ylabel('Probabillity')
title('Bernoulli Distribution (PMF)')
grid on

