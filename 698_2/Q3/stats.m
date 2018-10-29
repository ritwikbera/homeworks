function [R,mn]=stats(x,y)

mn=[mean(x),mean(y)];
N=length(x);
data=[x y];
%covariance calculation
data=data-repmat(mn,N,1);
R=(1/N)*(data'*data);
