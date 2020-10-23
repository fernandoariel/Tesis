function G_A_S=matriz_int(Coor_A,Coor_E,Conec_E,rel_i,rel_e,Coor_Int)

% DATOS DE ENTRADA
% Coor_A = COORDENADAS DE LOS NODOS AERODINAMICOS EN M [N° DE NODOS AERODINAMICOS x 3]
% Coor_E = COORDENADAS DE LOS NODOS ESTRUCTURALES EN M [N° DE NODOS ESTRUCTURALES x 3]
% Conec_E = CONECTIVIDADES [N° DE ELEMENTOS ESTRUCTURALES x 3]
% rel_i = MATRIZ DE RELACIONES ENTRE ELEMENTOS ESTRUCTURALES Y NODOS INTERNOS
% rel_e = NODOS EXTERNOS A LA MALLA ESTRUCTURAL

Elem_E=size(Conec_E,1);%CANTIDAD DE ELEMENTOS ESTRUCTURALES

G_A_S=zeros(3*size(Coor_A,1),6*Elem_E);%SE CREA UNA MATRIZ CON LAS DIMENSIONES NECESARIAS CON SUS ELEMENTOS NULOS

for i=1:Elem_E%CICLO DESDE 1 HASTA LA CANTIDAD DE ELEMENTOS ESTRUCTURALES
    
    for j=2:size(rel_i,2)%CICLO DESDE 2 HASTA EL TAMAÑO DE LAS FILAS DEL ARREGLO "rel_i"
        
        a=rel_i(i,j);
        n_i_s=i;
        n_f_s=i+1;
        
        if a>0
            

            
           G_A_S((a-1)*3+1:(a-1)*3+3 , (n_i_s-1)*6+1:(n_i_s-1)*6+12)= Funcion_Forma_IP_4(Coor_E(i,:),Coor_E(i+1,:),Coor_E(i+1+Elem_E,:),Coor_A(a,:),Coor_Int(a,1:3));
            
        end
        
    end


end

for k=1:size(rel_e,2)%CICLO DESDE 1 HASTA EL TAMAÑO DEL ARREGLO "rel_e"
   
   b=rel_e(k);
   if b>0
      n_a_p=Coor_A(b,:);
      c=Elem_E+1;
      n_s_p=Coor_E(c,:);
      G_A_S( (b-1)*3+1:(b-1)*3+3 , (c-1)*6+1:(c-1)*6+6 )=Funcion_Forma_EP(n_s_p,n_a_p); 
   end

   
end

for l=1:size(Coor_A,1)%CICLO DESDE 1 HASTA EL NUMERO DE COORDENADAS AERODINAICAS
   if Coor_A(l,2)==0
       G_A_S((l-1)*3+1:(l-1)*3+3 ,:)=0;
   end
end

end