function  [p_w] = compute_weights(particles,p_w,z,idf,R,lm)

 % Compute weights of particles.
 
 % Input 
 % particles
 % p_w - current weights
 % z - observations
 % idf - landmark identifier.
 % R - covariance of noisy observations
 % lm - set of landmarks
  
 % Output
 % p_w - new weights
 p_w=ones(1,length(particles(1,:)));
 for j=1:length(particles(1,:))
     x=particles(:,j); 
     for i=1:length(idf)
        m=lm(:,idf(i));
        dx=m(1)-x(1);
        dy=m(2)-x(2);
        q=(dx)^2+(dy)^2;
        z_=[sqrt(q); pi_to_pi(atan2(dy,dx)-x(3))];
        z(2,i)=pi_to_pi(z(2,i));
        p_w(j)=p_w(j)*exp(-1/2*(z(:,i)-z_)'*R^(-1)*(z(:,i)-z_));
     end 
 end
 p_w=p_w/sum(p_w);
end