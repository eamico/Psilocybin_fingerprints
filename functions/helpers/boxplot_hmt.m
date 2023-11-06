function [lm] = boxplot_hmt(x, g, z)
% Create boxplot with significance labels.
%
% Parameters
% ----------
% x = vector with data to plot;
% g = grouping variable;
% z = confounding factor (optional);

% test for group differences
g = double(g); % convert to double
if exist('z','var') && ~isempty(z)
    tbl = table(x, z, categorical(g), 'VariableNames', {'x', 'z', 'g'});
    lm = fitlm(tbl, 'x~g+z');
else
    tbl = table(x, categorical(g), 'VariableNames', {'x', 'g'});
    lm = fitlm(tbl, 'x~g');
end
% p-value of global group effect (after correction);
anova_results = anova(lm);
p_global = anova_results{'g', 5};

% make plot
figure;
H = notBoxPlot(x, g, 'jitter', 0.5);
set([H.data],...
      'MarkerFaceColor',[1,1,1]*0.35,...
      'markerEdgeColor',[1,1,1]*0.35,...
      'MarkerSize', 3)
title(strcat("p-value global effect =  ", num2str(p_global)))

% if we have sign. global effect, 
% label plot with asterisks to indicate sign. group differences
if p_global < 0.05
    % get scales of plot
    ymax = max(x); 
    ymin = min(x);
    yrange = ymax-ymin;
    ylim([ymin-0.05*yrange ymax+0.15*yrange])

    % get the "strength" of significance
    sign = get_asterisks(p_global);

    % label global effect in the middle of the plot
    xrange = get(gca, 'XLim');
    label = text(mean(xrange), ymax+0.1*yrange, sign, 'Fontsize', 16, 'Color', 'r');
    set(label,'HorizontalAlignment','center','VerticalAlignment','middle');

    % if we have more than 2 groups, check for pairwise differences
    groups = unique(g);
    numGroups = length(groups);
    if numGroups > 2

        % get pairwise differences
        [~, ~, stats] = anova1(x, g, 'off');
        c = multcompare(stats, 'Display', 'off');
        p_pairs = c(:, [1,2,6]); % [box1, box2, p-value]

        % label plot with pairwise differences
        ypos_line = ymax+0.025*yrange;
        d = yrange*(0.1-0.025);
        for i = 1:size(p_pairs, 1)
            % get the asterisks
            sign = get_asterisks(p_pairs(i, 3));
            % if it's significant, label plot
            if ~isempty(sign)
                ypos_ast = ypos_line+0.1*d;
                % set asterisk label
                label = text((p_pairs(i,1)+p_pairs(i,2))/2, ypos_ast, sign, 'Fontsize', 12, 'Color', 'k');
                set(label,'HorizontalAlignment','center','VerticalAlignment','middle');
                % indicate box pair with horizontal lines
                line([p_pairs(i,1) p_pairs(i,2)], [ypos_line ypos_line], 'Color', 'k')
                % increment ypositions to avoid overlap
                ypos_line = ypos_ast+0.15*d;
            end
        end
    end
end

% clear outputs, if not requested
if nargout == 0
    clear lm
end

%% anonymous function
    function sign = get_asterisks(pvalue)
            if pvalue < 0.001
                sign = '***';
            elseif pvalue < 0.01
                sign = '**';
            elseif pvalue < 0.05
                sign = '*';
            else
                sign = '';
            end
    end

end

