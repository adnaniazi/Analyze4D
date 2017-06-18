%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Analyze4D is free but copyrighted software, distributed  under the
% terms of the GNU General Public Licence as published by the Free
% Software Foundation (either version 2, or at your option any later
% version). See the file COPYING.txt in the main Analyze4D folder for
% more details.                                                           %
%                                                                         %
% Copyright (C) 2012, Adnan Niazi                                         %
% Donders Institute for Brain, Cognition and Behaviour                    %
% Radboud University Nijmegen, The Netherlands                            %
% Contact: adnan AT analyze4d.com or adnaniazi AT gmail.com               %
% Replace AT by @                                                         %


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function analyze4d()

% path for update structure
path = mfilename('fullpath');
path = path(1:end-numel('\functions\workHorse\analyze4d'));
path = fullfile(path,'a4D_var', 'versionInfo.mat');
load(path);

% calls Donders fMRI toolbox which was the previous name for the software
% Check to see if an instance of GUI is already running -----------------
set(0,'showhiddenhandles','on');
p = findobj('tag','figure1','parent',0);
set(0,'showhiddenhandles','off');
if ~any(ishandle(p))
    s = Analyze4D('Analyze4D', 'splashBlack.png', ...
        'ProgressBar', 'on', ...
        'ProgressPosition', 5, ...
        'ProgressRatio', 0.1 );
    s.addText( 5, 150, 'Checking for Image Processing Toolbox', 'FontSize', 12, 'Color', [1 1 1] );
    try
        internetStatus = isThereInternet();    
    catch
        internetStatus = 0;
    end
    pause(0.1);
    installed = areTheseToolboxesInstalled('Image Processing Toolbox');
    
    if installed
        s = Analyze4D('Analyze4D', 'splashBlack.png', ...
            'ProgressBar', 'on', ...
            'ProgressPosition', 5, ...
            'ProgressRatio', 0.5 );
        s.addText( 5, 150, 'Found Image Processing Toolbox', 'FontSize', 12, 'Color', [1 1 1] );
        pause(0.1);
    else
        s = Analyze4D('Analyze4D', 'splashBlack.png', ...
            'ProgressBar', 'on', ...
            'ProgressPosition', 5, ...
            'ProgressRatio', 0.7 );
        s.addText( 5, 150, 'Image Processing Toolbox not found... Full functionality of Analyze 4d will not be available', 'FontSize', 12, 'Color', [1 1 1] );
        disp('Image Processing Toolbox not found.')
        disp('Please install Image procsessing toolbox, otherwise  ');
        disp('Analyze4D will have very limited functionality');
        msgbox('Image Processing Toolbox not found.Please install Image procsessing toolbox, otherwise Analyze4D will have very limited functionality','Image Processing Toolbox Not found','error');
        pause(0.1);
    end
    s = Analyze4D('Analyze4D', 'splashBlack.png', ...
        'ProgressBar', 'on', ...
        'ProgressPosition', 5, ...
        'ProgressRatio', 0.85 );
    s.addText( 5, 150, 'Starting Analyze4D', 'FontSize', 12, 'Color', [1 1 1] );
    pause(0.1);
    %         delete(s);
    
else
    msgbox([{'Analyze4D is already running. You can''t run multiple instances of Analyze4D. To run multiple instances of Analyze4D, run multiple Matlab sessions'};...
        {'If you are receiving this message and Analyze4D is not already running, then try typing ''close all hidden'' in matlab command window. Then type ''analyzed4d''.'};...
        {'If that does not work then try typing ''dfmri'' in the matlab command window.'}],'Warning!! Can not run multiple instances','warn','modal');
    return;
end

% call the workhorse
h = dfmri;


% Check the internet for updates
if versionInfo.checkForUpdates == 1 && internetStatus
    %     s = Analyze4D('Analyze4D', 'splashBlack.png', ...
    %         'ProgressBar', 'on', ...
    %         'ProgressPosition', 5, ...
    %         'ProgressRatio', 0.95);
    %     s.addText( 5, 150, 'Checking internet for updates...', 'FontSize', 12, 'Color', [1 1 1] );
    
    versionInfo.currentVersion                  = '1.0';
    versionInfo.currentVersionReleaseDate       = '01-Apr-2012';
    %check the web for new versions
    [versionInfo.internetVersion, versionInfo.internetVersionReleaseDate] = ...
        checkForUpdates();
    versionInfo.path = path;
    
    save(path,'versionInfo'); %save the versionInfo Variable
    if strcmp(versionInfo.currentVersion, versionInfo.internetVersion) && ...
            strcmp(versionInfo.currentVersionReleaseDate, versionInfo.internetVersionReleaseDate)
        s.addText( 5, 150, 'Analyze4D is upto date...', 'FontSize', 12, 'Color', [1 1 1] );
    else
        %       NumDays = daysact(versionInfo.currentVersionReleaseDate,
        %       versionInfo.internetVersionReleaseDate); % only works in @R2012
        %         NumDays = datenum(versionInfo.internetVersionReleaseDate)- datenum(versionInfo.currentVersionReleaseDate); % only tracks how old the version with repsect ot pervious version
        NumDays =  datenum(date)- datenum(versionInfo.currentVersionReleaseDate);
        
        versionInfo.numDaysOld =  NumDays;
        updateAvailable(versionInfo);
    end
end
delete(s);
%
% % Make the versionInfoStructure if lost
% versionInfo.currentVersion                  = 'v1.0';
% versionInfo.currentVersionReleaseDate       = '20-Apr-2012';
% versionInfo.checkForUpdates                 = 1;