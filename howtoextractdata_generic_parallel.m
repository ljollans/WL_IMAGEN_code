function howtoextractdata_generic_parallel(extractstuff,datadir,savedir,runinparallel)

%example usage:

if isempty(runinparallel)==1
    runinparallel=0;
end

clear meanvoldata stdvoldata sumvoldata mask_name volume_name masks2use all_masks all_subs paths names

for k=1%%1:size(extractstuff,2);
    con2extract=extractstuff(k).cons;
  
    maskdir=extractstuff(k).maskpath;
    
    % %%set up the masks
    masks2usehdr=dir([maskdir '/*.hdr']);
    masks2usenii=dir([maskdir '/*.nii']);
    for m=1:size(masks2usehdr,1)
        all_masks(m)={[maskdir filesep masks2usehdr(m).name]};
    end
    for m=1:size(masks2usenii,1)
            all_masks(size(masks2usehdr,1)+m)={[maskdir filesep masks2usenii(m).name]}; 
    end
    
    for i=1:size(con2extract,2);   
        all_subs_filenames=dir([datadir filesep extractstuff(k).tasktypes '_con' con2extract{i} filesep '*.nii']);
        
        for n=1:size(all_subs_filenames,1)
            all_subs(n)={[datadir filesep extractstuff(k).tasktypes '_con' con2extract{i} filesep all_subs_filenames(n).name]};
        end  
        
        if runinparallel==0
        [meanvoldata,stdvoldata,sumvoldata,mask_name,volume_name] = extract_volume_data(all_masks,all_subs,datadir,[extractstuff(k).tasktypes '_con' con2extract{i}],[],[],5,'replace');
        else
            [meanvoldata,stdvoldata,sumvoldata,mask_name,volume_name] = extract_volume_data_parallel(all_masks,all_subs,datadir,[extractstuff(k).tasktypes '_con' con2extract{i}],[],[],5,'replace');
        end
        
        a=['meanvoldata' extractstuff(k).tasktypes con2extract{i}]; eval([sprintf(a) '=meanvoldata;']);
        b=['sumvoldata' extractstuff(k).tasktypes con2extract{i}]; eval([sprintf(b) '=sumvoldata;']);
        c=['stdvoldata' extractstuff(k).tasktypes con2extract{i}]; eval([sprintf(c) '=stdvoldata;']);
        d=['maskname' extractstuff(k).tasktypes con2extract{i}]; eval([sprintf(d) '=mask_name;']);
        e=['volname' extractstuff(k).tasktypes con2extract{i}]; eval([sprintf(e) '=volume_name;']);
        
        %save([datadir filesep extractstuff(k).tasktypes '_con' con2extract{i}],sprintf(a), sprintf(b), sprintf(c),sprintf(d),sprintf(e));%do a partial save
        clear a b c d e all_subs all_subs_filenames i mask_name meanvoldata n stdvoldata sumvoldata volume_name    
    end
    
    clear all_masks all_subs all_subs_filenames con2extract con_counter i mask_name masks2use meanvoldata n stdvoldata sumvoldata volume_name
    save([savedir filesep extractstuff(k).tasktypes])   
end