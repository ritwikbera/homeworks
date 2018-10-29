clear all;
load('data.mat');

%1.b.1
figure;
theta=data(:,1); r=data(:,2);
R=[0.5 0; 0 1];
error_ellipse(R,[1 3]');          
plot(theta,r,'b.');
ylabel('r'); xlabel('theta');

%1.b.2
x=r.*cos(theta);
y=r.*sin(theta);
[R_sam,mu_sam]=stats(x,y);
figure;
error_ellipse(R_sam,mu_sam);
plot(x,y,'r.');
hold on;

%1.b.3
J=[-3*sin(1) cos(1); 3*cos(1) sin(1)];
mu_lin=[3*cos(1) 3*sin(1)]'  ;  %mean of euclidean function evaluated at mean of polar function
R_lin=J*R*J';    %covariance propagation
error_ellipse(R_lin,mu_lin);

xlabel('x'); ylabel('y');
