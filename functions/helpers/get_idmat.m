function [idmat] = get_idmat(FC1, FC2)
% Computes identifiability matrix.
%
% Parameters
% ----------
% FC1 (mat: numRois x numRois x numSubs): first-half FCs of all subjects;
% FC2 (mat: numRois x numRois x numSubs): second-half FCs of all subjects;
%
% Output
% ------
% idmat (mat: numSubs x numSubs): identifiability matrix;
%

mask = triu(true(size(FC1, 1)),1);
for sub = 1:size(FC1, 3)
    firsthalf = FC1(:,:,sub);
    secondhalf = FC2(:,:,sub);
    % vectorize matrices
    firstvec(:,sub) = firsthalf(mask);
    secondvec(:,sub) = secondhalf(mask);
end

% compute identifiability by correlating test/retest FC
idmat = corr(firstvec, secondvec);

end


