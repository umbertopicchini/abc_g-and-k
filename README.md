# abcmcmc_g-and-k

An example of ABC-MCMC algorithm to estimate parameters of a g-and-k distribution. 
We implement the example in Allingham et al 2009, except that we use our own custom summary statistics (see gk_summaries)
and use a Gaussian kernel to compare summary statistics for simulated and actual data.

Content:
- gk_run, the script running the example
- gk_summaries, defines the summary statistics
- gk_ prior, defines the prior distributions for the parameters to be estimated
- gk_modelsimulate, produces a realization from the g-and-k distribution
- abcmcmc, the ABC-MCMC algorithm. Uses a Gaussian kernel to compare summary statistics for simulated and actual data. Parameters are  
           proposed using the (on-line) adaptive Gaussian Metropolis random walk of Haario et al.
- cov_update, on-line covariance matrix update for the adaptive MCMC
- param_mask, param_unmask, utilities that extract free parameters from the vector of complete parameters and insert them back in the compete               vector of parameters.

References
- Allingham, King and Mengersen 2009, "Bayesian estimation of quantile distributions", Stat Comput 19.
- Haario, Saksman and Tamminen 2001, "An adaptive Metropolis algorithm", Bernoulli Volume 7, 223-242.
