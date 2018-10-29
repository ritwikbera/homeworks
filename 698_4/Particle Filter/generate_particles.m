function [particles,p_w] = generate_particles(x,Np,P)

% Input
% x - initial starting pose
% P - covariance
% Np - number of particles

% Output
% p_w - weights of particles
% particles- each particle represents a potential pose of the robot at any time t

particles = mvnrnd(x,P,Np)';
for i=1:Np
    particles(3,i)=pi_to_pi(particles(3,i));
end
p_w=ones(1,Np);
p_w=p_w/sum(p_w);
end 