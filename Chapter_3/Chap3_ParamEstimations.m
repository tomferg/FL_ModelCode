%Chapter 3 Code
clc;clear;close all;

%Set parameters - these are all for the model itself
numDataObs = 20;
rho = .80;
intercept = .0;
%Starting Parameters
slopeStart = 0;
interceptStart = .5;

%Generate Fake Data
%Column 1 is   the fake Y data
data(1:numDataObs,1) = normrnd(0,1,[numDataObs,1]);
%Column 2 is the fake X data
data(1:numDataObs,2) = normrnd(0,1,[numDataObs,1])*sqrt(1-rho^2) + data(1:numDataObs,1)*rho+intercept;

%Optimization of parameters
%Conventional linear regression Analysis
model = fitlm(data(:,2),data(:,1)); %X and then Y

%Optimization & Plotting?
fun = @(x1)Chap3paramfunc(x1,data,0);
StartParam = [slopeStart,interceptStart]; %B1 and B0
Chap3paramfunc(StartParam,data,0);
%Options are to use fmincon or fminsearch (uses Nelder & Mead?)
[x, FVAL,~,output] = fmincon(fun,StartParam,[],[],[],[],[0 0],[1 1]);
%[x, FVAL,~,output] = fminsearch(fun,StartParam);

[rmsquarediff,Newparameters] = Chap3paramfunc(x,data,0);

%% Plot - Compare First to Last?
predictions = StartParam(2) + StartParam(1)*data(:,2);
%Plot of Start
subplot(1,3,1);
scatter(data(:,2),data(:,1),'MarkerEdgeColor',[0 0 0],...
    'MarkerFaceColor',[.5 .5 .5],'LineWidth',1);
hold on
plot(data(:,2),predictions,'Color',[0,0,0],'LineWidth',1.5);
xlim([-2,2]);
ylim([-2,2]);
xlabel('X');
ylabel('Y');
title('Start');
%Plot of End
subplot(1,3,2);
scatter(data(:,2),data(:,1),'MarkerEdgeColor',[0 0 0],...
    'MarkerFaceColor',[.5 .5 .5],'LineWidth',1);
hold on
plot(data(:,2),Newparameters,'Color',[0,0,0],'LineWidth',1.5);
xlim([-2,2]);
ylim([-2,2]);
xlabel('X');
ylabel('Y');
title('End Result');
%Ideal Plot
subplot(1,3,3);
scatter(data(:,2),data(:,1),'MarkerEdgeColor',[0 0 0],...
    'MarkerFaceColor',[.5 .5 .5],'LineWidth',1);
hold on
plot(data(:,2),model.Fitted,'Color',[0,0,0],'LineWidth',1.5);
xlim([-2,2]);
ylim([-2,2]);
xlabel('X');
ylabel('Y');
title('Regression');