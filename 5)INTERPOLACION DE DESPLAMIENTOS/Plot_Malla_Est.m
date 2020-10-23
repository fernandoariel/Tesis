function Plot_Malla_Est(X_s,Y_s,Z_s,Elem_S)

% ENTRADA DE DATOS
% X_s = COORDENADA X DE LOS NODOS ESTRUCTURALES [N° DE NODOS ESTRUCTURALES X 1]
% Y_s = COORDENADA Y DE LOS NODOS ESTRUCTURALES [N° DE NODOS ESTRUCTURALES X 1]
% Z_s = COORDENADA Z DE LOS NODOS ESTRUCTURALES [N° DE NODOS ESTRUCTURALES X 1]
% Elem_S = CANTIDAD DE ELEMENTOS ESTRUCTURALES

for j=1:1:Elem_S

   X_n_e=[ X_s(j) X_s(j+1)];
   Y_n_e=[ Y_s(j) Y_s(j+1)];
   Z_n_e=[ Z_s(j) Z_s(j+1)];    
   

   figure(1)
   hold on
   plot3(X_n_e,Y_n_e,Z_n_e,'-ok')
   %axis equal
   view(90,0)
   xlabel('CUERDA')
   ylabel('ENVERGADURA')  
   title('MALLA ESTRUCTURAL')
   
end


end