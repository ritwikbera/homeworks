clear all;
load('Problem.mat');
lidar_points=Problem.scan;
lidar_points=[lidar_points ones(length(lidar_points),1)];
for i=1:5
    sdf(i,lidar_points,Problem);
end
