close all;
metadata0

outbreak_threshold = 100;
condition_threshold = 10;

yline(condition_threshold, '-.','LineWidth',3)
% plot(table2array(metadata0(1,7:16)))
hold on
for i = 1:100
    if metadata0.R_B(i) > outbreak_threshold && metadata0.hub_I(i) > condition_threshold
        plot(table2array(metadata0(i,7:16)),'k:')
    elseif metadata0.R_B(i) > outbreak_threshold && metadata0.hub_I(i) < condition_threshold
        plot(table2array(metadata0(i,7:16)),'ro-')
    elseif metadata0.R_B(i) < outbreak_threshold && metadata0.hub_I(i) > condition_threshold
        plot(table2array(metadata0(i,7:16)),'bo-')
    elseif metadata0.R_B(i) < outbreak_threshold && metadata0.hub_I(i) < condition_threshold
        plot(table2array(metadata0(i,7:16)),'g:')
    end
end

