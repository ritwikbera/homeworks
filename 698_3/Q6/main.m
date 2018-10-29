clear all;
load('data_kalman.mat');
dt=0.1;
t=[0:1:length(data.z)-1]*dt;
g=9.8;
Q=200^2;
u=300;
R=[0.1 0; 0 0.1];
A=[1 dt; 0 1]; 
B=[-g*(dt^2)/2 -g*dt]';
C=[1 0];
z_calc=u*t-0.5*g*(t.^2);

mu=[0 300]';
sigma=eye(2);
z_kf=[];
for i=1:length(data.z)
    mu_=A*mu+B;
    sigma_=A*sigma*A'+R;
    K=sigma_*C'/(C*sigma_*C'+Q);
    mu=mu_+K*(data.z(i)-C*mu_);
    sigma=(eye(2)-K*C)*sigma_;
    mu_=mu; sigma_=sigma;
    z_kf=[z_kf mu_(1)];
end

plot(t,z_kf,'r','LineWidth',2); hold on;
plot(t,z_calc,'b'); hold on;
plot(t,data.orig_state(:,1),'k-'); hold on;
plot(t,data.z,'r.'); hold on;
ylabel('Height (m)');
xlabel('Time (s)');
legend('Kalman Filteres','Without measurement','Actual','Measurements');