classdef SourceStation
    %SOURCESTATION represents a source station which sends packets
    
    properties
        sourceLabel
        packetInfoList
    end
    
    methods
        function source = SourceStation(sourceLabel,packets)
            %SOURCESTATION Construct an instance of this class
            source.sourceLabel = sourceLabel;
            source.packetInfoList = packets;
  
        end
        
        function [calendarFromSource] = buildStartingCalendar(source,startingTime,link)
            %BUILDSTARTINCALENDAR Allows to start the trasmission from this
            %source
            %@input:receives a packet list and the starting time of
            %transmission
            %@output:returns a calendar containing all matching infos.
            
            
            numOfEvents = size(source.packetInfoList,2);
            timeOccurrence = startingTime;
            for(idx = 1 : numOfEvents)
                    event{idx,1} = Event(timeOccurrence,"START",source.packetInfoList(idx));
                    timeOccurrence = timeOccurrence + computeTransmissionDelay(link.rate,source.packetInfoList(idx).length);
                    event{idx,2} = Event(timeOccurrence,"END",source.packetInfoList(idx));
            end

            calendarFromSource = Calendar(event);
        end
    end
end

