function statistics = gk_summaries(y)
% computation of summary statistics
% Input: the "data" y (these are either the actual data or a realization
%                      from the assumed data-generating model).
% Output: a vector of summaries

% Umberto Picchini 2016
% www.maths.lth.se/matstat/staff/umberto/

statistics = [prctile(y,[20:20:80]');skewness(y)];

end
    


