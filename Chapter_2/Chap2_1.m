%Random Walk Model 1
clc;clear;close all;

%Model Parameters
repetitions = 10000;
samples = 2000;
drift = 0.03;
sd_RW = 0.3;
Criterion = 3;

%Stage set up
latencies = zeros(1,repetitions);
responses = zeros(1,repetitions);
evidence = zeros(repetitions,samples);

%Loop to simulate model
for RWcounter = 1:repetitions
    evidence(RWcounter,:) = cumsum(normrnd(drift,sd_RW,[1,samples]));
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
hline = refline([0,-3]);
hline.LineStyle = '--';
hline.Color = 'k';
hline2 = refline([0,3]);
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

%Print Error message?
figure
if isnan(topChoicemean)
    subplot(1,2,1)
    histogram(topChoice2,15,'EdgeColor','k','FaceAlpha',0.1);
    title('Choosing Top');
    txt = 'No mean';
    text(5,0.2,txt)
else
    subplot(1,2,1)
    histogram(topChoice2,15,'EdgeColor','k','FaceAlpha',0.1);
    title('Choosing Top');
    xline(topChoicemean,'Color','k','Alpha',1,'LineWidth',2);
end

if isnan(bottomChoicemean)
    subplot(1,2,2)
    histogram(bottomChoice2,15,'EdgeColor','k','FaceAlpha',0.1);
    title('Choosing Bottom');
    txt = 'No mean';
    text(5,0.2,txt)
else
    subplot(1,2,2)
    histogram(bottomChoice2,15,'EdgeColor','k','FaceAlpha',0.1);
    title('Choosing Bottom');
    xline(bottomChoicemean,'Color','k','Alpha',1,'LineWidth',2);
end

