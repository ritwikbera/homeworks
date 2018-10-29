clear all;
load('data_points_line.mat');
x=points(:,1); y=points(:,2);
[mn,pc]=pca(points);
plot(x,y,'bo',[mn(1)-20*pc(1),mn(1)+20*pc(1)],[mn(2)-20*pc(2),mn(2)+20*pc(2)],'r');
hold on;
inliers=ransac(0.99,2,0.8,1);
[mn,pc]=pca(inliers);
plot([mn(1)-20*pc(1),mn(1)+20*pc(1)],[mn(2)-20*pc(2),mn(2)+20*pc(2)],'g');
legend('Points','PCA using whole data','PCA using inliers only');



