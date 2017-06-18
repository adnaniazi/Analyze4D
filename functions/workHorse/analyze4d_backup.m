function analyze4d()
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
    pause(0.5);
    installed = areTheseToolboxesInstalled('Image Processing Toolbox');
    
    if installed
        s = Analyze4D('Analyze4D', 'splashBlack.png', ...
            'ProgressBar', 'on', ...
            'ProgressPosition', 5, ...
            'ProgressRatio', 0.5 );
        s.addText( 5, 150, 'Found Image Processing Toolbox', 'FontSize', 12, 'Color', [1 1 1] );
        pause(0.5);
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
        pause(0.5);
    end
            s = Analyze4D('Analyze4D', 'splashBlack.png', ...
            'ProgressBar', 'on', ...
            'ProgressPosition', 5, ...
            'ProgressRatio', 0.95 );
        s.addText( 5, 150, 'Starting Analyze4D', 'FontSize', 12, 'Color', [1 1 1] );
        pause(1);
        
    delete(s);
   
else
    msgbox('Analyze4D is already running. You can''t run multiple instances of Analyze4D. To run multiple instances of Analyze4D, run multiple Matlab sessions','Warning!! Can not run multiple instances','warn','modal');
    return;
end

% call the workhorse
dfmri;