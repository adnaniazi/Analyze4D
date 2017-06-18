function coregisterAALMaskToFunctionalData(pathToAALToolbox)
waitfor(msgbox(['To use the AAL mask, it needs to be coregistered to '...
    'your functional scans. I can do this for you. But make sure you have '...
    'SPM8 added to your Matlab Path. Furthermore, to coregister, I need to know '...
    'the Reference functional scans with respect to which I will '...
    'coregister and reslice the AAL mask. For functional data which has '...
    'already been motion corrected, I would recommend to select the mean image '...
    'as the '...
    'Reference function scan, otherwise just choose any functional scan '...
    'in your data as the Referece functional scan. Press OK to proceed.'], 'Specify reference scan for coregisteration', 'warn'));
filePaths = uipickfiles('Type' , {'*.nii', 'NIFTI (NII)' ;
    '*.img', 'Analyze (IMG/HDR)'; '*.ima', 'DICOM (IMA)';
    '*.dcm', 'DICOM (DCM)'; '*.dic', 'DICOM (DIC)'}, 'Prompt',...
    'Please select the Reference functional scan', 'NumFiles', 1); 
pause(0.5);

filePaths = filePaths';
dlg = ProgressDialog( ...
    'StatusMessage', 'Coregistering AAL Mask to the functional data....', ...
    'Indeterminate', true);


spm('defaults', 'FMRI');
spm_jobman('initcfg');
meanImg = filePaths;

greyImg = {fullfile(pathToAALToolbox,'ROI_MNI_V4.nii')};
seg = [meanImg; greyImg];
matlabbatch{1}.spm.spatial.realign.estwrite.data = {seg};
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.quality = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.sep = 4;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.fwhm = 5;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.rtm = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.interp = 2;
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.eoptions.weight = '';
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.which = [2 1];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.interp = 0;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.wrap = [0 0 0];
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.mask = 1;
matlabbatch{1}.spm.spatial.realign.estwrite.roptions.prefix = 'r';

spm_jobman('run',matlabbatch);
% clean up the file produced during this process
% [pathstr, name, ext] = fileparts(filePaths{1,1});
% delete(fullfile(pathstr,strcat('r',name,ext)));
% delete(fullfile(pathstr,strcat('mean',name,ext)));
% delete(fullfile(pathstr,strcat('rp_',name,'.txt')));

delete(dlg);
