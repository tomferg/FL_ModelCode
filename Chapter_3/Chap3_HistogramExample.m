%Chapter 3 Code - Histograms
clc;clear;close all;

%Parameter Set up
rec = [.93,.88,.86,.66,.47,.34];
ri = [.0035,1,2,7,14,42];
sParms = [1,.05,.7];

%Obtain Best Fit estimates using optimization
fun = @(sParms)chap3_powerdiscrep(sParms,rec,ri);
pout = fminsearch(fun,sParms);
pow_pred = pout(1)*(pout(2)*(0:max(ri))+1).^(-pout(3)); 

%Plot Data - Note this is missing the extra lines at the moment
figure
plot(0:max(ri),pow_pred);
hold on
scatter(ri,rec);
xlabel('Retention Interval');
ylabel('Proprtion Items Retained');


%Perform Bootstrapping Analysis
%Set up parameters
ns = 55;
nbs = 1000;

bsParms = NaN(nbs,length(sParms));

bspow_pred = pout(1)*((pout(2)*(ri))+1).^(-pout(3));

%For Loop to apply bootstrapping
for counter = 1:nbs
    %Counter to create the Rec Synth variable
    for counter2 = 1:length(bspow_pred)
        recsynth(counter2) = mean(binornd(1,bspow_pred(counter2),[55,1]));
    end
    %Add optimization Function
    rec2 = recsynth;
    fun = @(sParms)chap3_powerdiscrep(sParms,rec2,ri);
    pout2 = fminsearch(fun,pout);
    bsParms(counter,:) = pout2; 
    
end

%Generate Histograms from Bootstrapped data
labels = {'Parameter A','Parameter B','Parameter C'};
figure
for counter = 1:length(bsParms(1,:))
    subplot(1,3,counter)
    histogram(bsParms(:,counter));
    xlim([0,1]);
    xlabel(labels(counter));
    ylabel('Frequency');
    %Quantil for .025
    line1 = quantile(bsParms(:,counter),.025);
    %Quantile for .975
    line2 = quantile(bsParms(:,counter),.975);
    %Add Quantiles Lines to plot
    xline(line1,'--','LineWidth',2,'Color','k');
    xline(line2,'--','LineWidth',2,'Color','k');
end

