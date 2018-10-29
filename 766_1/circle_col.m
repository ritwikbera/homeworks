function colliding=circle_col(x,y,xc,yc,r)
a=(x-xc).^2+(y-yc).^2-r^2;
colliding=0;
for i=1:length(a)
    if a(i)<0
        colliding=1;
        break;
    end
end
