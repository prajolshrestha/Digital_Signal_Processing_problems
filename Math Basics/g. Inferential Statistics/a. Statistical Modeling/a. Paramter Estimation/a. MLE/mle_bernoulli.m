%% ML for Bernoulli distribution

% sample binary data
data = [0,1,0,1,1,1,0,0,1,1];

% Number of data points
n = length(data);

% Define likelihood function
likelihood = @(p) prod(p.^data .* (1-p).^(1-data));

% initial guess for paramater : probability (p)
initial_p = sum(data)/n;

% Define the neg-log likelihood function
neg_log_likelihood = @(p) -log(likelihood(p));

% Perform MLE 
estimated_p = fminsearch(neg_log_likelihood,initial_p);

disp(['Estimated probability paramater(p): ' num2str(estimated_p)]);

%% plot

% Plot the distribution figure
x_values = [0, 1];  % Possible outcomes (0 and 1) for Bernoulli distribution
pmf_values = [1-estimated_p, estimated_p];  % Probability mass function values

figure(1),clf
bar(x_values, pmf_values);
xlabel('Outcomes');
ylabel('Probability');
title('Bernoulli Distribution PMF');
xticks([0, 1]);
xticklabels({'0', '1'});
ylim([0, 1]);
grid on;












