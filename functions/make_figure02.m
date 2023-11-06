function [results] = make_figure02(FC1, FC2, config)
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

%% Figure 2A
% compute identifiability matrix
idmat = get_idmat(FC1, FC2);

% plot identifiability matrix
figure;
imagesc(idmat,[.3,.8]);
c = colorbar;
c.Label.String = 'Pearson''s r';
xlabel('Subjects (first-half)')
ylabel('Subjects (second-half)')
title('Identifiability')
axis square

%% Figure 2B
% compute idiff iself and iothers
[idiff, iothers, iself] = get_fingerprint(idmat, config.psilo);

% plot idiff, iothers, iself as boxplots (corrected for motion)
boxplot_hmt(idiff, config.psilo, config.scrubbing);
set(gca, 'XTickLabel', {'placebo', 'psilocybin'})
ylabel('Idiff')

boxplot_hmt(iothers, config.psilo, config.scrubbing);
set(gca, 'XTickLabel', {'placebo', 'psilocybin'})
ylabel('Iothers')

boxplot_hmt(iself, config.psilo, config.scrubbing);
set(gca, 'XTickLabel', {'placebo', 'psilocybin'})
ylabel('Iself')

%% Return outputs
if nargout>0
    results.idmat = idmat;
    results.idiff = idiff;
    results.iothers = iothers;
    results.iself = iself;
end

end

