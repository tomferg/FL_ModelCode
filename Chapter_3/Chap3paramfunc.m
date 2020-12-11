function [rmsquardiff,predictions] = Chap3paramfunc(parameters,data,plot)
%Function for the Estimation of Parameters

%Estimation of Predictions
%This is just a regression equation
predictions = parameters(2) + parameters(1)*data(:,2);

%Root mean square difference
rmsquardiff = sqrt((sum(data-predictions).^2)/size(predictions));

if plot == 1
    %Plot ScatterPlot
    scatter(data(:,2),data(:,1),'MarkerEdgeColor',[0 0 0],...
        'MarkerFaceColor',[.5 .5 .5],'LineWidth',1);
    hold on
    plot(data(:,2),predictions,'Color',[0,0,0],'LineWidth',1.5);
    xlim([-2,2]);
    ylim([-2,2]);
    xlabel('X');
    ylabel('Y');
    pause; %Waits for button Press
    close all
end
end
