%Chapter 6 - Beta distributions
clc;clear;close all;
X = 0:0.01:1; %Create distribution from 0 to 1 in increments of 0.1
johnnieLine = betapdf(X,2,4);
janeLine = betapdf(X,8,16);

figure
plot(X,johnnieLine,'color','k');
hold on
plot(X,janeLine,'--','color','k');
xlabel('x value');
ylabel('Density');
ylim([0,6]);
legend({'Johnnie','Jane'});


%Distribution Examples
betadiff1 = betacdf(.58,8,16)-betacdf(.13,8,16);
betadiff2 = betacdf(.53,2,4)-betacdf(.13,2,4);


%Second Figure
alphaNum = 12;
betaNum = 12;

%First Line (Prior)
Prior = betapdf(X,alphaNum,betaNum);

%Counter to set up Posterior Distributions
t = [12,100,1000];
h = [14,113,1330];

for counter = 1:length(h)
    
    Posterior(counter,:) = betapdf(X,alphaNum+h(counter),betaNum+t(counter));
    num1=alphaNum+h(counter);
    denom1= (alphaNum+h(counter)+betaNum+t(counter));
    disp(num1/denom1);
    num2 = h(counter);
    denom2 = h(counter)+t(counter);
    disp(num2/denom2);
end

figure
plot(X,Prior,'LineWidth',1.5,'color','k');
hold on
plot(X,Posterior(1,:),'--','LineWidth',1.5,'color','k');
plot(X,Posterior(2,:),'--','LineWidth',1.5,'color','k');
plot(X,Posterior(3,:),'--','LineWidth',1.5,'color','k');
xline(0.5,'r','LineWidth',1.5);
ylim([0,40]);
xlabel('Probability Density');
ylabel('X Values');
legend({'Prior','11 21','113 213','1130 2130'});



