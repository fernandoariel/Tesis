function R_e=Rel_2(Y_a,Y_s)

% ENTRADA DE DATOS
% Y_a = COORDENADAS DE LOS NODOS AERODINAMICOS [N° DE NODOS AERODINAMICOS X 1]
% Y_s = COORDENADAS DE LOS NODOS ESTRUCTURALES [N° DE NODOS ESTRUCTURALES X 1]

% SALIDA DE DATOS
% R_e = MATRIZ DE RELACIONES DE ELEMENTOS Y NODOS DE LOS NODOS EXTERIORES AL ELEMENTO
% NODOS QUE SE RELACIONAN AL ELEMENTO ESTRUCTURAL DE LA PUNTERA 

N_a=size(Y_a,1);%CANTIDAD DE NODOS AERODINAMICOS 
n_i=(size(Y_s,1)+1)/2-1;%ANTE-ULTIMO NODO ESTRUCTURAL
n_f=(size(Y_s,1)+1)/2;%ULTIMO NODO ESTRUCTURAL 

r_fi=Y_s(n_f,:)-Y_s(n_i,:);
L_e=norm(r_fi);
t=r_fi/L_e;

R_e=0;
p=0;

for i=1:N_a  

    r_ib=Y_a(i,:)-Y_s(n_i,:);
    L_A=dot(r_ib,t)/norm(t);

    if L_A>L_e
        
        p=p+1;
        R_e(p)=i;
        
    end

end



end