function analyzeToNifti3d
filePaths = uipickfiles('Type' , {'*.img', 'Analyze (img + hdr)'}, 'Prompt',...
    'Select Analyze format file to convert to Nifti 3D' );
[pathstr, name, ext] = fileparts(filePaths{1,i}); 
for i = 1 : numel(filePaths)
   nii = load_untouch_nii( filePaths{1,1})
    
end
