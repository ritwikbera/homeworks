function [x,P]= EKF_predict(x,P,v,g,Q,dt)
%function [xn,Pn]= predict (x,P,v,g,Q,WB,dt)
%
% Inputs:
%   x, P - state and covariance
%   v, g - control inputs: velocity and gamma (steer angle)
%   Q - covariance matrix for velocity and gamma
%   dt - timestep
%
% Outputs: 
%   x, P - predicted state and covariance
 
% <------------------------- TO DO -------------------------->
 

mu=[x(1)+v*dt*cos(g+x(3));
    x(2)+v*dt*sin(g+x(3));
    pi_to_pi(x(3)+g)];
G=[1 0 -v*dt*sin(mu(3)+g);
   0 1 v*dt*cos(mu(3)+g);
   0 0 1 ];
B=[dt*cos(g+mu(3)) -v*dt*sin(g+mu(3));
    dt*sin(g+mu(3)) v*dt*cos(g+mu(3));
    0                     1 ];

P=G*P*G'+B*Q*B';
x=mu;

 

end

 
  

 
