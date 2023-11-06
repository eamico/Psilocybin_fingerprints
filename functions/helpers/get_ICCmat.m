function [ICCmat] = get_ICCmat(FCtest, FCretest)
% computes ICC for each edge considering all subjects.

ICCmat = zeros(size(FCtest, 1));
for i = 1:size(FCtest,1)
    for j = 1:size(FCtest,1)
        if i~=j
            % M = numSubs x 2 (test/retest)
            M = [squeeze(FCtest(i,j,:)), squeeze(FCretest(i,j,:))];
            % Interclass correlation of this edge
            ICCmat(i,j) = ICC(M,'1-1');
        end
    end
end

end

