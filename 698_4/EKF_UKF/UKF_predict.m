function [x,P]= UKF_predict(x,P,v,g,Q,dt)
% Inputs:
%   x, P - state and covariance
%   v, g - control inputs: velocity and gamma (steer angle)
%   Q - covariance matrix for velocity and gamma
%   dt - timestep
%
% Outputs: 
%   x, P - predicted state and covariance
 
% <------------------------- TO DO -------------------------->
 
% UKF Parameter
alpha=0.001;
beta =2;
kappa=0;

n=3;%size of state vector

lamda=alpha^2*(n+kappa)-n;

%calculate weights
wm=lamda/(lamda+n);
wc=(lamda/(lamda+n))+(1-alpha^2+beta);
for i=1:2*n
    wm=[wm 1/(2*(n+lamda))];
    wc=[wc 1/(2*(n+lamda))];
end

gamma=sqrt(n+lamda);


sigma=GenerateSigmaPoints(x,P,gamma);
sigma=PredictMotion(sigma,v,g,dt);
xPred=(wm*sigma')';
PPred=CalcSimgaPointsCovariance(xPred,sigma,wc,diag([0.01,0.01,0.01].^2));

x=xPred;
P=PPred;
end


 
  

 
