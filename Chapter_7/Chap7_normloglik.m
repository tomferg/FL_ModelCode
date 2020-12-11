function [normlogLik] = Chap7_normloglik(precision,mu,x)

    normlogLik1 = (mu^2)-2*x*mu;
    normlogLik = -0.5*precision*normlogLik1;
    
end