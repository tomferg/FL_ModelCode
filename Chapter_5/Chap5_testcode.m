%Test matrix
test = csvread('test.csv');

startParam2 = [100,225,1];

optimset('MaxFunEvals',1000);

for indidevCounter = 1:length(Dat)
    rts = test(:,indidevCounter);
    fun2 = @(startParam2) Chap5_weibdeviance(startParam2,rts);
    [x,FVAL] = fminsearch(fun2,startParam2,options);
    paramestimations(indidevCounter,:) = x;
    logliklihoodest(indidevCounter) = FVAL;
end


disp(mean(paramestimations)) %mean parameter estimates
disp(std(paramestimations)) %SD of estimates