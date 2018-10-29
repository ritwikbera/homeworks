 function [x,particles]=pf_predict(particles,v,g,Q,dt,p_w)
 
 % Input
 % particles
 % v,g - the actual controls i.e velocity and orientation
 % Q - covariance of noisy controls
 % p_w - weigths
 % dt - timestep
 
 
% Output
% x - The pose given by the most weighted particle. 
 
% Propogate particles via motion model.
 for i=1:length(particles(1,:))
     u=mvnrnd([v;g],Q,1);
     particles(:,i)=[particles(1,i)+u(1)*dt*cos(u(2)+particles(3,i));particles(2,i)+u(1)*dt*sin(u(2)+particles(3,i));pi_to_pi(particles(3,i)+u(2))];
 end
 
 [~,j]=max(p_w);
 x=particles(:,j); 
 end  