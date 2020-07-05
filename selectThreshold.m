function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    predictions = zeros(size(pval,1),1);
    
    for i = 1:size(pval)
        if pval(i) < epsilon
            prediction(i) = 1;
        else
            prediction(i) = 0;
        end
    end
        
    fp = 0; tp = 0; fn = 0;
    
    for j = 1:size(pval)
        if prediction(j) == 1 & yval(j) == 0
            fp = fp + 1;
        elseif prediction(j) == 0 & yval(j) == 1
            fn = fn + 1;
        elseif prediction(j) == 1 & yval(j) == 1
            tp = tp + 1;
        end
    end
    
    prec =tp/(tp + fp);
    rec =tp/(tp + fn);
    F1 =(2*prec*rec)/(prec + rec);
    

 

        


    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
