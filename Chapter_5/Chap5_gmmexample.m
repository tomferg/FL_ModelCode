clc;clear;close all;


%Set up fake data
rng(1540614451);
N = 1000;
pShort = 0.3;
genpars = [100,10;150,20];
prob = [pShort,1-pShort];

%Assume equal sampling probability for the three distributions 
whichD = randsample([1,2],N,true,prob);

for datCounter = 1:length(whichD)
    dat(datCounter) = normrnd(genpars(whichD(datCounter),1),genpars(whichD(datCounter),2),1);
end

%guess parameters
%load csv for test from R
%format short
%dat1 = csvread('dat.csv'); %this was for testing

mu1 = mean(dat)*0.8;
mu2 = mean(dat)*1.2;
sd1 = std(dat);
sd2 = std(dat);
ppi = 0.5;
oldppi = 0;

while abs(ppi-oldppi) > .00001
    ppi1 = ppi;

   %E step
   respNum = ppi*normpdf(dat,mu2,sd2);
   respDenom = ((1-ppi)*normpdf(dat,mu1,sd1))+(ppi*(normpdf(dat,mu2,sd2)));
   resp = respNum./respDenom;
   
   %M step
   %weighted mean function - taken from matlab website
   mu1 = wmean(dat,1-resp);
   mu2 = wmean(dat,resp);
   %weighted SD function
   sd1 = Chap5_weightfunc(dat,1-resp,mu1);
   sd2 = Chap5_weightfunc(dat,resp,mu2);
   
   ppi = mean(resp);
   oldppi = ppi1;
   disp(ppi);
   

end

%Create the lines for the distribution plot
timePoints = 70:.14:210;
timePoints2 = timePoints(1:end-1);

for linecounter1 = 1:length(timePoints2)
    line1(linecounter1) = (1-ppi)*normpdf(timePoints2(linecounter1),mu1,sd1);
    line2(linecounter1) = ppi*normpdf(timePoints2(linecounter1),mu2,sd2);
end



%Figure Plot
figure
histogram(dat,30,'Normalization','pdf');
hold on
plot(timePoints2,line1,'LineWidth',2,'Color','k')
plot(timePoints2,line2,'LineWidth',2,'Color','k')
xlabel('Reaction Time')
ylabel('Density');

    
