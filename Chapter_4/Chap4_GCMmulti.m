function [deviance] = Chap4_GCMmulti(theta,stim,exemplars,data,N,retpreds)
    nDat = nan(length(data),1);
    dev = nDat;
    preds = dev;
    
    
    c = theta(1);
    w = theta(2);

    w(2) = (1-w(1))*theta(3);
    w(3) = (1-sum(w))*theta(4);
    w(4) = 1-sum(w);
    sigma = theta(5);
    b = theta(6);
    
    
    for counter = 1:length(nDat)
        p = [];
        p = Chap4_GCMprednoisy(stim(counter,:),exemplars,c,w,sigma,b);
        dataround = round(data(counter));
        dev(counter) = -2*log(binopdf(dataround,N,p(2)));
        preds(counter) = p(2);
    end
    
    if retpreds == 1
        deviance = preds;
    else
        deviance = sum(dev);
    end
    
    
end