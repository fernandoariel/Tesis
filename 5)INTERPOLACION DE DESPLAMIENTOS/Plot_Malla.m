function Plot_Malla(X_a,Y_a,Z_a,X_s,Y_s,Z_s,Elem_A,Elem_A_b,Elem_S)

% ENTRADA DE DATOS
% X_a = COORDENADA X DE LOS NODOS AERODINAMICOS [N° DE NODOS AERODINAMICOS X 1]
% Y_a = COORDENADA Y DE LOS NODOS AERODINAMICOS [N° DE NODOS AERODINAMICOS X 1]
% Z_a = COORDENADA Z DE LOS NODOS AERODINAMICOS [N° DE NODOS AERODINAMICOS X 1]
% X_s = COORDENADA X DE LOS NODOS ESTRUCTURALES [N° DE NODOS ESTRUCTURALES X 1]
% Y_s = COORDENADA Y DE LOS NODOS ESTRUCTURALES [N° DE NODOS ESTRUCTURALES X 1]
% Z_s = COORDENADA Z DE LOS NODOS ESTRUCTURALES [N° DE NODOS ESTRUCTURALES X 1]
% Elem_A = CANTIDAD DE ELEMENTOS AERODINAMICOS
% Elem_A_b = CANTIDAD DE ELEMENTOS AERODINAMICOS A LO LARGO DE LA ENVERGADURA
% Elem_S = CANTIDAD DE ELEMENTOS ESTRUCTURALES

N_A_b=Elem_A_b+1;

kc=0;
Ex=1:Elem_A_b:Elem_A;
for k=1:1:Elem_A
    
    if k== Ex(find(k==Ex)) & k~=1
        kc=kc+1;    
    end
    
    X_n_a=[ X_a(k+kc) X_a(k+1+kc) X_a(k+N_A_b+1+kc) X_a(k+N_A_b+kc)  X_a(k+kc) ];
    Y_n_a=[ Y_a(k+kc) Y_a(k+1+kc) Y_a(k+N_A_b+1+kc) Y_a(k+N_A_b+kc)  Y_a(k+kc) ];
    Z_n_a=[ Z_a(k+kc) Z_a(k+1+kc) Z_a(k+N_A_b+1+kc) Z_a(k+N_A_b+kc)  Z_a(k+kc) ];
   
    figure (1)
    hold on
    plot3(X_n_a,Y_n_a,Z_n_a,'-k')
    axis equal
    
    figure (2)
    hold on
    plot3(X_n_a,Y_n_a,Z_n_a,'k')    
    axis equal
    view(45,45)
    xlabel('CUERDA')
    ylabel('ENVERGADURA') 
    title('MALLA AERODINAMICA')
end


for j=1:1:Elem_S

   X_n_e=[ X_s(j) X_s(j+1)];
   Y_n_e=[ Y_s(j) Y_s(j+1)];
   Z_n_e=[ Z_s(j) Z_s(j+1)];    
   
   figure(1)
   hold on
   plot3(X_n_e,Y_n_e,Z_n_e,'-or','LineWidth',2,'MarkerFaceColor','r','MarkerSize',4)
   axis equal
   view(45,45)
   xlabel('CUERDA')
   ylabel('ENVERGADURA')
   title('SUPERPOSICION DE MALLAS')

   figure(3)
   hold on
   plot3(X_n_e,Y_n_e,Z_n_e,'-ok')
   axis equal
   view(45,45)
   xlabel('CUERDA')
   ylabel('ENVERGADURA')  
   title('MALLA ESTRUCTURAL')
   
end


end