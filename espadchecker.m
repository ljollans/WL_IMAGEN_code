for n=0:6
    fbl{n+1}=find(ESPAD.BL.espad6==n); 
end;
for n=0:6
    ffu{n+1}=find(ESPAD.FU.espad6==n); 
end;
for n=1:7
    for m=1:7 
        c=intersect(fbl{n}, ffu{m}); 
        if isempty(c)==0 
            f{n,m}=intersect(fbl{n}, ffu{m}); 
        else
            f{n,m}=NaN; 
        end; 
        fcount(n,m)=length(f{n,m});
    end; 
end