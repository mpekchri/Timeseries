function [aic_arma,fpe_arma,aic_ar,fpe_ar,aic_ma,fpe_ma] = find_AIC_FPE(x,pplot,maxp,maxq)
%% This function is used in order to compute aic and fpe for different models on data xnew
%% Input :
%	xnew = data of a timeseries
%   pplot = if plot == 0 then nothing is plotted , if plot == 1 then aic is
%          plotted , else fpe is plotted
%   maxp = matrix , where maxp(1) has the maximum p value which will be
%          used in ARMA models, maxp(2) is about AR model 
%   maxq = matrix , where maxq(1) has the maximum q value which will be
%          used in ARMA models, maxq(2) is about MA model 
%% Output :
%	the matrices and vectors , containing the aic/fpe values computed by
%	the function
    
%% find timeseries mean value 
m = mean(x);

%% find aic-fpe for ARMA model
p = maxp(1);
q = maxq(1);
if(pplot~=0)
    figure
    hold on
end
res_aic = zeros(q,p);
res_fpe = zeros(q,p);
for j=1:q
    fpe_arma = zeros(p,1);
    aic_arma = zeros(p,1);
    for i=1:p
        [aic_arma(i) ,fpe_arma(i)]=AIC_FPE(x-m,i,j);
    end
    if(pplot==1)
        plot(aic_arma,'-s');
    elseif(pplot~=0 && pplot~= 1)
        plot(fpe_arma,'-s');
    end
    res_aic(i,:) = aic_arma;
    res_fpe(i,:) = fpe_arma;
end
if(pplot==1)
    legend('q = 1','q = 2','q = 3','q = 4','q = 5','q = 6','q = 7','q = 8','q = 9','q = 10','q = 11','q = 12','q = 13','q = 14','q = 15','q = 16','q = 17','q = 18','q = 19','q = 20','q = 21','q = 22','q = 23','q = 24','q = 25','q = 26','q = 27','q = 28','q = 29','q = 30','q = 31','q = 32','q = 33','q = 34','q = 35','q = 36','q = 37','q = 38','q = 39','q = 40');
    title('AIC for ARMA model')
    xlabel('p')
    ylabel('AIC')
elseif(pplot~=0 && pplot~= 1)
    legend('q = 1','q = 2','q = 3','q = 4','q = 5','q = 6','q = 7','q = 8','q = 9','q = 10','q = 11','q = 12','q = 13','q = 14','q = 15','q = 16','q = 17','q = 18','q = 19','q = 20','q = 21','q = 22','q = 23','q = 24','q = 25','q = 26','q = 27','q = 28','q = 29','q = 30','q = 31','q = 32','q = 33','q = 34','q = 35','q = 36','q = 37','q = 38','q = 39','q = 40');
    title('FPE for ARMA model')
    xlabel('p')
    ylabel('FPE')
end
aic_arma = res_aic ;
fpe_arma = res_fpe ;

%% find aic-fpe for AR model
p = maxp(2);
if(pplot~=0)
    figure
    hold on
end
    fpe_ar = zeros(p,1);
    aic_ar = zeros(p,1);
    for i=1:p
        [aic_ar(i) ,fpe_ar(i)]=AIC_FPE(x-m,i,0);
    end
    if(pplot==1)
        plot(aic_ar,'-s');
    elseif(pplot~=0 && pplot~= 1)
        plot(fpe_ar,'-s');
    end

if(pplot==1)
    title('AIC for AR model')
    xlabel('p')
    ylabel('AIC')
elseif(pplot~=0 && pplot~= 1)
    title('FPE for AR model')
    xlabel('p')
    ylabel('FPE')
end

%% find aic-fpe for AR model
q = maxq(2);
if(pplot~=0)
    figure
    hold on
end
    fpe_ma = zeros(q,1);
    aic_ma = zeros(q,1);
    for i=1:q
        [aic_ma(i) ,fpe_ma(i)]=AIC_FPE(x-m,0,i);
    end
    if(pplot==1)
        plot(aic_ma,'-s');
    elseif(pplot~=0 && pplot~= 1)
        plot(fpe_ma,'-s');
    end

if(pplot==1)
    title('AIC for MA model')
    xlabel('q')
    ylabel('AIC')
elseif(pplot~=0 && pplot~= 1)
    title('FPE for MA model')
    xlabel('q')
    ylabel('FPE')
end

end

