function H=transform(pose)
theta=[pose(4) pose(5) pose(6)]*pi/180;
Rx=[1 0 0;
    0 cos(theta(1)) -sin(theta(1));
    0 sin(theta(1)) cos(theta(1))];
Ry=[cos(theta(2)) 0 sin(theta(2));
    0 1 0;
    -sin(theta(2)) 0 cos(theta(2))];
Rz=[cos(theta(3)) -sin(theta(3)) 0;
    sin(theta(3)) cos(theta(3)) 0;
    0 0 1];
R=Rz*Ry*Rx;
H=[R [pose(1) pose(2) pose(3)]'; zeros(1,3) 1];