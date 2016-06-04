% an ABC-MCMC algorithm to estimate parameters of a g-and-k distribution.
% See for example Allingham-King-Mengersen 2009, Bayesian
% estimation of quantile distributions, Stat Comput 19.

% Here we use our own custom summary statistics, see gk_summaries.

% Umberto Picchini 2016
% www.maths.lth.se/matstat/staff/umberto/

rng(100);

% the ground-truth parameters
A=3;
B=1;
g=2;
k=0.5;

nobs = 10000; % number of observations in the dataset 
problem = 'gk';  % just a string for the problem at hand 

bigtheta_true = [A,B,g,k]; % the ground truth parameters

% generate data from the model (from g-and-k distributions in this case)
data = feval([problem, '_modelsimulate'],bigtheta_true,nobs); 

%::::::::::::::::::::::: end of data generation :::::::::::::::::::::::

%          A          B           g        k
parbase = [5          5           3        2  ]; % starting values for the parameters
parmask = [1          1           1        1  ]; % put 1 for parameters to estimate, 0 otherwise

bigtheta = parbase;

%::: PILOT ABC settings ::::::::::::::::::::::::::::::::::::::::::::::::::
updatethreshold = [10000 20000]; % iterations where we want the ABC treshold to be decreased
threshold_vec = [5 3 1]; % values of the ABC thresholds 
R_mcmc = 50000; % number of ABC-MCMC iterations
step_rw = [0.1 0.1 0.1 0.1];  % starting standard deviations for the 
weights = ones(1,5);  % summary statistics weights for a first pilot run of abcmcmc. For further runs read below.
lengthCovUpdate = 500; % how often we update the covariance for the parameters proposal function (adaptive Gaussian random walk)
%::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::

if R_mcmc <= max(updatethreshold)
    error('MCMC iterations R_mcmc should be larger than the last element in updatethreshold.')
end

% an intial pilot useful to determine weights to normalize the summary statistics
[ABCMCMC_pilot,summaries] = abcmcmc(problem,data,bigtheta,parmask,parbase,nobs,threshold_vec,updatethreshold,R_mcmc,step_rw,weights,lengthCovUpdate);

%:::: FINAL ABC-MCMC settings :::::::::::::::::::::::::::::::::::::::::::
% now compute more appropriate weights for the summary statistics
weights = mad(summaries(30000:end,:)); % discard some burnin output
threshold_vec = [0.2 0.05 0.02 0.01];  % with the new weights we can also change the ABC thresholds
updatethreshold = [10000 20000 30000]; % iterations where we want the ABC treshold to be decreased
% Notice we could of course make use of a better starting bigtheta by
% looking at the previous output. Out of lazyness, we just leave it as it is...
ABCMCMC = abcmcmc(problem,data,bigtheta,parmask,parbase,nobs,threshold_vec,updatethreshold,R_mcmc,step_rw,weights,lengthCovUpdate);

subplot(2,2,1)
plot(ABCMCMC(:,1))
subplot(2,2,2)
plot(ABCMCMC(:,2))
subplot(2,2,3)
plot(ABCMCMC(:,3))
subplot(2,2,4)
plot(ABCMCMC(:,4))
