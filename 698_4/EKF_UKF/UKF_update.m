function [x,P]= UKF_update(x,P,z,R,idf,lm)
% correcting the predicted pose using Kalman gain.

% Inputs:
%   x, P -  state and covariance
%   z, R - range-bearing measurements and covariances
%   idf - indecies of each landmark from which measurements have arrived 
 
% Outputs:
%   x, P - updated state and covariance


% <---------------------------- TO DO -------------------------->
% 
% UKF Parameter
alpha=0.001;
beta =2;
kappa=0;

n=3;

lamda=alpha^2*(n+kappa)-n;

%calculate weights
wm=lamda/(lamda+n);
wc=(lamda/(lamda+n))+(1-alpha^2+beta);
for i=1:2*n
    wm=[wm 1/(2*(n+lamda))];
    wc=[wc 1/(2*(n+lamda))];
end

 gamma=sqrt(n+lamda);
 
     xPred=x;
     PPred=P;
     
     xPred(3)=pi_to_pi(xPred(3));
    
for i=1:length(idf)
    m=lm(:,idf(i));
    y = z(:,i) - measure(xPred,m);
    y(2) = pi_to_pi(y(2));

    sigma=GenerateSigmaPoints(xPred,PPred,gamma);
    zSigma=PredictObservation(sigma,m);
        
    zb=(wm*zSigma')';
    St=CalcSimgaPointsCovariance(zb,zSigma,wc,R);
    Pxz=CalcPxz(sigma,xPred,zSigma,zb,wc);
    K=Pxz*inv(St);
    
    temp = K*y;
    temp(3) = pi_to_pi(temp(3));
    
    x=xPred+temp;
    P=PPred-K*St*K';
    

end
   
      x(3)=pi_to_pi(x(3));

%     disp('Position');
%     disp(x(1));
%     disp(x(2));
%     disp(P);
 
end        


     
    
    
  

         
