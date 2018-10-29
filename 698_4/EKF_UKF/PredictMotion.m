function sigma=PredictMotion(sigma,v,g,dt)
% Sigma Points predition with motion model
for i=1:length(sigma(1,:))
    sigma(:,i)=move(sigma(:,i),v,g,dt);
end