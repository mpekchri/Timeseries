function [aicS ,fpe] = AIC_FPE(xV,p,q)
xV = xV(:);
n = length(xV);
mx = mean(xV);
xxV = xV-mx;

armamodel = armax(xxV,[p q]);

aicS = aic(armamodel);
fpe = armamodel.Report.Fit.FPE;

end

