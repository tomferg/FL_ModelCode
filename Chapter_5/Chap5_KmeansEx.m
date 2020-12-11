%Chapter 5 - K means code
clc;clear;close

%Set-up
nPrim = 25;
nRec = 50;
nBoth = 25;

ll =12;
serpos=(1:ll);
nTrials = 10;


%Set up Matrices
%WHAT MATRIX IS THIS?
primDat = zeros(nPrim,ll);
for counter = 1:length(primDat)
    asym = 0.3;
    expp = 1;
    tdat = (1-asym)*exp(-expp*(serpos-1))+asym;
    primDat(counter,:) = binornd(nTrials,tdat)/nTrials;
end

%WHAT MATRIX IS THIS?
recDat = zeros(nRec,ll);
for counter = 1:length(recDat)
    asym = 0.3;
    expp = 1;
    tdat2 = (1-asym)*exp(-expp*flip(serpos-1))+asym;
    recDat(counter,:) = binornd(nTrials,tdat2)/nTrials
    
end

%WHAT MATRIX IS THIS?
bothDat = zeros(nBoth,ll);
for counter = 1:length(bothDat)
    asym = 0.5;
    expp = 1;
    pc = 0.5 * exp(-expp*flip(serpos-1))+0.5*exp(-expp*(serpos-1));
    tdat3 = (1-asym)*pc+asym;
    bothDat(counter,:) = binornd(nTrials,tdat3)/nTrials;
    
end

spcdat = vertcat(primDat,recDat,bothDat);

%Plots
%Cluster Locations
gskmn = evalclusters(spcdat,'kmeans','gap','KList',(1:8),'b',500);

figure;
plot((1:8),gskmn.CriterionValues,'-o','Color','k')
xlabel('GapK')
ylabel('K')

%K means
[idx,C] = kmeans(spcdat,3,'Start','sample');

figure;
subplot(1,2,1)
plot(mean(spcdat,1),'-o','LineWidth',1.5,'Color','k');
ylim([0,1]);
xlabel('Serial Position');
ylabel('Proportion Correct');
subplot(1,2,2)
plot((1:12),C(3,:),'Color','k','LineWidth',1.5)
hold on
plot((1:12),C(2,:),'Color','r','LineWidth',1.5)
plot((1:12),C(1,:),'Color','g','LineWidth',1.5)
ylim([0,1]);
xlabel('Serial Position');
ylabel('Proportion Correct');
legend({'1','2','3'})