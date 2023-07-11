classdef Calendar

    %CALENDAR represents an event calendar, wrapping all main info about
    %           transmission times of each type.
    
    properties
        eventList

    end
    
    methods
        function calendar = Calendar(eventList)
            %CALENDAR Construct an instance of this class
            %   Detailed explanation goes here
            calendar.eventList = eventList;
        end
        
    end
end

