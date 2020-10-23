function Na_nr=verificador(rel_int,n_a)
%Entrada de Datos
%rel_int=arreglo con las relaciones de los nodos y los elementos
%n_a=cantidad de nodos aerodinámicos

N_a=n_a ;%cantidad de nodos aerodinámicos
Correc=rel_int;  %arreglo con las conectividades
Na_nr=0;
t=0;
for i=1:N_a;
    B=Correc(:,2:size(Correc,2));
    A=find(B==i);
    if length(A)==0;
        t=t+1;
        Na_nr(t)=i;
    end
           
    
end

    