
function P=CalcPxz(sigma,xPred,zSigma,zb,wc)
nSigma=length(sigma(1,:));
dx=sigma-repmat(xPred,1,nSigma);
dz=zSigma-repmat(zb,1,nSigma);
P=zeros(length(sigma(:,1)),length(zSigma(:,1)));
for i=1:nSigma
    P=P+wc(i)*dx(:,i)*dz(:,i)';
end