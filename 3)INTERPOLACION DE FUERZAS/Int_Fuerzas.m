clc
clear

Fuer_A=importdata('Fuer_A_Datos.txt');
Coor_A=importdata('Coor_PC.csv');
Coor_E=importdata('Est_coor.dat');
Conec_E=importdata('Est_ien.dat');

F_A=Fuer_Aer( Fuer_A.data(:,1:3) , Fuer_A.data(:,4) , Fuer_A.data(:,5) , 33.5 , 1.225 );

rel_e = Rel_Ext_2(Coor_A,Coor_E);
[rel_i,Coor_Int] = Rel_Int_3(Coor_A(:,1),Coor_A(:,2),Coor_A(:,3),Coor_E(:,1),Coor_E(:,2),Coor_E(:,3));

NO=Verif(rel_i,330)

G = Matriz_Int(Coor_A,Coor_E,Conec_E,rel_i,rel_e,Coor_Int);

F_S=G.'*F_A

f_load=f_load(F_S);

dlmwrite('F_S.txt',F_S,'delimiter','\t');
dlmwrite('F_A.txt',F_A,'delimiter','\t');
hold on
plot(Coor_A(:,1),Coor_A(:,2),'*b')
plot(Coor_E(:,1),Coor_E(:,2),'ok')