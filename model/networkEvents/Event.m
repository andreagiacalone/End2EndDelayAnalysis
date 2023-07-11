classdef Event
    %EVENT : wraps all infos about a transmission event.
    
    properties
        timeOccurrence
        typeOfTransmission
        packetInfo
        
    end
    
    methods
        function event = Event(occTime,type,pInfo)
            %EVENT Construct an instance of this class

            event.timeOccurrence = occTime;
            event.typeOfTransmission = type;
            event.packetInfo = pInfo;
        end
        
    end
end

