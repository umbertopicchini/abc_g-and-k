function y = gk_modelsimulate(bigtheta,n)
%simulate a vector of length n of independent realizations from the g-and-k distributon
% Input: - bigtheta: vector of parameters defining a g-and-k distribution
%        - n: the number of independent draws (realizations) from said distribution
% Output - y: a vector of length n 

% Umberto Picchini 2016
% www.maths.lth.se/matstat/staff/umberto/

A = bigtheta(1);
B = bigtheta(2);
g = bigtheta(3);
k = bigtheta(4);


z=randn(n,1);


y = A + B * (1 + 0.8 * (1-exp(-g*z))./(1+exp(-g*z))) .* (1 + z.^2).^k .* z;



end

