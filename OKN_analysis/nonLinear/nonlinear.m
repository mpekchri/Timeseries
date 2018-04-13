x = load('dat15v1.dat');

%% plotare ton elkusth se R2 kai R3
plotd2d3([x(3:end) , x(2:end-1), x(1:end-2)],'space reconstruction');

mutual1 = mutualinformation(x,300);
figure
autocorr = autocorrelation(x,300);
hold on
plot((1/exp(1)).*ones(300,1));
hold off
mutual_mins = extremes(mutual1(:,2),0,1,0,0,1);

%% choose tau
tau = 1;
mmax = 20;

%% apply FNN
addpath /home/chris/Documents/__EKSAMHNO9__/timeseries/lab_nonlinear
fnn = falsenearest(x,tau,mmax,10,0,' ');
    
%% estimate correlation dimension
[rcM,cM,rdM,dM,nuM] = correlationdimensionVer15(x,tau,mmax,' ');

%% local average model (LAM) - find which one fits better in data
q = 0;
m = 5;
NRMSE = zeros(length(1:2*m),1);
for numOfNeighbors = 1:2*m
    figure
    er = localfitnrmse(x,tau,m,10,numOfNeighbors,q,'a');
    NRMSE(numOfNeighbors) = min(er);
end
[minim , numOfNeighbors_LAM] = min(NRMSE)
% best choise for LAM -> numOfNeighbors = 4

%% local linear model (LLM)
q = 1;
m = 5;
NRMSE = zeros(length(1:2*m),1);
for numOfNeighbors = 1:2*m
    figure
    er = localfitnrmse(x,tau,m,10,numOfNeighbors,q,'a');
    NRMSE(numOfNeighbors) = min(er);
end
[minim , numOfNeighbors_LLM] = min(NRMSE)
% best choise for LLM -> numOfNeighbors = 6

%% predictions using the best models
% numOfNeighbors_LAM = 4;
% numOfNeighbors_LLM = 6;
m = 5;
tau = 1;
n1 = floor((70/100)*length(x));

%% local average prediction (LAP)
figure
pred = localpredictmultistep(x,n1,tau,m,length(x)-n1,numOfNeighbors_LAM,0,'LAP');
NRMSE = nrmse(x(n1+1:end),pred)

%% local linear prediction (LLP)
figure
pred = localpredictmultistep(x,n1,tau,m,length(x)-n1,numOfNeighbors_LAM,1,'LLP');
NRMSE = nrmse(x(n1+1:end),pred)
