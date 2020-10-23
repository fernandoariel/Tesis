function [R_i,Coor_Int]=Rel_Int(X_a,Y_a,Z_a,X_s,Y_s,Z_s)

% ENTRADA DE DATOS
% X_a = COORDENADA X DE LOS NODOS AERODINAMICOS [N° DE NODOS AERODINAMICOS X 1]
% Y_a = COORDENADA Y DE LOS NODOS AERODINAMICOS [N° DE NODOS AERODINAMICOS X 1]
% Z_a = COORDENADA Z DE LOS NODOS AERODINAMICOS [N° DE NODOS AERODINAMICOS X 1]
% X_s = COORDENADA X DE LOS NODOS ESTRUCTURALES [N° DE NODOS ESTRUCTURALES X 1]
% Y_s = COORDENADA Y DE LOS NODOS ESTRUCTURALES [N° DE NODOS ESTRUCTURALES X 1]
% Z_s = COORDENADA Z DE LOS NODOS ESTRUCTURALES [N° DE NODOS ESTRUCTURALES X 1]

% SALIDA DE DATOS
% R_i = MATRIZ DE RELACIONES DE ELEMENTOS Y NODOS DE LOS NODOS INTERIORES AL ELEMENTO
%       COLUMN 1         ----         RESTOS DE LAS COLUMNAS
% NUMERO DEL ELEMENTO             NODOS RELACIONADOS AL ELEMENTO

N_a=size(X_a,1);%CANTIDAD DE NODOS AERODINAMICOS 

E_s=(size(X_s,1)-1)/2;%CANTIDAD DE ELEMENTOS ESTRUCTURALES

R_i=zeros(E_s,1);%SE DEFINE LA MATRIZ DE RELACIONES
Coor_Int=zeros(N_a,3);%SE DEFINE EL ARREGLO CON LAS COORDENADAS DE LOS PUNTOS INTERIORES DE CORTE

R_i(1:E_s,1)=1:E_s;%SE ASIGNAN LOS NUMEROS DE LOS ELEMENTOS ESTRUCTURALES A LA PRIMER COLUMNA

L_r=[]; % LISTA DONDE SE REGISTRAN LOS NODOS AERODINAMICOS
k=1; %CONTADOR DE NODOS REGISTRADOS
for i=1:1:E_s
   
    n_i=i;%NODO INCIAL DEL ELEMENTO i
    n_f=i+1;%NODO FINAl DEL ELEMENTO i
    n_3=E_s+1+i;%TERCER NODO DEL ELEMENTO i
    
    coor_i=[X_s(n_i) Y_s(n_i) Z_s(n_i)];%COORDENADAS DEL NODO INCIAL
    coor_f=[X_s(n_f) Y_s(n_f) Z_s(n_f)];%COORDENADAS DEL NODO FINAL
    coor_3=[X_s(n_3) Y_s(n_3) Z_s(n_3)]; %COORDENADA DEL TERCER NODO
    
    r_fi=coor_f-coor_i;%VECTOR DEL ELEMENTO i
    n_fi=r_fi/norm(r_fi);%VERSOR DEL ELEMENTO i
    r_3i=coor_3-coor_i;
    L_3=norm(r_3i);
    t=2;%CONTADOR PARA ASIGNAR UN VALOR EN LA MATRIZ DE RELACIONES
    
    for j=1:1:N_a
       
       coor_a=[X_a(j) Y_a(j) Z_a(j)];%COORDENADAS DEL NODO AERODINAMICO j
       
       r_ai=coor_a-coor_i;%VECTOR DEL NODO INICAL i AL NODO AERODINAMICO a
       p=dot(r_ai,r_fi)/(norm(r_fi)^2);%PROYECCION NORMALIZADA DEL VECTOR r_ai SOBRE EL ELEMENTO 
       
       r_bi=(p)*n_fi; % VECTOR DEL NODO INICIAL i AL PUNTO INTERIOR b
       
       h=abs(dot(r_ai,r_3i)/norm(r_3i));%PROYECCION DEL VECTOR r_ai SOBRE EL VECTOR DEL TERCER NODO
       
       b=coor_i+r_bi*norm(r_fi); %COORDENADAS DEL PUNTO INTERIOR b
       r_ab=coor_a-b; %VECTOR DEL PUNTO INTERIOR b AL NODO AERODINAMICO a
       


       if p>=0 & p<=1
           

       
                 NO=find(L_r==j);              
                 NO=length(NO);
                 

                 if NO==0 & h<=.5*L_3 
                     R_i(i,t)=j;
                     Coor_Int(j,1:3)=b;
                     t=t+1;
                     L_r(k)=j;
                     k=k+1;
                     
                              
               
                
                                  
                 end
       end

end


end