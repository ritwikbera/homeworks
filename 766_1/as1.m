clear all;
close all;
l1=2; l2=2;    %link lengths
n=7; %link discretisation
rect_col=[]; tri_col=[]; cir_col=[]; no_col=[];
subplot(1,2,1);
plot([-4,4,4,-4],[-4,-4,4,4],'b');  %work boundary
arm=plot([0,l1,l1+l2],[0,0,0]);

%rectangle obstacle
xr = [-2 -2 -3 -3 -2] ;
yr = [2 3 3 2 2];
patch(xr(1:4),yr(1:4),'red');
hold on;
%triangle obstacle
xt=[-2 -3 -3 -2];
yt=[-3 -3 -1 -3];
patch(xt(1:3),yt(1:3),'green');
hold on;
%circular obstacle
xc=2;yc=2;r=1;
circle(xc,yc,r);
hold on;

axis([-4,4,-4,4]);

%show C-space
 subplot(1,2,2);


%computation
for theta1=0:0.02:2*pi
    for theta2=0:0.02:2*pi
        x1=l1*cos(theta1);
        y1=l1*sin(theta1);
        x2=x1+l2*cos(theta1+theta2);
        y2=y1+l2*sin(theta1+theta2);
        x=[linspace(0,x1,n) linspace(x1,x2,n)];
        y=[linspace(0,y1,n) linspace(y1,y2,n)];
        
        set(arm,'XData',x);    
        set(arm, 'YData',y);
        %refreshdata;

        in_rect=inpolygon(x,y,xr,yr);
        in_tri=inpolygon(x,y,xt,yt);
        in_circle=circle_col(x,y,xc,yc,r);
        
        if ~isequal(in_rect,false(1,2*n))
            rect_col=[rect_col [theta1; theta2]];
            %plot(theta1,theta2,'r.'); hold on;
        elseif ~isequal(in_tri,false(1,2*n))
            tri_col=[tri_col [theta1; theta2]];
            %plot(theta1,theta2,'g.'); hold on;
        elseif in_circle==1;
            cir_col=[cir_col [theta1; theta2]];
            %plot(theta1,theta2,'b.'); hold on;
        else
            no_col=[no_col [theta1; theta2]];
            %plot(theta1,theta2,'k.'); hold on;
        end
        %drawnow;
    end
end
 plot(rect_col(1,:),rect_col(2,:),'ro',tri_col(1,:),tri_col(2,:),'go',cir_col(1,:),cir_col(2,:),'bo',no_col(1,:),no_col(2,:),'ko');
  title('C-space');
  xlabel('theta 1 (radians)');
  ylabel('theta 2 (radians)');
  axis([0,2*pi,0,2*pi]);

 