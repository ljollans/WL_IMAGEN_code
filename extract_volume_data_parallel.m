function [meanvoldata,stdvoldata,sumvoldata,mask_name,volume_name] = extract_volume_data_parallel(masks2use,volfiles,where2save,filename4saving,volthreshupr,volthreshlwr,nanthreshold,hdrinfo2exclude)

%code to extract values from nifti files, Robert Whelan 6th March 2014
%mask and volume files must be in 1 x n cell arrays
%[meanvoldata,stdvoldata,sumvoldata,allextracteddata] = extract_volume_data(mask_bin,files2extractfrom','/Volumes/EEG data/BIG_SIG analysis/IGT EEG data/ind_fits','tstdata',100,-100,3);
starting = tic;

if isempty(gcp('nocreate')) == 1 % checking to see if my pool is already open
    parpool; % Set the default profile to the number of cores to use
end

if isempty(volthreshupr)==1; volthreshupr=1000000; end%if no upper threshold set, then default to a very high number
if isempty(volthreshlwr)==1; volthreshlwr=-1000000; end%if no upper threshold set, then default to a very low number
if isempty(nanthreshold)==1; nanthreshold=0; end%if no upper threshold set, then default to 0 (no nans allowed)
if exist(where2save)==0; mkdir(where2save);end% make a directory if it doesn't exist

%% Image dimension, orientation and voxel size checks (spm_read_vols.m)
ok2proceed=0;
[ok2proceed]=docheck(volfiles,masks2use);
if ok2proceed==0
    flags.prefix='exval_';flags.which=1;flags.mean=0;
    spm_reslice([volfiles{1} masks2use],flags);
    disp('reslicing the masks to fit');
    for q=1:size(masks2use,2)
        [a,b,c]=fileparts(masks2use{q});
        masks2use{q}=[a filesep 'exval_' b c];
    end
    [ok2proceed]=docheck(volfiles,masks2use);
end
%%
if ok2proceed==0
    error('Images don''t all have the same dimensions. Please reslice.')
end

%% Prep the arrays
meanvoldata = NaN(size(masks2use,2),size(volfiles,2));
stdvoldata = NaN(size(masks2use,2),size(volfiles,2));
sumvoldata = NaN(size(masks2use,2),size(volfiles,2));
mask_name = cell(1,size(masks2use,2));
volume_name = cell(size(masks2use,2),size(volfiles,2));
tsdata=NaN(size(masks2use,2),size(volfiles,2));
fileskipped=zeros(size(masks2use,2),size(volfiles,2));
%%

%% do the extraction
disp(['Extracting data from ' int2str(size(masks2use,2)) ' mask(s) and ' int2str(size(volfiles,2)) ' data file(s).']);
for masklpr=1:size(masks2use,2)
%     mask2extractfrom = spm_vol(masks2use{masklpr});
    maskdata=spm_read_vols(spm_vol(masks2use{masklpr}));
    [tmppath,tmpmasknm,tmpext]=fileparts(masks2use{masklpr});
    mask_name{masklpr}=tmpmasknm;%keep a record of the mask name in case needed again
    %     disp(['mask name: ' tmpmasknm ' % masks done: ' num2str(100*(masklpr/size(masks2use,2)))]);
    
    %initialize vars before par-loop
    vol2extractfrom=struct;
    voldata=NaN;
    voldata_in_mask=NaN;
    
    meanvoldata_ua = NaN(1,size(volfiles,2));
    stdvoldata_ua = NaN(1,size(volfiles,2));
    sumvoldata_ua = NaN(1,size(volfiles,2));
    volume_name_ua = cell(1,size(volfiles,2));
    
    parfor vollpr=1:size(volfiles,2)
        try
        vol2extractfrom = spm_vol(volfiles{vollpr});
        voldata = spm_read_vols(vol2extractfrom);
        voldata_in_mask = find(voldata>volthreshlwr & voldata<volthreshupr & maskdata>0);%only extract from within the thresholds and where the mask isn't a NaN or ==0
        if sum(isnan(voldata_in_mask(:)))<nanthreshold && isempty(strfind(vol2extractfrom.descrip,hdrinfo2exclude))==1
            meanvoldata_ua(vollpr) = nanmean(voldata(voldata_in_mask));
            stdvoldata_ua(vollpr) = nanstd(voldata(voldata_in_mask)); %std replaced by nanstd by Emily Jollans 19-08-14
            sumvoldata_ua(vollpr)=nansum(voldata(voldata_in_mask));%sum replaced by nansum by Emily Jollans 19-08-14
            volume_name_ua{vollpr}={volfiles{vollpr}};%keep a record of the volume name in case needed again
        end
        catch
            fileskipped(masklpr,vollpr)=1;
        end
    end
    
    %index the arrays after the parfor loop
            meanvoldata(masklpr,:) = meanvoldata_ua;
            stdvoldata(masklpr,:) = stdvoldata_ua;
            sumvoldata(masklpr,:) = sumvoldata_ua;
            volume_name(masklpr,:) = volume_name_ua;
            
    disp(['mask name: ' tmpmasknm ' % masks done: ' num2str(100*(masklpr/size(masks2use,2)))]);
%     save([where2save filesep 'TMP' filename4saving],'meanvoldata','stdvoldata','sumvoldata','mask_name','volume_name');%in case something fails on subsequent masks
end
%%

%% save the data
save([where2save filesep filename4saving],'meanvoldata','stdvoldata','sumvoldata','mask_name','volume_name');

time2process=toc(starting);

disp(['Finished in ' num2str(time2process) ' seconds']);
end

function [ok2proceed]=docheck(volfiles,masks2use);
ok2proceed=1;
checkvol=spm_vol(volfiles{1});%**ASSUME** all vols have the same dimension, so only need to check the 1st one
checkmask=spm_vol(masks2use{1});%**ASSUME** all masks have the same dimension, so only need to check the 1st one
Vol_both = [checkvol; checkmask];

if length(Vol_both)>1 & any(any(diff(cat(1,Vol_both.dim),1,1),1))
    ok2proceed=0;
end
if any(any(any(diff(cat(3,Vol_both.mat),1,3),3)))
    ok2proceed=0;
end
end

function [matchedvars]=domatching(origdata,file2match2)

% for n=1:size(volume_name,2)
%    subID(n)=str2num(files2extractfrom(n).name(1:12));
% end
% [a b c]=intersect(subID,intcodepad);
% clear extracted_val;
% for n=1:size(mask_name)
%     extracted_val(n).name=mask_name{n};
%     extracted_val(n).meandata=(zeros(1,size(intcodepad,1))-100)';
%     extracted_val(n).meandata(c)=meanvoldata(n,b)';
% end

end