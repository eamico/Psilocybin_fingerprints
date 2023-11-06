%% add paths, load configs and data
% run this while being inside /scripts/.
clearvars

% define paths
paths.main = fullfile(pwd, ".."); 
paths.data = fullfile(paths.main, "data");
paths.externals = '/home/hanna/Code/external/matlab';

% add dependencies, set configs, load data
prepare_environment;

%% figure 2 
[results_fig02] = make_figure02(FC1, FC2, config);

%% figure 3
[results_fig03] = make_figure03(FC1, FC2, config, yeo);
