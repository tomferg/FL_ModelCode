%Chapter 7 - Bayesian MCMC

clc;clear;close all;

%Set up
burnin = 200;
chain = zeros(5000,1);
obs = 144;
propsd = 2; %Tuning parameter - important

chain(1) = 150;

%MCMC algorhythm - compares current with proposal
%then using a rule it either goes with the proposal
%or re-samples
for counter = 2:length(chain)
    current = chain(counter-1); %looks into the past
    proposal = current + normrnd(0,propsd,1); %add noise
    
    if normpdf(obs,proposal,15) > normpdf(obs,current,15) %compare densities
        chain(counter) = proposal; %accept proposal
        
    elseif rand(1) < (normpdf(144,proposal,15)/normpdf(144,current,15))
        chain(counter) = proposal; %accept proposal
    else
        chain(counter) = current; %accept current
    end
end

figure
histogram(chain);
ylabel('Frequency');
xlabel('X');
%Display Mean
disp(mean(chain));


%Create Density Plots
%Set up distributions
[f,xi] = ksdensity(chain); %density of the chain
[f2,xi2] = ksdensity(chain(burnin:end)); %density of the burnin chain
normalDist = normpdf(100:200,144,15); %normal distribution

%Density plots across the three distributions
figure
plot(xi,f,'--','color','k','LineWidth',1.5)
hold on
plot(xi2,f2,'color','k','LineWidth',1.5)
plot(100:200,normalDist,'color','r','LineWidth',1.5);
xlabel('Sample Values of \mu');
ylabel('Density');
xlim([100,200]);
set(gca,'YTick', [])
legend({'All MCMC','Excluding Burnin','Normal PDF'})

%Chain Plot
figure;
plot(chain,'color','k','LineWidth',1.5)
hold on
plot(chain(1:burnin),'color','r','LineWidth',1.5)
ylabel('Value of Accepted Sample')
xlabel('Iteration')
