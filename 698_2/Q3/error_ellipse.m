function a=error_ellipse(R,mu)

[pc,v]=eig(R);
v=diag(v);
[max_value,max_index]=max(abs(v));
pc=pc(:,max_index);



largest_eigenval=max_value;
smallest_eigenval=min(abs(v));

angle = atan2(pc(2), pc(1));


% Get the 99% confidence interval error ellipse
chisquare_val = 3;
theta_grid = linspace(0,2*pi);
phi = angle;
X0=mu(1);
Y0=mu(2);
a=chisquare_val*sqrt(largest_eigenval);
b=chisquare_val*sqrt(smallest_eigenval);

ellipse_x_r  = a*cos( theta_grid );
ellipse_y_r  = b*sin( theta_grid );



R = [ cos(phi) sin(phi); -sin(phi) cos(phi) ];

%ellipse rotated to fit eigen vectors
r_ellipse = [ellipse_x_r;ellipse_y_r]' * R;

plot(r_ellipse(:,1) + X0,r_ellipse(:,2) + Y0,'-')
hold on;



