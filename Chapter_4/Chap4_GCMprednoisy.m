function [GCMprednoisy] = Chap4_GCMprednoisy(probe,exemplars,c,w,sigma,b)

    for counter = 1:length(exemplars(:,1,1))
        exemplar_cat = squeeze(exemplars(counter,:,:));

        for counter2 = 1:length(exemplar_cat(:,1))
            probedist = (exemplar_cat(counter2,:) - probe);
            probedistexp = w.*((probedist).^2);
            ecldist(counter2,:) = sqrt(sum(probedistexp));
        end
        ecldist2(counter,:) = ecldist;
    end
    ecldist2 = ecldist2';



    for counter3 = 1:length(ecldist2(1,:))
        individualECL(counter3) =sum(exp((-c*ecldist2(:,counter3))));
    end

    r_prob = [0,0];
    for counter4 = 1:length(individualECL)
        r_prob(1) = normcdf(0,individualECL(1)-individualECL(2)-b,sigma);
        r_prob(2) = 1 - r_prob(1);    
    end

    GCMprednoisy = r_prob;



end