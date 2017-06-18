function downloadUpdate(versionName)
% versionName = analyze4D_vx.x.rar 
% open passive ftp

myFTP           = ftp('ftp.analyze4d.com', 'software@analyze4d.com', 'shearluckanalyze4d');
pasv(myFTP);
dataMode(myFTP);  % this command simply shows the current mode
%get current folder
fileName        = strcat('analyze4d_v',versionName,'.rar');
[file,path]     = uiputfile(fileName,'Save file......');

downloadPath    = path; %fullfile(folderPath,'downloads');
oldFolder       = cd(downloadPath);

dlg = ProgressDialog( ...
    'StatusMessage', 'Downloading update....', ...
    'Indeterminate', true);
a               = mget(myFTP, fileName);

if ~strcmp(file,fileName)
movefile(fullfile(path,fileName),fullfile(path,file),'f');%RENAME
end

% a = mget(myFTP, versionName);
cd (oldFolder);
close(myFTP);

msgbox([{'Download Complete.'};...
    {'Please go to the download folder, extract the files, and run'}; ...
    {'install.m'};{'file to install Analyze4D'}], 'Download Successful');
delete(dlg);