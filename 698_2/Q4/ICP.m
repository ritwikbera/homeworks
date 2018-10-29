 function [R,T] = ICP(scan1,scan2,iters,R_init,T_init,max_tresh)

 
 %Transform scan2 onto scan1
 
 % Fill in here
 m=2;  %data dimension
 thres=0.00025; %stop condition
 minIter=2;
% Initiate transformation

R=R_init;
T=T_init;

% Start the ICP algorithm

res=9e99;

%figure;

for iter=1:iters
    
    % Find closest model points to data points
    P=[];  Q=[];
    for i=1:length(scan1(1,:))
        p=scan1(:,i);
        dist=max_tresh;
        closest=[];
        for j=1:length(scan2(1,:))
            a=norm(scan2(:,j)-p);
            if a<dist
               closest=scan2(:,j);
               dist=a;
            end
        end
        if ~isempty(closest)
            P=[P closest]; Q=[Q p];
        end
    end
    diff=P-Q;
    % Find transformation

    res=mean(diff(1,:).^2+diff(2,:).^2);
    disp(res);
    
    mu_P=mean(P,2);
    mu_Q=mean(Q,2);
    C=(Q-repmat(mu_Q,1,length(Q)))*(P-repmat(mu_P,1,length(P)))';
    [U,~,V]=svd(C);
    Ri=U*V';
    Ti=mu_Q-Ri*mu_P;
    
    
    scan2=Ri*scan2;                       % Apply transformation
    for i=1:m
        scan2(i,:)=scan2(i,:)+Ti(i);      %
    end
    
    %plot(scan2(1,:),scan2(2,:),'.');
    %hold on;
    
    R=Ri*R;                           % Update transformation
    T=Ri*T+Ti;                        %
    
    if iter >= minIter
        if abs(res) < thres
            break
        end
    end
    
end

 
 


















