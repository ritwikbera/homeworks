% RRT* algorithm in 2D with collision avoidance.
% 
% Author: Sai Vemprala
% 
% nodes:    Contains list of all explored nodes. Each node contains its
%           coordinates, cost to reach and its parent.
% 
% Brief description of algorithm: 
% 1. Pick a random node q_rand.
% 2. Find the closest node q_near from explored nodes to branch out from, towards
%    q_rand.
% 3. Steer from q_near towards q_rand: interpolate if node is too far away, reach
%    q_new. Check that obstacle is not hit.
% 4. Update cost of reaching q_new from q_near, treat it as Cmin. For now,
%    q_near acts as the parent node of q_new.
% 5. From the list of 'visited' nodes, check for nearest neighbors with a 
%    given radius, insert in a list q_nearest.
% 6. In all members of q_nearest, check if q_new can be reached from a
%    different parent node with cost lower than Cmin, and without colliding
%    with the obstacle. Select the node that results in the least cost and 
%    update the parent of q_new.
% 7. Add q_new to node list.
% 8. Continue until maximum number of nodes is reached or goal is hit.
clc;
clear all;
close all;

x_max = 1000;
y_max = 1000;
obstacle = [500,150,200,200];
EPS = 20;
numNodes = 3000;        

q_start.coord = [0 0];
q_start.cost = 0;
q_start.parent = 0;
q_goal.coord = [900 900];
q_goal.cost = 0;

nodes(1) = q_start;
figure(1)
axis([0 x_max 0 y_max])
rectangle('Position',obstacle,'FaceColor',[0 .5 .5])
hold on

breakit=0;

for i = 1:1:numNodes
    q_rand = [floor(rand(1)*x_max) floor(rand(1)*y_max)];
    %plot(q_rand(1), q_rand(2), 'x', 'Color',  [0 0.4470 0.7410])
    
    % Break if goal node is already reached
    for j = 1:1:length(nodes)
        if dist(nodes(j).coord,q_goal.coord)<100;
            breakit=1;
            break
        end
    end
    
    if breakit==1
        break
    end
    
    
    % Pick the closest node from existing list to branch out from
    
    %finding nearest node among existing ones
    ndist = [];
    for j = 1:1:length(nodes)
        n = nodes(j);
        tmp = dist(n.coord, q_rand);
        ndist = [ndist tmp];
    end
    [val, idx] = min(ndist);
    q_near = nodes(idx);
    q_new.parent=idx;
    
    %creating new node accordingly in that direction and assigning cost to
    %start point
    %q_near is nearest node among existing ones
    
    q_new.coord = steer(q_rand, q_near.coord, val, EPS);
    if noCollision(q_rand, q_near.coord, obstacle)
        line([q_near.coord(1), q_new.coord(1)], [q_near.coord(2), q_new.coord(2)], 'Color', 'r', 'LineWidth', 2);
        drawnow
        hold on
        q_new.cost = dist(q_new.coord, q_near.coord) + q_near.cost;
        
%         % Within a radius of r of newly created node, find all existing nodes
%         q_nearest = [];
%         r = 60;
%         neighbor_count = 1;
%         for j = 1:1:length(nodes)
%             if noCollision(nodes(j).coord, q_new.coord, obstacle) && dist(nodes(j).coord, q_new.coord) <= r
%                 q_nearest(neighbor_count).coord = nodes(j).coord;
%                 q_nearest(neighbor_count).cost = nodes(j).cost;
%                 neighbor_count = neighbor_count+1;
%             end
%         end
%         
%         % Initialize cost to currently known value
%         q_min = q_near;
%         C_min = q_new.cost;
%         
%         % Iterate through all nearest neighbors of new node to find alternate lower
%         % cost paths
%         
%         for k = 1:1:length(q_nearest)
%             if noCollision(q_nearest(k).coord, q_new.coord, obstacle) && q_nearest(k).cost + dist(q_nearest(k).coord, q_new.coord) < C_min
%                 q_min = q_nearest(k);
%                 C_min = q_nearest(k).cost + dist(q_nearest(k).coord, q_new.coord);
%                 line([q_min.coord(1), q_new.coord(1)], [q_min.coord(2), q_new.coord(2)], 'Color', 'g');                
%                 hold on
%             end
%         end
%         
%         % Update parent of newly made node by choosing least cost node as
%         % checked above (parents are closest nodes and child-parent
%         % traversal leads to goal to start traversal
%         
%         for j = 1:1:length(nodes)
%             if nodes(j).coord == q_min.coord
%                 q_new.parent = j;
%             end
%         end
        
        % Append to nodes
        nodes = [nodes q_new];
    end
end

%find crowfly distances of all nodes to goal

D = [];
for j = 1:1:length(nodes)
    tmpdist = dist(nodes(j).coord, q_goal.coord);
    D = [D tmpdist];
end

% Search backwards from goal to start to find the optimal least cost path

%begin with closest node to goal
[val, idx] = min(D);
q_final = nodes(idx);
q_goal.parent = idx;

q_end = q_goal;
nodes = [nodes q_goal];
while q_end.parent ~= 0
    start = q_end.parent;
    line([q_end.coord(1), nodes(start).coord(1)], [q_end.coord(2), nodes(start).coord(2)], 'Color', 'b', 'LineWidth', 2);
    hold on
    q_end = nodes(start);
end


