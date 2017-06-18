% % make a matrix for sanity check
% x = 64;
% y = 64;
% z = 28;
% 
% data = single(zeros(x*y*z,1616));
% 
% 
% data(1,1:808) = 7;

% amke a sum a functional and classifier weights image ans see them in a4d
% and mricro
clc
clear all
c= load_untouch_nii('D:\project\Faces_place_experiment_analysis\Data\subject5_peter\sanitycheckforA4D\nonBinaryClassifierWeigthsNifti.nii');
d= load_untouch_nii('D:\project\Faces_place_experiment_analysis\Data\subject5_peter\sanitycheckforA4D\fmri_scan_00001.nii');


a= c.img;
b= d.img;


idx= find(isnan(a));

a(idx) = 0;

a = abs(a);
clear data;
data= -a*1000 + b/250;
c.img= data;
save_untouch_nii(c,'D:\project\Faces_place_experiment_analysis\Data\subject6_adnan\sanitycheckforA4D\combined.nii' )