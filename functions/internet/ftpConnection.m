% 7. You can now enter 'passive mode' FTP as follows:
%     myFTP = ftp('ftp.mathworks.com')
%     pasv(myFTP)
%     dataMode(myFTP)  % this command simply shows the current mode
% 
%     you can return to normal/active mode by issuing the command
%     active(myFTP)


myFTP = ftp('ftp.analyze4d.com', 'software@analyze4d.com', 'shearluckanalyze4d');
pasv(myFTP);
dataMode(myFTP);  % this command simply shows the current mode

%get current folder
p = mfilename('fullpath');
folderPath = p(1:end-numel('ftpConnection'));
downloadPath = fullfile(folderPath,'downloads');
oldFolder = cd(downloadPath);
a = mget(myFTP, 'analyze4d-version-information.txt');
fid = fopen('analyze4d-version-information.txt');
line1 = fgetl(fid);
line2 = fgetl(fid);

internetVersion = line1(numel('currentVersion:')+1 :end);
internetVersionReleaseDate = line2(numel('releaseDate:')+1 :end);
fclose(fid);
cd (oldFolder);