function plot_path(nodes,q_goal)

%find nearest crowfly point to goal point
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