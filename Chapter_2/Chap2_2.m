%Random Walk Model 2
clc;clear;close all;

%Model Parameters
repetitions = 10000;
samples = 2000;
drift = 0.01;
sd_RW = 0.5;
Criterion = 2;
t2std = [0,0.035];

%Stage set up
latencies = zeros(1,repetitions);
responses = zeros(1,repetitions);
evidence = zeros(repetitions,samples);

%Loop to simulate model
for RWcounter = 1:repetitions
    sp = normrnd(0,t2std(1),1);
    dr = normrnd(drift,t2std(2),1);
    evidence(RWcounter,:) = cumsum(normrnd(dr,sd_RW,[1,samples]))+sp;
    p = (abs(evidence(RWcounter,:)) > Criterion); %logical index of if the evidence is larger than crit
    latencies(1,RWcounter) = find(p,1,'First');
    responses(1,RWcounter) = sign(evidence(RWcounter,latencies(1,RWcounter)));
end

%Plot 5 Random Walks Paths
plotWalks= 5;

for plotCounter = 1:plotWalks
    plot(evidence(plotCounter,1:latencies(plotCounter)))
    hold on
end
ylim([-Criterion-.5,Criterion+.5]);
xlabel('Decision Time (Latency)')
ylabel('Evidence')
hline = refline([0,Criterion]);
hline.LineStyle = '--';
hline.Color = 'k';
hline2 = refline([0,-Criterion]);
hline2.LineStyle = '--';
hline2.Color = 'k';


%Plot Histograms of Latencies
%Set up of histogram
topChoice = (responses>=1);
topChoice2 = latencies(1,topChoice);
topChoicemean = mean(topChoice2);
bottomChoice = (responses<1);
bottomChoice2 = latencies(1,bottomChoice);
bottomChoicemean = mean(bottomChoice2);

figure
subplot(1,2,1)
histogram(topChoice2,15,'EdgeColor','k','FaceAlpha',0.1);
title('Choosing Top');
xline(topChoicemean,'Color','k','Alpha',1,'LineWidth',2);
subplot(1,2,2)
histogram(bottomChoice2,15,'EdgeColor','k','FaceAlpha',0.1);
title('Choosing Bottom');
xline(bottomChoicemean,'Color','k','Alpha',1,'LineWidth',2);
