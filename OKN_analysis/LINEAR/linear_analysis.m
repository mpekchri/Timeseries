%% load data and create ama, ami, amd, tmi, tma and tbp timeseries
x = load('dat15v2.dat');
fsampling = 100;
e1 = extremes(x,6,13,0,0,0);
[ ama1, ami1, amd1, tmi1, tma1, tbp1 ] = createTimeSeries( e1 ,fsampling );

%% criterion 1 : Mutual Information between the new timeseries and the original one
ama_mi1 = zeros(floor(length(x)/length(ama1)),1);
for i = 1:floor(length(x)/length(ama1))
    ama_mi1(i) = MutualInformation(x(i:length(ama1)+i-1), ama1);
end
ami_mi1 = zeros(floor(length(x)/length(ami1)),1);
for i = 1:floor(length(x)/length(ami1))
   ami_mi1(i) = MutualInformation(x(i:length(ami1)+i-1), ami1);
end
amd_mi1 = zeros(floor(length(x)/length(amd1)),1);
for i = 1:floor(length(x)/length(amd1))
   amd_mi1(i) = MutualInformation(x(i:length(amd1)+i-1), amd1);
end
tma_mi1 = zeros(floor(length(x)/length(tma1)),1);
for i = 1:floor(length(x)/length(tma1))
   tma_mi1(i) = MutualInformation(x(i:length(tma1)+i-1), tma1);
end
tmi_mi1 = zeros(floor(length(x)/length(tmi1)),1);
for i = 1:floor(length(x)/length(tmi1))
   tmi_mi1(i) = MutualInformation(x(i:length(tmi1)+i-1), tmi1);
end
tbp_mi1 = zeros(floor(length(x)/length(tbp1)),1);
for i = 1:floor(length(x)/length(tbp1))
   tbp_mi1(i) = MutualInformation(x(i:length(tbp1)+i-1), tbp1);
end
figure
plot(ama_mi1)
hold on
plot(ami_mi1)
plot(amd_mi1)
plot(tma_mi1)
plot(tmi_mi1)
plot(tbp_mi1)
hold off
title('Mutual information between x and timeseries we created from x`s extremes');
legend('AMA' ,'AMI' ,'AMD' ,'TMA' ,'TMI' ,'TBP');

%% find correlation and partial correlation
rx = autocorrelation(xnew,length(xnew));
rx = rx(:,2);
figure
hold on
bar(rx)
axis([0 (length(rx)-1) -1 1])
alpha = 0.05;
zalpha = norminv(1-alpha/2);
autlim = zalpha/sqrt(length(xnew));
plot([0 length(rx)+1],autlim*[1 1],'--c','linewidth',1.5)
plot([0 length(rx)+1],-autlim*[1 1],'--c','linewidth',1.5)
hold off

partialcorr_x = acf2pacf(rx(2:end),1);
hold on
plot([0 length(rx)],autlim*[1 1],'--c','linewidth',1.5)
plot([0 length(rx)],-autlim*[1 1],'--c','linewidth',1.5)
hold off

%% select one timeseries for linear analysis
xnew = ama1;

%% find aic and fpe, plot aic
[aic_arma,fpe_arma,aic_ar,fpe_ar,aic_ma,fpe_ma] = find_AIC_FPE(xnew,1,[10 15],[10 15]);

%% predict (one step prediction) using ARMA(7,6) , AR(8) and MA(5)
step = 1;
[ arma_pred, ar_pred, ma_pred , errors , NRMSEs ] = model_pred( xnew(1:floor(end/2)) , xnew(floor(end/2)+1:end) ,[7 8], [6 5] , step);
NRMSEs

