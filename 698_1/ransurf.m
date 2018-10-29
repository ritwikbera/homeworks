clear all;
load('data_points_plane.mat');
x=points(:,1); y=points(:,2); z=points(:,3);
plot3(x,y,z,'.'); 
hold on;
title('RANSAC plane');
num=length(points(:,1));  %number of points
bestInNum=0;                %best number of inliers
p=0.99; s=3; w=0.9; threshold=2;        %RANSAC input, 3points for plane fit
N=log(1-p)/log(1-w^s);

for i=1:round(N)
    %choose 3 points randomly
    randIdx=randi([1,num],1,3);  
    sample=points(randIdx,:);
    
    v1=sample(2,:)-sample(1,:);
    v2=sample(3,:)-sample(1,:);     
    normal=cross(v1,v2);
    normal=normal/norm(normal);
    distance = (points - repmat(sample(1,:),num,1))*normal';
    
    %find inliers
    inlierIdx=find(abs(distance)<=threshold);  
    if length(inlierIdx)>bestInNum
        bestInNum=length(inlierIdx);
        inliers=points(inlierIdx,:);
    end
end

[X,Y]=meshgrid(-50:50,-50:50);

%RANSAC plane plotting
xi=inliers(:,1); yi=inliers(:,2); zi=inliers(:,3);
%plot3(xi,yi,zi,'r.');       %plotting ransac inliers
a=[xi yi ones(bestInNum,1)];
theta=inv(a'*a)*a'*(-zi);
Z=-1*(theta(1)*X+theta(2)*Y+theta(3));        %equation of plane
rsurf=surf(X,Y,Z,'FaceColor',[1 0 0],'FaceAlpha',0.5,'LineStyle','none');

hold on;
a=[x y ones(num,1)];
theta=inv(a'*a)*a'*(-z);
ZO=-1*(theta(1)*X+theta(2)*Y+theta(3));
osurf=surf(X,Y,ZO,'FaceColor',[0 1 0],'FaceAlpha',0.5,'LineStyle','none');

legend('points','Using RANSAC inliers only','Using whole data');

