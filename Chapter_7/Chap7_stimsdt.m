function [SDT] = Chap7_stimsdt(d,b,nTrials)
   
    old = normrnd(d,1,[nTrials/2,1]); %mu, sigma
    hits = (sum((old > (d/2+b)))/(nTrials/2))*100;
    new = normrnd(0,1,[nTrials/2,1]);
    fas = (sum((new > (d/2+b)))/(nTrials/2))*100;
    SDT = [hits,fas];

end