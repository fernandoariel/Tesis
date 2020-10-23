function Fuer_A = fuer_aer( n , A_e , dC_p , V_inf , rho )

% DATOS DE ENTRADA
% n = VERSORES DEL VECTOR NORMAL A LA SUPERFICIE [N° DE ELEMENTOS AERODINAMICOS X 3]
% A_e = AREA DE LOS ELEMENTOS AERODINAMICOS EN M2 [N° DE ELEMENTOS AERODINAMICOS X 1]
% dC_p = DIFERENCIA DE COEFICIENTE DE PRESION EN EL ELEMENTO [N° DE ELEMENTOS AERODINAMICOS X 1]
% V_inf = VELOCIDAD DE LA CORRIENTE LIBRE EN M/S [1x1]
% rho = DENSIDAD DE LA CORRIENTE LIBRE EN KG/M3 [1x1]

dP = 0.5*dC_p*rho*V_inf*V_inf;
Fuer_A_x = dP.*A_e.*n(:,1);
Fuer_A_y = dP.*A_e.*n(:,2);
Fuer_A_z = dP.*A_e.*n(:,3);

Fuer_A = zeros(3*size(n(:,1),1),1);

for i=1:size(n(:,1))%CICLO QUE VA DESDE 1 HASTA LA CANTIDAD DE ELEMENTOS AERODINAMICOS

   Fuer_A(3*i-2:3*i) = [ Fuer_A_x(i) ; Fuer_A_y(i) ; Fuer_A_z(i)];
    
end

end