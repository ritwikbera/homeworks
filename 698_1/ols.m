clear all;
load('data_points_line.mat');

%OLS
y=points(:,2); x=points(:,1);
a=[x ones(length(y),1)];
theta=inv(a'*a)*a'*y;
xl=x;
yl=theta(1)*xl+theta(2);

%OLS_RANSAC
inliers=ransac(0.99,2,0.8,1);
xi=inliers(:,1); yi=inliers(:,2);
a=[xi ones(length(yi),1)];
theta=inv(a'*a)*a'*yi;
xr=x;
yr=theta(1)*xr+theta(2);

%plotting
plot(x,y,'bo',xl,yl,'r',xr,yr,'g');
legend('Points','LS on whole data', 'LS using inliers only');
xlabel('X');
ylabel('Y');
title('Ordinary Least Squares');