clear 
clc

Coor_A=importdata('CO_AER.txt');
Coor_E=importdata('Est_coor.dat');
Conec_E=importdata('Est_ien.dat');
Conec_A=importdata('IEN_AER.txt');
V_S=importdata('coorN.dat');

Elem_E=size(Conec_E,1);

Plot_Malla(Coor_A(:,1),Coor_A(:,2),Coor_A(:,3),Coor_E(:,1),Coor_E(:,2),Coor_E(:,3),330,66,8)

rel_e= Rel_Ext_2(Coor_A,Coor_E );
[rel_i,Coor_Int] = Rel_Int_3(Coor_A(:,1),Coor_A(:,2),Coor_A(:,3),Coor_E(:,1),Coor_E(:,2),Coor_E(:,3));

G = Matriz_Int(Coor_A,Coor_E,Conec_E,rel_i,rel_e,Coor_Int);

U_A=G*V_S;

U_A_cp=Desp_Pto_Ctrol(U_A,Conec_A);

dlmwrite('Desp_A_cp.dat',U_A_cp,'delimiter','\t');

U_a_x=zeros(size(Coor_A,1),1);
U_a_y=zeros(size(Coor_A,1),1);
U_a_z=zeros(size(Coor_A,1),1);

 for l=1:size(Coor_A,1)
     
     U_a_x(l)=U_A(3*l-2);
     U_a_y(l)=U_A(3*l-1);
     U_a_z(l)=U_A(3*l);
     
 end

X_a_n=Coor_A(:,1)+U_a_x;
Y_a_n=Coor_A(:,2)+U_a_y;
Z_a_n=Coor_A(:,3)+U_a_z;

V_s_x=zeros(size(Coor_E,1),1);
V_s_y=zeros(size(Coor_E,1),1);
V_s_z=zeros(size(Coor_E,1),1);

correc_m=-1;
 for m=1:Elem_E+1
     
     correc_m=correc_m+1;
     V_s_x(m)=V_S(3*(m+correc_m)-2);
     V_s_y(m)=V_S(3*(m+correc_m)-1);
     V_s_z(m)=V_S(3*(m+correc_m));
     
 end

X_e_n=Coor_E(:,1)+V_s_x;
Y_e_n=Coor_E(:,2)+V_s_y;
Z_e_n=Coor_E(:,3)+V_s_z;

% Color_Malla(X_a_n,Y_a_n,Z_a_n,X_e_n,Y_e_n,Z_e_n,330,66,8)

Coor_n= [X_a_n Y_a_n Z_a_n];
dlmwrite('Coor_Aer_Nuevas.dat',Coor_n,'delimiter','\t');