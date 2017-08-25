%  clear all
%  load('C:\Users\EJ\Google Drive\Ongoing\IMAGEN\2462_278vars_all.mat')
% data2impute=DATA;
% load('C:\Users\EJ\Google Drive\Ongoing\IMAGEN\anaysis\All_IMAGEN_code\sexsite.mat')
% load('C:\Users\EJ\Google Drive\Ongoing\IMAGEN\anaysis\All_IMAGEN_code\imputation\trimmeans278vars_41116.mat')
data2impute(find(data2impute==-100))=NaN;
for n=1:size(data2impute,2);
        f=find(isnan(data2impute(:,n))==1);
        for m=1:length(f)
            if isnan(all_site(f(m)))==0 & isnan(all_sex(f(m)))==0
            data2impute(f(m),n)=eval(['trim_mean.site' num2str(all_site(f(m))) '.sex' num2str(all_sex(f(m))) '(' num2str(n) ')']);
            end
        end
end
[r c]=find(isnan(data2impute)==1);
c=unique(c);
r=unique(r);
data2use=data2impute; data2use(r,:)=[]; subid(r)=[];
[r c]=find(isnan(data2use)==1);
c=unique(c);
r=unique(r);
% save('278varsimputed_41116', 'data2use', 'LABELS', 'subid')