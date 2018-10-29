function [nodes]=build_tree(nodes)
    x_max = 1000;
    y_max = 1000;
    obstacle = [500,0,150,700];
    obstacle2 = [200,250,100,700];
    %obs=[[500,510,520,600,500] [500,500,300,700,500]]';
    EPS = 20;

    q_rand = [floor(rand(1)*x_max) floor(rand(1)*y_max)];
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
        points=[linspace(q_near.coord(1),q_new.coord(1),5) linspace(q_near.coord(2),q_new.coord(2),5)];
    %if nocol(points,obs)
    if noCollision(q_rand, q_near.coord, obstacle) && noCollision(q_rand, q_near.coord, obstacle2)
        line([q_near.coord(1), q_new.coord(1)], [q_near.coord(2), q_new.coord(2)], 'Color', 'r', 'LineWidth', 2);
        drawnow
        hold on
        q_new.cost = dist(q_new.coord, q_near.coord) + q_near.cost;
        
        % Append to nodes
        nodes = [nodes q_new];
    end
