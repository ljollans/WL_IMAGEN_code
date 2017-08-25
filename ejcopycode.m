%copyfile code
% /Volumes/Data store 2/PPI data/DN paper 362subs PPI re-analysis/000000022453/Lvs_big-no
%con1
% 
clear paths names
[paths names] = filesearch_substring('F:\Imagen_ts_1stlev\spmstatsintra\','con_0019.nii',0);

for n=1:size(paths,2)
    if isempty(strfind(names{n},'.gz'))==1
%         if isempty(strfind(paths{n},'Lvs'))==0%just take the SST con1 files
            if isempty(strfind(paths{n},'global'))==0%just take the SST con1 files
            strstart=strfind(paths{n},'0');%find the start of the sub id
            subid{n}=paths{n}(strstart(1):strstart(1)+11);%get the whole sub id
%             copyfile([paths{n} '\con_0008.nii'],'F:\IMAGEN\ImagenDataPerCon\tmploc');%first copy the file to a temp loc
           copyfile([paths{n} filesep names{n}],'E:\extracted_imagen_data_shen\tmploc', 'f');%first copy the file to a temp loc
%            movefile('F:\IMAGEN\ImagenDataPerCon\tmploc\con_0008.nii',['F:\IMAGEN\ImagenDataPerCon\Faces_con08\' subid{n} '_con_0008.nii'])%;%now rename the file
            movefile(['E:\extracted_imagen_data_shen\tmploc\' names{n}],['E:\extracted_imagen_data_shen\GCA19\' subid{n} '_con1.nii'], 'f');%;%now rename the file
        clear strstart;
%         elseif isempty(strfind(paths{n},'Rvs'))==0%just take the SST con1 files
% %             if isempty(strfind(names{n},'s'))==1%just take the SST con1 files
%             strstart=strfind(paths{n},'0');%find the start of the sub id
%             subid{n}=paths{n}(strstart(1):strstart(1)+11);%get the whole sub id
% %             copyfile([paths{n} '\con_0008.nii'],'F:\IMAGEN\ImagenDataPerCon\tmploc');%first copy the file to a temp loc
%            copyfile([paths{n} filesep names{n}],'/Users/rob-mac/Google Drive/all ongoing projects/Imagen/DN Special Issue/PPI/tmploc');%first copy the file to a temp loc
% %            movefile('F:\IMAGEN\ImagenDataPerCon\tmploc\con_0008.nii',['F:\IMAGEN\ImagenDataPerCon\Faces_con08\' subid{n} '_con_0008.nii'])%;%now rename the file
%             movefile(['/Users/rob-mac/Google Drive/all ongoing projects/Imagen/DN Special Issue/PPI/tmploc/' names{n}],['/Users/rob-mac/Google Drive/all ongoing projects/Imagen/DN Special Issue/PPI/newdata_0102/Right/' subid{n} '_con1.nii'])%;%now rename the file
%         clear strstart;
%             end
        end
    end
end
