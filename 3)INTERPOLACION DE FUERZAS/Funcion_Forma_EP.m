function G_A_S = fun_form_ep(n_s,n_a)

% n_s = COORDENADAS DEL NODO ESTRUCTURAL DE LA PUNTERA [1x3]
% n_a = CORDENADAS DE UN NODO AERODINAMICO [1x3]

r=n_a-n_s;

G_A_S = zeros(3,6);
G_A_S (1:3,1:3)= eye(3);
G_A_S (11)=-r(3);
G_A_S (12)=r(2);
G_A_S (13)=r(3);
G_A_S (15)=-r(1);
G_A_S (16)=-r(2);
G_A_S (17)=r(1);

G_A_S;

end