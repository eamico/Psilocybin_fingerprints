function [results] = make_figure03(FC1, FC2, config, yeo)
% Performs analysis and generates plots of figure 02.
%
% Parameter
% ---------
% FC1 (double: numRois x numRois): first-half FC
% FC2 (double: numRois x numRois): second-half FC
% config (struct): configuration parameters
%                  
% Outputs
% -------
% results (struct): outputs of all analyses
%

%% Figure 3A
% compute ICC matrices for each treatment group
ICCpsi = get_ICCmat(FC1(:, :, config.psilo), FC2(:, :, config.psilo));   % psilocybin
ICCpla = get_ICCmat(FC1(:, :, ~config.psilo), FC2(:, :, ~config.psilo)); % placebo

% plot thresholded ICC matrices
figure;
imagesc(ICCpsi(yeo.order, yeo.order)>0.6) 
set(gca, 'XTick', yeo.mids, 'XTickLabel', yeo.names, 'YTick', yeo.mids, 'YTickLabel', yeo.names)
title('figure 3A, psilocybin')
axis square

figure;
imagesc(ICCpla(yeo.order, yeo.order)>0.6); % [-0.2 0.8]);
set(gca, 'XTick', yeo.mids, 'XTickLabel', yeo.names, 'YTick', yeo.mids, 'YTickLabel', yeo.names)
title('figure 3A, placebo')
axis square

%% Figure 3B
% generate unique int for each pair of RSNs
yeomask = triu(yeo.subnetworks*yeo.subnetworks',1);

% names of the two RSNs in column 1; ICC values of all edges between 
% the two RSNs in psi and pla in column 2 and 3, respectively
yeoICCs = cell(yeo.nb,3);

% 7x7 matrix encoding the average ICC of each RSN-pair
rsnICC_psi = zeros(yeo.nb);
rsnICC_pla = zeros(yeo.nb);

n = 1;
for rsn1 = 1:yeo.nb
    for rsn2 = rsn1:yeo.nb
        eval(['yeoICCs{',num2str(n),',1} = ''',yeo.names{rsn1},'_',yeo.names{rsn2},''';'])
        eval(['yeoICCs{',num2str(n),',2} = ICCpsi(yeomask==',num2str(rsn1*rsn2),') ;'])
        eval(['yeoICCs{',num2str(n),',3} = ICCpla(yeomask==',num2str(rsn1*rsn2),') ;'])
        rsnICC_psi(rsn1,rsn2) = mean(ICCpsi(yeomask==rsn1*rsn2),'all');
        rsnICC_pla(rsn1,rsn2) = mean(ICCpla(yeomask==rsn1*rsn2),'all');
        n = n+1;
    end
end

% mirror to lower triangular matrix for plotitng
rsnICC_psi = triu(rsnICC_psi)+triu(rsnICC_psi, 1)';
rsnICC_pla = triu(rsnICC_pla)+triu(rsnICC_pla, 1)';

% matrix with diff of mean, sd and p value, and fdr for each RSN pair
statsmat = zeros(size(yeoICCs, 1), 4); 
for rsn_pair = 1:size(yeoICCs, 1)
    diff = yeoICCs{rsn_pair, 2}-yeoICCs{rsn_pair, 3}; % ICC of psilocybin edges - ICC of placebo edges
    [~, p] = ttest(diff);
    statsmat(rsn_pair, 1) = mean(diff);
    statsmat(rsn_pair, 2) = std(diff);
    statsmat(rsn_pair, 3) = p;
    clear p diff
end
statsmat(:, 4) = fdr(statsmat(:, 3));

% heatmap of differences of mean within-between yeo ICC between groups
figure;
imagesc(rsnICC_psi-rsnICC_pla, [-.2,.2]);
c = colorbar;
c.Label.String = 'RSN-average ICC';
colormap('bluewhitered')
set(gca, 'ytick', 1:yeo.nb, 'yticklabel', yeo.names)
set(gca, 'xtick', 1:yeo.nb, 'xticklabel', yeo.names)
title("figure 3B")
axis square

%% Figure 3C
% compute ICC strength for each brain region
ICCstrength_psi = sum(ICCpsi, 1)';
ICCstrength_pla = sum(ICCpla, 1)';

% boxplot of ICC sum differences in each subnetwork
x = ICCstrength_psi-ICCstrength_pla;
figure;
H=notBoxPlot(x, yeo.subnetworks, 'jitter', 0.5);
set([H.data],...
    'MarkerFaceColor',[1,1,1]*0.35,...
    'markerEdgeColor',[1,1,1]*0.35,...
    'MarkerSize', 3)
set(gca, "XTickLabel", yeo.names)
yline(0, '--')

% test ICC sum differences for each subnetwork against zero
iccstr_stats.pvals = zeros(yeo.nb,1);
iccstr_stats.tvals = zeros(yeo.nb, 1);
for i = 1:yeo.nb
    [~, p, ~, stats] = ttest(x(yeo.subnetworks==i));
    iccstr_stats.pvals(i) = p;
    iccstr_stats.tvals(i) =stats.tstat;
end
iccstr_stats.fdrs = fdr(iccstr_stats.pvals); % fdr correction
ylabel("ICC strength difference")
title("figure 3C")

%% figure 3E
% specify the steps for including edges
steps = 100:100:config.numEdges;

% compute toprank-ICC edge I-diff for placebo
[~, ~, ~, idiosyncraticEdges_pla] = get_ICCranking(ICCpla, FC1, FC2, config.psilo, steps);

% compute toprank-ICC edge I-diff for psilocybin
[~, ~, ~, idiosyncraticEdges_psi] = get_ICCranking(ICCpsi, FC1, FC2, config.psilo, steps);

%% Return outputs

if nargout>0
    % outputs from figure 3A
    results.A.ICCpsi = ICCpsi;
    results.A.ICCpla = ICCpla;
    % outputs from figure 3B
    results.B.ICCpsi = rsnICC_psi;
    results.B.ICCpla = rsnICC_pla;
    results.B.stats = statsmat;
    % outputs from figure 3C
    results.C.ICCstrength_psi = ICCstrength_psi;
    results.C.ICCstrength_pla = ICCstrength_pla;
    results.C.stats = iccstr_stats;
    % outputs from figure 3E
    results.E.idiosyncraticEdges_psi = idiosyncraticEdges_psi;
    results.E.idiosyncraticEdges_pla = idiosyncraticEdges_pla;
end

end

