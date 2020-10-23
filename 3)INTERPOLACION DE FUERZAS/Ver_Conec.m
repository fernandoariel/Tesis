function Ver_Conec(rel_i,Coor_s,Coor_a,e)

n_s_i=Coor_s(e,:);
n_s_f=Coor_s(e+1,:);

r_fi=n_s_f-n_s_i; %VECTOR DEL ELEMENTO ESTRUCTURAL
n_fi=r_fi/norm(r_fi); %VERSOR DEL ELEMENTO ESTRUCTURAL

d_1=-n_fi(1)*n_s_i(1)-n_fi(2)*n_s_i(2)-n_fi(3)*n_s_i(3);
d_2=-n_fi(1)*n_s_f(1)-n_fi(2)*n_s_f(2)-n_fi(3)*n_s_f(3);

x=n_s_i(1)-4:n_s_i(1)+4;
y=n_s_i(2)-2:n_s_i(2)+2;
[x,y]=meshgrid(x,y);

z_1=(-d_1-n_fi(1)*x-n_fi(2)*y)/n_fi(3);
z_2=(-d_2-n_fi(1)*x-n_fi(2)*y)/n_fi(3);

figure (1)
hold on
plot3([n_s_i(1);n_s_f(1)],[n_s_i(2);n_s_f(2)],[n_s_i(3);n_s_f(3)],'-ob')

pos=find(rel_i(e,:)==0);


if length(pos)~=0
pos=pos(1)-1;
end

if length(pos)==0
    pos=size(rel_i,2);
end

for i=2:pos
    
    figure (1)
    hold on
    plot3(Coor_a(rel_i(e,i),1),Coor_a(rel_i(e,i),2),Coor_a(rel_i(e,i),3),'og')
    surf(x,y,z_1,'FaceColor','red','EdgeColor','none')
    surf(x,y,z_2,'FaceColor','blue','EdgeColor','none')
    
end

end