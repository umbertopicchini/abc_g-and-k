function out = gk_prior(theta)

% Returns the product of independent priors for parameters of a g-and-k distribution
% Input:  - theta, the vector of parameters to be estimated
% Output: - out, the product of the prior distributions set for each
% parameter.

% Umberto Picchini 2016
% www.maths.lth.se/matstat/staff/umberto/

A_prior      = unifpdf(theta(1), 0,10); 
B_prior      = unifpdf(theta(2), 0,10); 
g_prior      = unifpdf(theta(3), 0,10); 
k_prior      = unifpdf(theta(4), 0,10); 

out = A_prior*B_prior*g_prior*k_prior;




