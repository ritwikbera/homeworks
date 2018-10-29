function out=move(x,v,g,dt)
out=[x(1)+v*dt*cos(g+x(3));
    x(2)+v*dt*sin(g+x(3));
    pi_to_pi(x(3)+g)];
end