function [cues,R] = findbreathcues(R)
% find all the cues that include 'breath' or 'surf'
[Au,idx,idx2] = uniquecell(R.stype);
for i = 1:length(Au)
    if isempty(findstr(Au{i},'surf')) == 0
    scue(:,i) = i; % index involved with surfacing
    else if isempty(findstr(Au{i},'breath')) == 0
    scue(:,i) = i; % index involved with breathing
        end
    end
end
[cues,R] = findaudit(R,[Au(scue)]); % use only cues associated with breaths or surfacings
