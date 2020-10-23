function U_A_cp = Desp_Pto_Ctrol (U_A,Conec_A)

% ENTRADAS
% U_A = Desplazamientos de los nodos aerodinamicos
% Conec_A = Conectividades de los elementos aerodinamicos 

T3=0.25*[eye(3)  eye(3)  eye(3)  eye(3)];

U_A_cp=zeros(size(Conec_A,1),1);%Vector donde se almacenan los desplazamientos de los puntos de control inicialmente nulo

for i=1:1:size(Conec_A,1)%Ciclo que recorre todos los elementos
   
   U_A_np=zeros(12,1);%Vector con los desplazamientos de los nodos del elemento inicialmente nulo 
    
   N_1=Conec_A(i,1); %Nodo 1 del elemento i
   N_2=Conec_A(i,2); %Nodo 2 del elemento i
   N_3=Conec_A(i,3); %Nodo 3 del elemento i
   N_4=Conec_A(i,4); %Nodo 4 del elemento i
    
   U_A_np(1:3)=U_A(3*N_1-2:3*N_1);
   U_A_np(4:6)=U_A(3*N_2-2:3*N_2);
   U_A_np(7:9)=U_A(3*N_3-2:3*N_3);
   U_A_np(10:12)=U_A(3*N_4-2:3*N_4);
   
   U_a_cp=T3*U_A_np;
   
   U_A_cp(3*i-2:3*i)=U_a_cp;
   
end

end
