function p = fixsensor(p,fixwin,L)

% Repair sensor values in the sensor indices fixwin
% by interpolating across fixwin using L sensor values on either
% side of fixwin

k=fixwin(:);

if ~isempty(k)

    k1=min(fixwin)+[-L:-1];
    k2=max(fixwin)+[1:L];
    kbg=[k1(:) ; k2(:)];

    p(k) = interp1(kbg,p(kbg),k)+mean([std(p(k1)) std(p(k2))])*(rand(length(k),1)-0.5);
end