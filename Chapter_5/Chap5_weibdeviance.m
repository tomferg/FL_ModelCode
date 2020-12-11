function [weib_dev] = Chap5_weibdeviance(startParam2,rts)
    format short
    if any(startParam2 <= 0) || any(rts < startParam2(1))
        weib_dev = 10000000;
    else
        likel = wblpdf(rts-startParam2(1),startParam2(2),startParam2(3));
        weib_dev = sum(-2*log(likel));
    end
end

