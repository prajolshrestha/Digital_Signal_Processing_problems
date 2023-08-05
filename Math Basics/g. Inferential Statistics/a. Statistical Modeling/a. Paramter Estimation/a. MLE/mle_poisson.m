%% MLE for Poission Distribution

% Sample data (count data following Poisson distribution)
data = [3, 1, 4, 2, 5, 2, 6, 3, 5, 2];
n = length(data);

% Define likelihood function & neg_log_likelihood
likelihood = @(lambda) prod(poisspdf(data,lambda));
neg_log_likelihood = @(lambda) -log(likelihood(lambda));

% Perform MLE
initial_lambda = mean(data);
estimated_lambda = fminsearch(neg_log_likelihood,initial_lambda);
disp(['Estimated Piossion Parameter (lambda): ' num2str(estimated_lambda)]);

%% Plot

x_values = unique(data);
pmf_values = poisspdf(x_values,estimated_lambda);
figure(1),clf
bar(x_values,pmf_values);
xlabel('Count values')
ylabel('Probability')
title('Poisson Distribution (PMF)')