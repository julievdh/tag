% load tag deployment
clear all 

tag = 'tt14_126a';
path = 'E:\tt14\tt14_126a\';

settagpath('audio',path(1:3));
settagpath('cal',[path 'cal\'],'prh',[path 'prh\'],'raw',[path 'raw\'],...
    'audit',[path 'audit\'])
recdir = d3makefname(tag,'RECDIR');

% load prh
loadprh(tag)

% load calibration and deployment info, tag audit
[CAL,DEPLOY] = d3loadcal(tag);
R = loadaudit(tag);

% find breath cues only
[cues,R] = findbreathcues(R);
% find release time
releasecue = etime(DEPLOY.TAGON.RELEASE, DEPLOY.TAGON.TIME);
% plot to check 
t = (1:length(p))/fs;
figure(1), clf, plot(t,-p), hold on, plot([releasecue releasecue],[-1 1],'k','LineWidth',2)


% calculate minute respiratory rate before release
rest_ct = resprate(R,[0 releasecue]); 
% calculate minute repiratory rate after release
swim_ct = resprate(R,[releasecue R.cue(end,1)]); 

figure(2), clf, hold on
histogram(swim_ct), histogram(rest_ct)