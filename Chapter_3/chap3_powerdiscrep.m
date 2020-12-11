function [powerdisc] = chap3_powerdiscrep(parms,rec,ri)
    
    array1 = parms < 0;%Create logical array
    array2 = parms > 1;
    if any(array1) || any(array2)
        powerdisc = 100000;
    else
        pow_pred1 = (parms(2)*ri+1);
        pow_pred2 = pow_pred1.^(-parms(3));
        pow_pred3 = parms(1)*pow_pred2;
        powerdisc1 = (pow_pred3-rec).^2/length(ri);
        powerdisc = sqrt(sum(powerdisc1));
    end

end