close all;
metadata0max;

outbreak_threshold = 500;
condition_threshold = 5;

yline(condition_threshold, '-.','LineWidth',3)
% plot(table2array(metadata0max(1,7:16)))
hold on
for i = 1:200
    if metadata0max.R_B(i) > outbreak_threshold && metadata0max.hub_I(i) > condition_threshold
        plot(table2array(metadata0max(i,7:16)),'k:')
    elseif metadata0max.R_B(i) > outbreak_threshold && metadata0max.hub_I(i) < condition_threshold
        plot(table2array(metadata0max(i,7:16)),'ro-')
    elseif metadata0max.R_B(i) < outbreak_threshold && metadata0max.hub_I(i) > condition_threshold
        plot(table2array(metadata0max(i,7:16)),'bo-')
    elseif metadata0max.R_B(i) < outbreak_threshold && metadata0max.hub_I(i) < condition_threshold
        plot(table2array(metadata0max(i,7:16)),'g:')
    end
end

