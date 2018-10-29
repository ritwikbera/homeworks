
clc;
clear all;
close all;


x_max = 1000;
y_max = 1000;
obstacle = [500,0,150,700];
obstacle2 = [200,250,100,700];
EPS = 20;
numNodes = 3000;        

%tree parameters
q_start.coord = [0 0];
q_start.cost = 0;
q_start.parent = 0;
q_goal.coord = [900 900];
q_goal.cost = 0;
q_goal.parent=0;

nodesA(1) = q_start;
nodesB(1)=q_goal;

plot(q_goal.coord(1),q_goal.coord(2),'g.');
hold on;

%prepping up plot
figure(1)
axis([0 x_max 0 y_max])
%patch([300,510,520,600,300],[500,500,300,700,500],'b');
rectangle('Position',obstacle,'FaceColor',[0 .5 .5])
hold on;
rectangle('Position',obstacle2,'FaceColor',[0 .5 .5])
hold on;

breakit=0;

for i = 1:1:numNodes
    
    % Break if trees are close enough to be joined
    for a = 1:1:length(nodesA)
        for b=1:1:length(nodesB) 
            if dist(nodesA(a).coord,nodesB(b).coord)<100;
                goalA=nodesB(b);
                goalB=nodesA(a);
                breakit=1;
                break;
            end
        end
    end
    
    if breakit==1
        break;
    end
    
    nodesA=build_tree(nodesA);
    nodesB=build_tree(nodesB);  %Comment this line out for single RRT
    
end

plot_path(nodesA,goalA);
plot_path(nodesB,goalB);




