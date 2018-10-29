clearvars
close all
x_max = 640;
y_max = 480;
z_max = 400;

EPS = 20;
numNodes = 2000;        

q_start.coord = [0 0 0];
%q_start.coord=[200 100 50];
q_start.cost = 0;
q_start.parent = 0;
q_goal.coord = [640 400 180];
q_goal.cost = 0;


nodes(1) = q_start;
figure(1)

plot3(q_goal.coord(1),q_goal.coord(2),q_goal.coord(3),'go');
hold on;

done=0;

xr=500;
yr=450;
r=75;

t = 0:pi/10:2*pi;

[x,y,z] = cylinder(r);
z(2, :) = 400;
x=x+xr;
y=y+yr;
surf(x,y,z, 'FaceColor', [1,1,0]);

hold on;
for i = 1:1:numNodes
    q_rand = [rand(1)*x_max rand(1)*y_max rand(1)*z_max];
    
    % Break if goal node is already reached
    for j = 1:1:length(nodes)
        if dist_3d(nodes(j).coord, q_goal.coord)<50
            done=1;
            break
        end
    end
    
    if done==1
        break
    end
    
    
    % Pick the closest node from existing list to branch out from
    ndist = [];
    for j = 1:1:length(nodes)
        n = nodes(j);
        tmp = dist_3d(n.coord, q_rand);
        ndist = [ndist tmp];
    end
    [val, idx] = min(ndist);
    q_near = nodes(idx);
    
    q_new.coord = steer3d(q_rand, q_near.coord, val, EPS);
    
    if((q_new.coord(1)-xr)^2+(q_new.coord(2)-yr)^2<r^2)
        continue
    end
    
    line([q_near.coord(1), q_new.coord(1)], [q_near.coord(2), q_new.coord(2)], [q_near.coord(3), q_new.coord(3)], 'Color', 'k', 'LineWidth', 2);
    drawnow
    hold on
    q_new.cost = dist_3d(q_new.coord, q_near.coord) + q_near.cost;
    q_new.parent = idx;
    
    
    % Append to nodes
    nodes = [nodes q_new];
end

D = [];
for j = 1:1:length(nodes)
    tmpdist = dist_3d(nodes(j).coord, q_goal.coord);
    D = [D tmpdist];
end

% Search backwards from goal to start to find the optimal least cost path
[val, idx] = min(D);
q_final = nodes(idx);
q_goal.parent = idx;
q_end = q_goal;
nodes = [nodes q_goal];
while q_end.parent ~= 0
    start = q_end.parent;
    line([q_end.coord(1), nodes(start).coord(1)], [q_end.coord(2), nodes(start).coord(2)], [q_end.coord(3), nodes(start).coord(3)], 'Color', 'r', 'LineWidth', 4);
    hold on
    q_end = nodes(start);
end


