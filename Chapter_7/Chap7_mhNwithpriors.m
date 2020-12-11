%Chapter 7 - MCMC with non-informative priors
clc;clear;close all;

%Set up
plauseRange = [200,600];
chain = zeros(5000,1);
burnin = 200;
rng(1234); %sets the seed
propsd = 5;

obs = 415;
obssd = 20;
priormu = 326;
priorsd = 88;

chain(1) = 500;

%MCMC algorhythm - compares current with proposal
%then using a rule it either goes with the proposal
%or re-samples
for counter = 2:length(chain)
    current = chain(counter-1); %looks into the past
    proposal = current + normrnd(0,propsd,1); %add noise
    
    llratioNum = normpdf(obs,proposal,obssd)*normpdf(proposal,priormu,priorsd);
    llratioDenom = normpdf(obs,current,obssd)*normpdf(current,priormu,priorsd);
    llratio = llratioNum/llratioDenom;
    
    if normpdf(obs,proposal,obssd)*normpdf(proposal,priormu,priorsd) > normpdf(obs,current,obssd)*normpdf(current,priormu,priorsd) %compare densities
        chain(counter) = proposal; %accept proposal
        
    elseif rand(1) < llratio
        chain(counter) = proposal; %accept proposal
    else
        chain(counter) = current; %accept current
    end
end

%Display mean and SD
disp(mean(chain));
disp(std(chain));

[f,xi] = ksdensity(chain); %density of the chain
[f2,xi2] = ksdensity(chain(burnin:end)); %density of the burnin chain
normalDensity = normpdf(min(plauseRange):max(plauseRange),obs,obssd); %normal density
priorDensity = normpdf(min(plauseRange):max(plauseRange),priormu,priorsd); %prior

%Figures
%Density plots across the four distributions
figure
plot(xi,f,'--','color','k','LineWidth',1.5)
hold on
plot(xi2,f2,'color','k','LineWidth',1.5)
plot(min(plauseRange):max(plauseRange),normalDensity,'color',[.7 .7 .7],'LineWidth',1.5);
plot(min(plauseRange):max(plauseRange),priorDensity,'--','color',[.7 .7 .7],'LineWidth',1.5);
xlabel('Sample Values of \mu');
ylabel('Density');
xlim([min(plauseRange),max(plauseRange)]);
set(gca,'YTick', [])
legend({'All MCMC','Excluding Burnin','Normal PDF','Prior PDF'})

%Caterpillar plot
figure;
plot(chain,'color','k','LineWidth',1.5)
hold on
plot(chain(1:burnin),'color','r','LineWidth',1.5)
ylabel('Value of Accepted Sample')
xlabel('Iteration')



%Likelihood Function not Density
obs = 415;
obsprecision = .0025;
priormu = 326;
priorprecision = .001293;
rng('shuffle');


chain(1) = 500;

%MCMC algorhythm - compares current with proposal
%then using a rule it either goes with the proposal
%or re-samples
for counter = 2:length(chain)
    current = chain(counter-1); %looks into the past
    proposal = current + normrnd(0,propsd,1); %add noise
    
    llratioNum = Chap7_normloglik(obsprecision,proposal,obs)+Chap7_normloglik(priorprecision,proposal,priormu);
    llratioDenom = Chap7_normloglik(obsprecision,current,obs)+Chap7_normloglik(priorprecision,current,priormu);
    llratio = exp(llratioNum-llratioDenom);
    
    if Chap7_normloglik(obsprecision,proposal,obs)+Chap7_normloglik(priorprecision,proposal,priormu) >...
            Chap7_normloglik(obsprecision,current,obs)+Chap7_normloglik(priorprecision,current,priormu) %compare densities
        chain(counter) = proposal; %accept proposal
        
    elseif rand(1) < llratio
        chain(counter) = proposal; %accept proposal
    else
        chain(counter) = current; %accept current
    end
end
