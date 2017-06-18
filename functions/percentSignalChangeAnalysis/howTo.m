% 3. How do those timecourse programs work?
% 
% The simplest way to find percent signal change is perfectly good for some types of experiments. The basic steps are as follows:
% 
%     Extract a timecourse for the whole experiment for your given voxel (or extract the average timecourse for a region).
%     Choose a baseline (more on that below) that you'll be measuring percent signal change from. Popular choices are "the mean of the whole timecourse" or "the mean of the baseline condition."
%     Divide every timepoint's intensity value by the baseline, multiply by 100, and subtract 100, to give you a whole-experiment timecourse in percent signal change.
%     For each condition C, start at the onset of each C trial. Average the percent signal change values for all the onsets of C trials together.
%     Do the same thing for the timepoint after the onset of each C trial, e.g., average together the onset + 1 timepoint for all C trials.
%     Repeat for each timepoint out from the onset of the trial, out to around 30 seconds or however long an HRF you want to look at.
% 
% You'll end up with an average peristimulus timecourse for each condition, and even a timecourse of standard deviations/confidence intervals if you like - enough to put confidence bars on your average timecourse estimate. This is the basic method, and it's perfect for long event-related experiments - where the inter-trial interval is at least as long as the HRF you want to estimate, so every experimental timepoint is included in one and only one average timecourse.

training
place
face

testing
fb -facetarget  
fb -placetarget
nfb - facetarget
nfb -placetarget
