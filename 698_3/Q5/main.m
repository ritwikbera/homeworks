clear all;
load('data_epipolar.mat');
subplot(2,1,1);
imshow(s.Image1); hold on;
plot(s.pointOfInterest(1),s.pointOfInterest(2),'r.');
p1=[s.pointOfInterest(1) s.pointOfInterest(2) 1]';
K1=s.K1; K2=s.K2;
T_1hc=transform(s.X_hc1);
T_2hc=transform(s.X_hc2);
H=T_2hc^(-1)*(T_1hc);
R=H(1:3,1:3);
T=H(1:3,4);
S=[0 -T(3) T(2);
   T(3) 0 -T(1);
  -T(2) T(1) 0];
L=inv(K2)'*S*R*inv(K1)*p1;
subplot(2,1,2);
imshow(s.Image2); hold on;
ly=1:1:616;
lx=-(L(2)*ly+L(3))/L(1);
plot(lx,ly,'r');