function sigma=GenerateSigmaPoints(xEst,PEst,gamma)
sigma=xEst;
Psqrt=real(sqrtm(PEst));
n=length(xEst);
%Positive direction
for ip=1:n
    sigma=[sigma xEst+gamma*Psqrt(:,ip)];
end
%Negative direction
for in=1:n
    sigma=[sigma xEst-gamma*Psqrt(:,in)];
end