function [delayedTime] = computePropDelay(transmissionDelay,propDelay)
%computeTotalDelay This function allows to compute the total delay by
%adding the transmissionDelay computed before and the propDelay
%@transmissionDelay: must be in ms
%@propDelay: must be in ms
%@delayedTime: must be in ms
    propDelay = propDelay; %in ms
    delayedTime = transmissionDelay + propDelay;
end

