function [transmissionDelay] = computeTransmissionDelay(linkRate,packetLength)
%computeTransmissionDelay: allows to compute the transmssion delay of the
%                          link given its bit rate and the lenght of the
%                          packet.
%   @linkRate: must be in kbit/s
%   @packetLenght: must be in bit
%   @transmissionDelay: the function returns a value in ms
    convertedLinkRate = linkRate * (10^3);
    convertedPacketLength = packetLength;
    transmissionDelay = (convertedPacketLength/convertedLinkRate) * 10^3;
end

