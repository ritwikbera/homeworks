function inliers=ransac(p,s,w,threshold)
load('data_points_line.mat');
%plot(points(:,1),points(:,2),'o');
hold on;
num=length(points(:,1));  %number of points
bestInNum=0;                %best number of inliers
%p=0.99; s=2; w=0.8; threshold=1;        %RANSAC input
N=log(1-p)/log(1-w^s);

for i=1:round(N)
    %choose 2 points randomly
    randIdx=randi([1,num],1,2);  
    sample=points(randIdx,:);
 
    
    line = sample(2,:)-sample(1,:);% two points relative distance
    lineNorm = line/norm(line);
    normal = [-lineNorm(2),lineNorm(1)];     %computing normal to line
    distance = (points - repmat(sample(1,:),num,1))*normal';
    
    %find inliers
    inlierIdx=find(abs(distance)<=threshold);  
    if length(inlierIdx)>bestInNum
        bestInNum=length(inlierIdx);
        inliers=points(inlierIdx,:);
    end
end
%plot(inliers(:,1),inliers(:,2),'ro');
