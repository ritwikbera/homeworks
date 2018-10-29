function sdf(i,lidar_points,Problem)
filtered=[];
Image=Problem.Image(i).I;
%Image=imrotate(Image, -90);
figure;
imshow(Image);
hold on;
X_hc=transform(Problem.X_hc(i).X_hc);
X_hl=transform(Problem.X_hl);
K=Problem.K(i).K;

cam_points=inv(X_hc)*X_hl*lidar_points';
for i=1:length(lidar_points(:,1))
    if cam_points(3,i)>0 && cam_points(1,i)>0 && cam_points(1,i)<2
        filtered=[filtered cam_points(:,i)];
    end
end
cam_points=filtered;

frame_points=K*[cam_points(1,:); cam_points(2,:); cam_points(3,:)];
plot(frame_points(1,:)./frame_points(3,:),frame_points(2,:)./frame_points(3,:),'b.');

%figure;

%plot(cam_points(2,:),cam_points(3,:),'b.');
%xlabel('Camera Y'); ylabel('Camera Z');

%plot3(cam_points(1,:),cam_points(2,:),cam_points(3,:),'b.');
%xlabel('Camera X'); ylabel('Camera Y'); zlabel('Camera Z');