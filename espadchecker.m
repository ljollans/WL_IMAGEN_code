% quick check of how many subs have a specific score on each of two
% variables
% input:
% var1/var2: two variables with a score for each subject (enter in row 10/11)
% output:
% u1/u2: all the possible scores in var1 and var2
% fcont: number of subs that scored the values in u1 and u2 
% f: corresponding subject ID locations

% contact: lee.jollans@gmail.com

var1=ESPAD.BL.espad6;
var2=ESPAD.FU.espad6;

u1=unique(var1);
u2=unique(var2);
for n=1:length(u1)
    fbl{n}=find(var1==u1(n)); 
end;
for n=1:length(u2)
    ffu{n}=find(var2==u2(n)); 
end;
for n=1:length(u1)
    for m=1:length(u2) 
        c=intersect(fbl{n}, ffu{m}); 
        if isempty(c)==0 
            f{n,m}=intersect(fbl{n}, ffu{m}); 
        else
            f{n,m}=NaN; 
        end; 
        fcount(n,m)=length(f{n,m});
    end; 
end