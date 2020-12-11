function [weighFunc] = Chap5_weightfunc(x,w,mu)
    wvar1 = (x-mu);
    wvar2 = (x-mu).^2;
    wvar3 = w.*wvar2;
    wvar4 = sum(wvar3);
    wvar5 = wvar4/sum(w);
    weighFunc = sqrt(wvar5);
end