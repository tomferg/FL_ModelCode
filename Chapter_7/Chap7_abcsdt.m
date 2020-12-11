%Chapter 7 - Aproximate Bayesian Computation
clc;clear;close all;

%Set up
y = [60,11];
dmu = 1;
bmu = 0;
dsigma = 1;
bsigma = 1;

nTrials = 100;
episilon = 1;
posterior = zeros(1000,2);

%Counter to commence ABC
for counter = 1:length(posterior)
    propCount = 0;
    while propCount == 0
        dprop = normrnd(dmu,dsigma,1);
        bprop = normrnd(bmu,bsigma,1);
        SDT = Chap7_stimsdt(dprop,bprop,nTrials);
        
        if sqrt(sum((y-SDT).^2)) <= episilon
            propCount = 1;
        end
        

    end
    
    posterior(counter,:) = [dprop,bprop]; %Keep good simulation
    disp(counter);
    
end

format long g
disp(mean(posterior,1));
disp(quantile(posterior(:,:),.025));
disp(quantile(posterior(:,:),.975));

figure
histogram(posterior);
xlim([0,1]);

numbersMat = [counter,sqrt(sum((y-SDT).^2)),SDT,posterior(counter,:)];
disp(numbersMat);
