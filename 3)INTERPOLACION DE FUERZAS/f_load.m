function f_load=f_load(F_S)


f_load=0;
nod=1;
con=0;
ren=1;
for i=1:length(F_S)
    nod;
    con=con+1;
    if F_S(i)~=0
        format shortg
        f_load(ren,1)=nod;
        f_load(ren,2)=con;
        f_load(ren,3)=F_S(i);
        ren=ren+1;
    end
    if con==6
        nod=nod+1;
        con=0;
    end
end


N_C=size(f_load,1);

fid=fopen('f_load.dat','wt');
fprintf(fid,'%d\n',N_C);
dlmwrite('f_load.dat',f_load,'delimiter','\t','-append');
fclose(fid);

end