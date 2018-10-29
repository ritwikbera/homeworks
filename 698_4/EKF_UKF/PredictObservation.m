function zsigma=PredictObservation(sigma,m)
% Sigma Points predition with observation model
zsigma=zeros(2,length(sigma(1,:)));
for i=1:length(sigma(1,:))
    zsigma(:,i)=measure(sigma(:,i),m);
end