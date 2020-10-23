function G_a_s = fun_form_ip(n_i,n_f,n_3,B,A)

% n_i=COORDENADAS DEL NODO INICIAL ESTRUCTURAL [1x3]
% n_f=COORDENADAS DEL NODO FINAL ESTRUCTURAL [1x3]
% n_3=COORDENADAS DEL TERCER NODO [1x3]
% B=CORDENADAS DE UN NODO AERODINAMICO [1x3]
% A=CORDENADAS DE UN PUNTO INTERIOR DEL ELEMENTO ESTRUCTURAL [1x3]

h_e=norm(n_f-n_i);%LONGITUD DEL ELEMENTO

L_A=norm(A-n_i);%LONGITUD DEL PUNTO INTERIOR

r=B-A;%DISTANCIA DEL PUNTO INTERIOR AL PUNTO AERODINAMICO


%MATRIZ DE TRANSFORMACION DE FUERZAS AERODINAMICAS A FUERZAS ESTRUCTURALES
T_Fm=eye(6,3);
T_Fm(5)=r(3);
T_Fm(6)=-r(2);
T_Fm(10)=-r(3);
T_Fm(12)=r(1);
T_Fm(16)=r(2);
T_Fm(17)=-r(1);

%MATRIZ DE ROTACION
r_gl=zeros(3);
%versores globales
n_x_g=[1 0 0];
n_y_g=[0 1 0];
n_z_g=[0 0 1];
%versores locales
n_x_l=(n_f-n_i)/norm(n_f-n_i);
n_z_l=(n_3-n_i)/norm(n_3-n_i);
n_y_l=cross(n_z_l,n_x_l);

c_a_x=dot(n_x_g,n_x_l)/(norm(n_x_g)*norm(n_x_l));
c_a_y=dot(n_y_g,n_x_l)/(norm(n_x_g)*norm(n_x_l));
c_a_z=dot(n_z_g,n_x_l)/(norm(n_x_g)*norm(n_x_l));

c_b_x=dot(n_x_g,n_y_l)/(norm(n_x_g)*norm(n_y_l));
c_b_y=dot(n_y_g,n_y_l)/(norm(n_y_g)*norm(n_y_l));
c_b_z=dot(n_z_g,n_y_l)/(norm(n_z_g)*norm(n_y_l));

c_g_x=dot(n_x_g,n_z_l)/(norm(n_x_g)*norm(n_z_l));
c_g_y=dot(n_y_g,n_z_l)/(norm(n_y_g)*norm(n_z_l));
c_g_z=dot(n_z_g,n_z_l)/(norm(n_z_g)*norm(n_z_l));

r_gl=[c_a_x c_b_x c_g_x;
     c_a_y c_b_y c_g_y;
     c_a_z c_b_z c_g_z];

R_G_L=zeros(6);
R_G_L(1:3,1:3)=r_gl;
R_G_L(4:6,4:6)=r_gl;

T_G_L=zeros(12);
T_G_L(1:3,1:3)=r_gl;
T_G_L(4:6,4:6)=r_gl;
T_G_L(7:9,7:9)=r_gl;
T_G_L(10:12,10:12)=r_gl;

% FUNCIONES DE FORMA
L_1=@(x) (h_e-x)/h_e;
L_2=@(x) x/h_e;
H_1=@(x) 1-3*(x/h_e)^2+2*(x/h_e)^3;
H_2=@(x) x*(1-x/h_e)^2;
H_3=@(x) 3*(x/h_e)^2-2*(x/h_e)^3;
H_4=@(x) x*((x/h_e)^2-x/h_e);
H_1_d=@(x) (6*x^2)/h_e^3 - (6*x)/h_e^2;
H_2_d=@(x) (x/h_e - 1)^2 + (2*x*(x/h_e - 1))/h_e;
H_3_d=@(x) (6*x)/h_e^2 - (6*x^2)/h_e^3;
H_4_d=@(x) x*((2*x)/h_e^2 - 1/h_e) - x/h_e + x^2/h_e^2;

h_u_1=zeros(3);
h_u_2=zeros(3);
h_u_3=zeros(3);
h_u_4=zeros(3);

h_u_1(1)=L_1(L_A);
h_u_1(5)=H_1(L_A);
h_u_1(9)=H_1(L_A);

h_u_2(6)=-H_2(L_A);
h_u_2(8)=H_2(L_A);

h_u_3(1)=L_2(L_A);
h_u_3(5)=H_3(L_A);
h_u_3(9)=H_3(L_A);

h_u_4(6)=-H_4(L_A);
h_u_4(8)=H_4(L_A);

H_U=[h_u_1 h_u_2 h_u_3 h_u_4];

h_tit_1=zeros(3); 
h_tit_2=zeros(3); 
h_tit_3=zeros(3); 
h_tit_4=zeros(3);

h_tit_1(6)=H_1_d(L_A);
h_tit_1(8)=-H_1_d(L_A);

h_tit_2(1)=L_1(L_A);
h_tit_2(5)=H_2_d(L_A);
h_tit_2(9)=H_2_d(L_A);

h_tit_3(2)=-H_3_d(L_A);
h_tit_3(6)=H_3_d(L_A);

h_tit_4(1)=L_2(L_A);
h_tit_4(5)=H_4_d(L_A);
h_tit_4(9)=H_4_d(L_A);

H_TIT=[h_tit_1 h_tit_2 h_tit_3 h_tit_4];

H=[H_U;H_TIT];

G_a_s=T_G_L*H.'*R_G_L.'*T_Fm;

G_a_s=G_a_s.';

end
