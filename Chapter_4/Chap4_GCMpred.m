function [GCMpred] = Chap4_GCMpred(probe,exemplar,c,w)
    
    
    for counter = 1:length(exemplar(:,1,1))
        exemplar_cat = squeeze(exemplar(counter,:,:));
        
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
        
    
    for counter4 = 1:length(individualECL)
        r_prob(counter4) = individualECL(counter4)/sum(individualECL);
    end
    
    GCMpred = r_prob;
    
end