function no_collision=nocol(points, obs)
no_collision=true;
for i=1:length(points)
    if inpolygon(points(1),points(2),obs(1,:),obs(2,:))
        no_collision=false;
        break;
    end
end
