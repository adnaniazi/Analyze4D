function [file] = pickDirUsingJFileChooser
%PICKDIRUSINGJFILECHOOSER Pick a dir with Java widgets instead of uigetdir

import javax.swing.JFileChooser;
jchooser = javaObjectEDT('javax.swing.JFileChooser');
jchooser.setFileSelectionMode(JFileChooser.DIRECTORIES_ONLY);
jchooser.setDialogTitle('Please select the destination folder');
jchooser.setApproveButtonText('OK');
jchooser.setApproveButtonToolTipText('Press to confirm folder selection')
status = jchooser.showOpenDialog([]);

if status == JFileChooser.APPROVE_OPTION
    jFile = jchooser.getSelectedFile();
    file = char(jFile.getPath());
elseif status == JFileChooser.CANCEL_OPTION
    file = [];
else
    error('Error occurred while picking file');
end
