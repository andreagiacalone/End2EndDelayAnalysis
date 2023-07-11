classdef Link
    %LINK Summary of this class goes here

    properties
        rate
        propDelay
        inTerminal
        outTerminal
    end
    
    methods
        function link = Link(rate,propDelay,inTerminal,outTerminal)
            %LINK Construct an instance of this class

            link.rate = rate;
            link.propDelay = propDelay;
            link.inTerminal = inTerminal;
            link.outTerminal = outTerminal;
        end
        
        function delayedCalendar = addTransmissionDelay(link,calendar)
            %ADDTRANSMISSIONDELAY allows to build a calendar adding the transmission
            %delay for each entry
            for(eventIdx = 1 : size(calendar.eventList,1))
                length4Compute = calendar.eventList{eventIdx,1}.packetInfo.length;
                timeBeforeCompute = calendar.eventList{eventIdx,1}.timeOccurrence;
                transmissionDelay = computeTransmissionDelay(link.rate,length4Compute);
                timeAfterCompute = timeBeforeCompute + transmissionDelay;
                calendar.eventList{eventIdx,1}.timeOccurrence = timeAfterCompute;
                length4Compute = calendar.eventList{eventIdx,2}.packetInfo.length;
                timeBeforeCompute = calendar.eventList{eventIdx,2}.timeOccurrence;
                transmissionDelay = computeTransmissionDelay(link.rate,length4Compute);
                timeAfterCompute = timeBeforeCompute + transmissionDelay;
                calendar.eventList{eventIdx,2}.timeOccurrence = timeAfterCompute;
            end 
            
            delayedCalendar = Calendar(calendar.eventList);
        end
        
        function delayedCalendar = addPropDelay(link,calendar)
            %ADDPROPDELAY allows to build a calendar adding the propagation
            %delay for each entry
            delayedCalendar = calendar;
            for(eventIdx = 1 : size(delayedCalendar.eventList,1))
                timeBeforeCompute = delayedCalendar.eventList{eventIdx,1}.timeOccurrence;
                delay = computePropDelay(link.propDelay,timeBeforeCompute);

                delayedCalendar.eventList{eventIdx,1}.timeOccurrence = delay;
                
                timeBeforeCompute = delayedCalendar.eventList{eventIdx,2}.timeOccurrence;
                delay = computePropDelay(link.propDelay,timeBeforeCompute);

                delayedCalendar.eventList{eventIdx,2}.timeOccurrence = delay;
            end 
        end
    end
end

