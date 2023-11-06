function [idiffs, iotherss, iselfs, topidx] = get_ICCranking(ICCmat, FC1, FC2, g, steps)
% ranks ICC matrix of given group and computes idiff, iself, iothers from
% an increasingly larger number of top rank ICC edges.
%
% Parameter
% ---------
% ICCmat (double: numRois x numRois): ICC value for each FC edges
% FC1 (double: numRois x numRois): first-half FC
% FC2 (double: numRois x numRois): second-half FC
% g (double: numSubs x 1): treatment group assignments
% steps (int: 1 x numSteps): number of edges to include at each step
%
% Outputs
% -------
% idiffs (double): Idiff of all subjects at each step
% iotherss (double): Iothers of all subjects at each step
% iselfs (double): Iself of all subjects at each step
% topidx (int): idiosyncrasy ranks of all edges, sorted
%

% make sure that steps don't exceed number of available edges in ICCmat
N = size(ICCmat,1);
E = N*(N-1)/2;
assert(max(steps)<=E, "maximum step must not exceed the number of unique edges in ICCmat.");

% vectorize ICC matrix
mask = triu(true(size(ICCmat, 1)),1);
ICCvec = ICCmat(mask); 

% keep track of the edge-indices in matrix format
matidx = find(mask);

% rank edges according to their ICC
ICCranks = floor(tiedrank(ICCvec));
% sort ranks to obtain indices of top ranks
[~, topidx] = sort(ICCranks, 'descend');

% preallocate output variables
numSubs = size(FC1, 3);
idiffs = zeros(numSubs, length(steps));
iselfs = zeros(numSubs, length(steps));
iotherss = zeros(numSubs, length(steps));

% compute the Idiff from the top 100, 200 ... all edges
for i = 1:length(steps)
    % matrix indices of edge selection from which to compute Idiff
    selection = matidx(topidx(1:steps(i)));

    % get first-half/ second-half FC, only including selected edges 
    fistFCvec = zeros(length(selection), numSubs);
    secondFCvec = zeros(length(selection), numSubs);
    for sub = 1:numSubs
       thisFC = FC1(:,:,sub);
       fistFCvec(:, sub) = thisFC(selection);
       thisFC = FC2(:,:,sub);
       secondFCvec(:, sub) = thisFC(selection);
    end
    
    % compute identifiability matrix
    idmat = corr(fistFCvec, secondFCvec);

    % compute idiff, iothers, iself
    [idf, iots, isf] = get_fingerprint(idmat, g);
    iselfs(:, i) = isf;
    iotherss(:, i) = iots; 
    idiffs(:, i) = idf;
end

%% more plots: avg idiff, iself, iothers

measures = {idiffs, iselfs, iotherss};
names = {'Idiff', 'Iself', 'Iothers'};

for m = 1:length(measures)
    figure; 
    hold on

    % get measure and name
    measure = measures{m};
    name = names{m};

    % psilocybin group
    avg = mean(measure(g, :)); % for plotting average I-diff
    sd = std(measure(g, :), 0, 1)/sqrt(sum(g));
    X = [steps fliplr(steps)]; % for plotting shaded sd patches
    Y = [avg+sd fliplr(avg-sd)];
    patch(X, Y, 'red', 'FaceAlpha', .2, 'EdgeColor', 'none', 'EdgeAlpha', .6) % plotting
    plot(steps, avg , '-r', 'lineWidth', 1.25) 
    
    % placebo group
    avg = mean(measure(~g, :)); % for plotting average I-diff
    sd = std(measure(~g, :), 0, 1)/sqrt(sum(~g));
    X = [steps fliplr(steps)]; % for plotting shaded sd patches
    Y = [avg+sd fliplr(avg-sd)];
    patch(X, Y, 'blue', 'FaceAlpha', .2, 'EdgeColor', 'none', 'EdgeAlpha', .6) % plotting
    plot(steps, avg , '-b', 'lineWidth', 1.25) 

    % label plot
    xlabel('number of edges')
    ylabel(name)
    grid on
    hold off 
end

%% clear outputs if not requested
if nargout<0
    clearvars
end

end

