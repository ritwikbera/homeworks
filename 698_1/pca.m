function [mn,pc]=pca(points)
x=points(:,1); y=points(:,2);
mn=[mean(x),mean(y)];
N=length(x);
data=points;
data=data-repmat(mn,N,1);
R=(1/N)*(data'*data);
[pc,v]=eig(R);
v=diag(v);
[max_value,max_index]=max(abs(v));
pc=pc(:,max_index);
