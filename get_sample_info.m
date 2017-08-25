% check to identify smokers/nonsmokers based on ESPAD scores
% will make this more generic at some point

% contact: lee.jollans@gmail.com

clear
load('/media/lee/Windows7_OS/Users/EJ/Google Drive/Ongoing/IMAGEN/anaysis/All_IMAGEN_code/EJsmokingdata/BRAIN300516/design.mat')
disp(['N=' num2str(length(design.outcome))])
disp([num2str(length(find(design.outcome==0))) ' continuous nonsmokers'])
disp([num2str(length(find(design.outcome==1))) ' smoking transitioners'])
load('/media/lee/Windows7_OS/Users/EJ/Google Drive/Ongoing/IMAGEN/anaysis/All_IMAGEN_code/EJsmokingdata/psychometric_data/espad.mat')

f1=find(design.outcome==0);
f2=find(design.outcome==1);
S_nosmok=design.subid(f1);
S_smok=design.subid(f2);
[c a b]=intersect(ESPAD.ALL.ID, S_smok);
smokespad6BL=ESPAD.ALL.espad6.bl(a); 
disp(['Smoking transitioners baseline espad 6: average=' num2str(mean(smokespad6BL)) '; median=' num2str(median(smokespad6BL)) '; min=' num2str(min(smokespad6BL)) '; max=' num2str(max(smokespad6BL))])
smokespad7BL=ESPAD.ALL.espad7.bl(a);
disp(['Smoking transitioners baseline espad 7: average=' num2str(mean(smokespad7BL)) '; median=' num2str(median(smokespad7BL)) '; min=' num2str(min(smokespad7BL)) '; max=' num2str(max(smokespad7BL))])
smokespad6FU=ESPAD.ALL.espad6.fu(a);
disp(['Smoking transitioners follow-up espad 6: average=' num2str(mean(smokespad6FU)) '; median=' num2str(median(smokespad6FU)) '; min=' num2str(min(smokespad6FU)) '; max=' num2str(max(smokespad6FU))])
smokespad7FU=ESPAD.ALL.espad7.fu(a);
disp(['Smoking transitioners follow-up espad 7: average=' num2str(mean(smokespad7FU)) '; median=' num2str(median(smokespad7FU)) '; min=' num2str(min(smokespad7FU)) '; max=' num2str(max(smokespad7FU))])
[c a b]=intersect(ESPAD.ALL.ID, S_nosmok);
nosmokespad6BL=ESPAD.ALL.espad6.bl(a);
disp(['Continuous nonsmoker baseline espad 6: average=' num2str(mean(nosmokespad6BL)) '; median=' num2str(median(nosmokespad6BL)) '; min=' num2str(min(nosmokespad6BL)) '; max=' num2str(max(nosmokespad6BL))])
nosmokespad7BL=ESPAD.ALL.espad7.bl(a);
disp(['Continuous nonsmoker baseline espad 7: average=' num2str(mean(nosmokespad7BL)) '; median=' num2str(median(nosmokespad7BL)) '; min=' num2str(min(nosmokespad7BL)) '; max=' num2str(max(nosmokespad7BL))])
nosmokespad6FU=ESPAD.ALL.espad6.fu(a);
disp(['Continuous nonsmoker follow-up espad 6: average=' num2str(mean(nosmokespad6FU)) '; median=' num2str(median(nosmokespad6FU)) '; min=' num2str(min(nosmokespad6FU)) '; max=' num2str(max(nosmokespad6FU))])
nosmokespad7FU=ESPAD.ALL.espad7.fu(a);
disp(['Continuous nonsmoker follow-up espad 7: average=' num2str(mean(nosmokespad7FU)) '; median=' num2str(median(nosmokespad7FU)) '; min=' num2str(min(nosmokespad7FU)) '; max=' num2str(max(nosmokespad7FU))])
