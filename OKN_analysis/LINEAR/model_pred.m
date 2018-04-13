function [ arma_pred, ar_pred, ma_pred , errors , NRMSEs ] = model_pred( x , xtest ,ps , qs , step)
%% find mean of our timeseries
m = mean(x);
errors = zeros(length(xtest),3);
NRMSEs = zeros(3,1);

%% select ARMA model and plot prediction
model = armax(x-m,[ps(1) qs(1)]);
arma_pred = predict(model,xtest,step)+m;
figure
plot(arma_pred)
hold on
plot(xtest)
hold off
title(['ARMA(',num2str(ps(1)),',',num2str(qs(1)) ,') MODEL PREDICTION'])
legend('Prediction','True values');
errors(:,1) = xtest - arma_pred;
NRMSEs(1) = nrmse(xtest,arma_pred);
figure 
plot(errors(:,1))
title(['ARMA(',num2str(ps(1)),',',num2str(qs(1)) ,') PREDICTION ERROR'])

%% select AR model and plot prediction
model = armax(x-m,[ps(2) 0]);
ar_pred = predict(model,xtest,step)+m;
figure
plot(ar_pred)
hold on
plot(xtest)
hold off
title(['AR(',num2str(ps(2)), ') PREDICTION']);
legend('Prediction','True values');
errors(:,2) = xtest - ar_pred;
NRMSEs(2) = nrmse(xtest,ar_pred);
figure 
plot(errors(:,2))
title(['AR(',num2str(ps(2)), ') PREDICTION ERROR']);

%% select MA model and plot prediction
model = armax(x-m,[0 qs(2)]);
ma_pred = predict(model,xtest,step)+m;
figure
plot(ma_pred)
hold on
plot(xtest)
hold off
title(['MA(', num2str(qs(2)), ') PREDICTION']);
legend('Prediction','True values');
errors(:,3) = xtest - ma_pred;
NRMSEs(3) = nrmse(xtest,ma_pred);
figure 
plot(errors(:,3))
title(['MA(', num2str(qs(2)), ') PREDICTION ERROR']);

end

