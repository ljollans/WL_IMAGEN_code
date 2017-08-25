clear all
load('/media/lee/Windows7_OS/Users/EJ/Google Drive/Ongoing/IMAGEN/smoking_data_040717.mat')
data2impute=covars(:,2:7);
all_sex=covars(:,1)';
for n=1:548,
    try;
        all_site(n)=find(covars(n,8:14)==1);
    catch; 
        all_site(n)=8;
    end;
end
% 
% load('/media/lee/Transcend/Data/IMAGEN/alldata030617.mat')
% data2impute=alldata;
% load('/media/lee/Windows7_OS/Users/EJ/Google Drive/Ongoing/IMAGEN/anaysis/All_IMAGEN_code/sexsite.mat')
% sex=all_sex; site=all_site;

% task_type={'MID', 'SST', 'Faces'};
% task_type={'GM'};
% data2impute= {'meanvoldata', 'stdvoldata', 'sumvoldata'};

% for task=1:(size(task_type,2))
%     for con=1:(size(eval([task_type{task}]),2))
%         eval(['conname=' [task_type{task} '(' num2str(con) ').cons;']]);
data2impute(find(data2impute==-100))=NaN;
for site=1:8
    for sex=0:1
        %                 for mask=1:6
        for data=1:(size(data2impute,2))
            clear invarname structvarname
            %                         invarname=[task_type{task} '.' data2impute{data} '(' num2str(mask) ',all_site==' num2str(site) ' & all_sex==' num2str(sex) ')'];
            %                         structvarname=['trim_' task_type{task} '.site' num2str(site) '.sex' num2str(sex) '.' data2impute{data} '(' num2str(mask) ')'];
            invarname=['data2impute(all_site==' num2str(site) ' & all_sex==' num2str(sex) ',data)'];
            structvarname=['trim_mean.site' num2str(site) '.sex' num2str(sex) '(data)'];
            %                         invarname=[task_type{task} '(' num2str(con) ').' data2impute{data} '(' num2str(mask) ',all_site==' num2str(site) ' & all_sex==' num2str(sex) ')'];
            %                         structvarname=['trim_' task_type{task} '(' num2str(con) ').site' num2str(site) '.sex' num2str(sex) '.' data2impute{data} '(' num2str(mask) ')'];
            eval([sprintf(structvarname) '=trimmean(' sprintf(invarname) ',5);'])
        end
    end
end
%         end
%     end
% end
% clear mask sex site data con task invarname structvarname conname data2impute task_type
