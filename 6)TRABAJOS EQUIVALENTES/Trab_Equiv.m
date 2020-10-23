clc 
clear

F_A=importdata('F_A.txt');
U_A=importdata('Desp_A_cp.dat');
F_E=importdata('F_S.txt');
U_E=importdata('coorN.dat');

W_A=dot(F_A,U_A)
W_E=dot(F_E,U_E)