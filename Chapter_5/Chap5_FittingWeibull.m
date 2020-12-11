%Chapter 5 Notes
clc;clear;close all;


%Parameter Set up
nsubj = 30;
nobs = 20;
q_p = [.1,.3,.5,.7,.9];

shift = normrnd(250,50,[1,nsubj,]);
scale = normrnd(200,50,[1,nsubj]);
shape = normrnd(2,0.25,[1,nsubj]);

%Concatinate All Parameters together
params = vertcat(shift,scale,shape);

%Display means of column
disp(mean(params,2))

%Create Data File
Dat = zeros(nobs,nsubj);
for RBCounter = 1:length(params)
    Dat(:,RBCounter) = wblrnd(params(2,RBCounter),params(3,RBCounter),[nobs,1])+params(1,RBCounter);
end

%Calculate Quantiles for each person  - Doesn't seem to be working?
subjectQuantile = zeros(5,length(Dat));
for quanCounter = 1:length(Dat)
    subjectQuantile(:,quanCounter) = quantile(Dat(:,quanCounter),q_p)';
end

%Average Quantiles
vinq = mean(subjectQuantile,2)';

%Fit the shifted weibull distribution to the quantiles
fun = @(startParam)Chap5_weibqdev(startParam,vinq,q_p);
startParam = [255,255,1];
[x,FVAL] = fminsearch(fun,startParam);
%Display the means
disp([x,FVAL]);

%Test matrix
test = csvread('test.csv');

startParam2 = [100,225,1];
 
for indidevCounter = 1:length(Dat)
    rts = Dat(:,indidevCounter);
    fun2 = @(startParam2) Chap5_weibdeviance(startParam2,rts);
    [x,FVAL] = fminsearch(fun2,startParam2);
    paramestimations(indidevCounter,:) = x;
    logliklihoodest(indidevCounter) = FVAL;
end

%Note there seems to be an issue with fminsearch reaching inf - increasing
%MaxIter and MaxFunEval doesnt seem to help
disp(mean(paramestimations)) %mean parameter estimates
disp(std(paramestimations)) %SD of estimates

