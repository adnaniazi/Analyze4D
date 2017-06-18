function install()
% install the toolbox and all its dependicies except brainvoyager
%% Install Analyze4D
path = mfilename('fullpath');
path = path(1:end-numel('install')-1);
disp('Installing Analyze 4D...................');
rmpath(path);
savepath;

%% Install PassiveFTP for updating the toolbox from time to time

% 2. Find the path to the MATLAB FTP class.
defaultPath = which ('ftp.m');
source = defaultPath(1:end - numel('ftp.m')-1);
destination = fullfile(path,'@ftp'); 

% remove contents of myftp directory before distribution
% 2.1. Delete all the contents of the destination driectory
try
    rmdir(destination,'s')
    mkdir(path, '@ftp');

catch
        mkdir(path, '@ftp');

end

% 3. Copy the entire @ftp directory to a location
copyfile(source,destination, 'f');

warning off;
delete(fullfile(path,'@ftp','private','connect.m'));
delete(fullfile(path,'@ftp','active.m'));
delete(fullfile(path,'@ftp','dataMode.m'));
delete(fullfile(path,'@ftp','ftp.m'));
delete(fullfile(path,'@ftp','pasv.m'));
warning on;


% 5. Copy the provided connect.m file to the new '@ftp/private' folder
copyfile(fullfile(path,'functions','FEX','PassiveFTP','connect.m'),...
   fullfile(path,'@ftp','private','connect.m'),'f');
% 6. Copy the remaining files to the new @ftp folder.  
copyfile(fullfile(path,'functions','FEX','PassiveFTP','active.m'),...
   fullfile(path,'@ftp','active.m'),'f');
copyfile(fullfile(path,'functions','FEX','PassiveFTP','dataMode.m'),...
   fullfile(path,'@ftp','dataMode.m'),'f');
copyfile(fullfile(path,'functions','FEX','PassiveFTP','ftp.m'),...
   fullfile(path,'@ftp','ftp.m'),'f');
copyfile(fullfile(path,'functions','FEX','PassiveFTP','pasv.m'),...
   fullfile(path,'@ftp','pasv.m'),'f');

% 4. Add this new folder to the top of MATLAB path:
addpath(path);
addpath(genpath(fullfile(path,'assets')));
addpath(genpath(fullfile(path,'functions')));
addpath(genpath(fullfile(path,'Help Resources')));
addpath(genpath(fullfile(path,'toolboxes')));
addpath(genpath(fullfile(path,'preferences')));

% 7. Remove the PassiveFTP folder from the path
rmpath(fullfile(path,'functions','FEX','PassiveFTP'));
savepath;
disp('Be patient..............................');
disp('........................................');
disp('========================================');

rehash toolboxcache;
% msgbox([{'Please increase the size of Java Heap to 600MB, otherwise Analyze4D will freeze frequently.'};{'To change the size of the java heap, go to '};{'File --> Preferences... --> General --> Java Heap Memory'};{'and set the slider to around 600MB. Restart MATLAB for the new setting to take effect.'}],'Analyze4D | Increase Java Heap size for best performance', 'warn');
try
    com.mathworks.services.Prefs.setIntegerPref('JavaMemHeapMax', 700); % increase Jave heap memory size
catch
    com.mathworks.services.Prefs.setIntegerPref('JavaMemHeapMax', 200); % increase Jave heap memory size
end
savepath;

disp('Installation complete.');
disp('Analyze4D is now ready for use.');
disp('========================================');
disp('');
disp('To start using it type ''analyze4d'' below ');
disp('without the quotes below and press enter');
% % Construct a questdlg with three options
% choice = questdlg(['You have successfully installed Analyze4D. '...
%     'You can start it either by pressing ''Start Analyzing4D'' button below '...
%     'or by typing analyze4d at the command window of Matlab'], ...
% 	'Installation Complete', ...
% 	'Start Analyze4D','No, not now','Start Analyze4D');
% 
% % Handle response
% switch choice
%     case 'Start Analyze4D'
%         disp([choice ' coming right up.'])
%         analyze4d;
%     case 'No, not now',
%         %do nothing
% end