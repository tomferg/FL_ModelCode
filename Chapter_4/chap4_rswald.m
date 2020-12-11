function [probWald] = chap4_rswald(t,a,m,Ter)
    
    %In this case - t = time, a = position of response boundary, m = drift
    % & ter = non decision time

    tCube = (t-Ter)^3;
    Denom1 = sqrt(2*pi*tCube);
    firstHalf = a/Denom1;
    
    num2 = (a - m*(t - Ter))^2;
    denom2 = 2*(t-Ter);
    secondHalf = num2/denom2;
    probWald = firstHalf*exp(-secondHalf);
    
end