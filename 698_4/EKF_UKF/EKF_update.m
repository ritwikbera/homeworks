function [x,P]= EKF_update(x,P,z,R,idf,lm)
 
% Inputs:
%   x, P -  state and covariance
%   z, R - range-bearing measurements and covariances
%   idf - feature index for each z
 
% Outputs:
%   x, P - updated state and covariance


% <---------------------------- TO DO -------------------------->
 for i=1:length(idf)
    m=lm(:,idf(i));
    dx=m(1)-x(1);
    dy=m(2)-x(2);
    q=(dx)^2+(dy)^2;
    z_=[sqrt(q); pi_to_pi(atan2(dy,dx)-x(3))];
    H=[[-dx/sqrt(q) -dy/sqrt(q) 0];[dy/q dx/q -1]];
    K=P*H'*(H*P*H'+R)^(-1);
    z(2)=pi_to_pi(z(2));
    x=x+K*(z(:,i)-z_);
    x(3)=pi_to_pi(x(3));
    P=(eye(3)-K*H)*P;
end
 
end        


     
    
    
  

         
