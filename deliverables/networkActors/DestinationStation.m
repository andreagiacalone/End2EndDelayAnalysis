classdef DestinationStation
    %DESTINATIONSTATION : represents a destination station
    %   Detailed explanation goes here
    
    properties
        destinationLabel;
    end
    
    methods
        function destination = DestinationStation(destinationLabel)
            %DESTINATIONSTATION Construct an instance of this class
            %   Detailed explanation goes here
            destination.destinationLabel = destinationLabel;
        end
        
        function finalOutput = buildFinalOutput(destinationStation,calendar)
            %BUILDFINALOUTPUT: given a calendar, build a table containing
            %the source and the final time occurrence of the event.
            for(i = 1 : size(calendar.eventList,1))
                output(i,1) = calendar.eventList{i,2}.packetInfo.sourceLabel;
                output(i,2) = calendar.eventList{i,2}.timeOccurrence;
            end
            finalOutput = output;
        end
    end
end

