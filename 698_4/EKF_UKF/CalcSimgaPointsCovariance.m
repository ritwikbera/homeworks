function P=CalcSimgaPointsCovariance(xPred,sigma,wc,N)
nSigma=length(sigma(1,:));
d=sigma-repmat(xPred,1,nSigma);
P=N;
for i=1:nSigma
    P=P+wc(i)*d(:,i)*d(:,i)';
end
