 function [x,particles,p_w]= resample_particles(particles,p_w, N_eff)
 %%resample particles
 new_particles=[];
 cdf=zeros(1,length(p_w));
 cdf(1)=p_w(1);
 for i=2:length(p_w)
     cdf(i)=cdf(i-1)+p_w(i);
 end

 for j=1:N_eff
     i=1;
     u=rand(1);
     while u>cdf(i)
         i=i+1;
     end
     new_particles=[new_particles particles(:,i)];
 end 
 particles=new_particles;
 [~,k]=max(p_w);
 x=particles(:,k);
 p_w=repmat(1/N_eff,N_eff,1);
 end