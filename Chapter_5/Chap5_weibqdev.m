function [weibq_dev] = Chap5_weibqdev(x,q_emp,q_p)
    if ~all(x)
        weibq_dev = 10000000;
    else
        q_pred = wblinv(q_p,x(2),x(3))+x(1);
        weibq_dev = sqrt(mean((q_pred-q_emp).^2));
    end
end