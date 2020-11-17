% Run tag audit only during surface periods of tag
% Works on Tag 2 and 3 deployments

% Julie van der Hoop jvanderhoop@bios.au.dk // 7 March 2017

close all; clear all;


%% load right whale for example
path = 'D:\gm13\gm13_220b\';
settagpath('cal',[path 'cal\'],'prh',[path 'prh\'],'raw',[path 'raw\'],'audit',[path 'audit\']);
settagpath('audio',path(1:3));
tag = 'gm13_220b';
tagver = dtagtype(tag);

%% load calibration and deployment info, tag audit
R = loadaudit(tag);
loadprh(tag);
    
if tagver==3,
    [CAL,DEPLOY] = d3loadcal(tag); % if Dtag3
elseif tagver==2,
    CAL = loadcal(tag); % if Dtag2      
end

%% this works to plot depth with time and add cues on top
figure(10); clf, hold on; warning off
t = (1:length(p))/fs;   % time in seconds
plot(t,-p)
xlabel('Time(sec)'), ylabel('Depth (m)')

plot(R.cue(:),zeros(length(R.cue),1),'r*') % plot any audited cues

% FIND DIVES
T = finddives(p,fs,10,1,0);
% plot dives 
for i = 1:length(T)
    plot(t(T(i,1)*fs:T(i,2)*fs),-p(T(i,1)*fs:T(i,2)*fs),'g')
end

% FIND PERIODS BETWEEN DIVES: matrix of S surfacings
S = nan(length(T),2);
S(1,1) = 1; S(1,2) = T(1,1); % assume tag begins at surface before first dive
S(2:length(T),1) = T(1:end-1,2);
S(2:length(T),2) = T(2:end,1);
% plot surfacings
for i = 1:length(S)
    plot(t(S(i,1)*fs:S(i,2)*fs),-p(S(i,1)*fs:S(i,2)*fs),'r')
end

%% AUDIT THOSE PERIODS ONLY
% for DTAG3
if tagver==3,
    for i = 1:length(S)
        R = d3tagaudit_surf(tag,S(i,1),R,S(i,:));
    end
    
% for DTAG2
elseif tagver==2,
    for i = 1:length(S)
        R = tagaudit_surf(tag,S(i,1),R,S(i,:));
    end    
end
        

