function [idiff, iothers, iself] = get_fingerprint(idmat, g)
% Computes fingerprinting metrics idiff, iothers, iself.
%
% Parameters
% ----------
% idmat (double: numSubs x numSubs): identifiability matrix
% g (bool or int: 1 x numSubs): treatment group
%
% Output
% ------
% idiff (double: numSubs x 1): Idiff
% iothers (double: numSubs x 1): Iothers
% iself (double: numSubs x 1): Iself
%

% iself := similarity with self
iself = diag(idmat);

% iothers := similarity with others
iothers = zeros(size(iself));
for group = reshape(unique(double(g)), [1 length(unique(double(g)))])
   % compute group-specific idmat
    groupidmat = idmat(g==group, g==group);
    % compute iothers for each subject in that group
    k = 1; % subject index in groupidmat
    for sub = reshape(find(g== group), [1 length(find(g==group))])
        % mask-vector with 1s for iothers elements and 0 for the Iself element
        mask = ~true(size(groupidmat));
        mask(:, k) = true;
        mask(k, :) = true;
        mask(k, k) = false; % exclude iself element
        % average across all iothers values
        iothers(sub, 1) = mean(groupidmat(mask));
        k = k+1;
    end
end

% idiff := difference between iself and iothers
idiff = iself-iothers;

end

