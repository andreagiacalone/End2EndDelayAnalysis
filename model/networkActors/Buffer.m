


classdef Buffer
    %BUFFER represents a buffer in a node.
    %It represents an output Interface and its queue of packets: allows to
    %manage packet queuing in a network node.
    
    properties
        queue   %basically a Calendar object, but filtered for that particular outPort
        outPortLabel  
        owner
    end
    
    methods
           function buffer = Buffer(outPort,owner,filteredCalendar)
            %BUFFER Construct an instance of this class
            buffer.outPortLabel = outPort;
            buffer.queue = filteredCalendar;
            buffer.owner = owner;
           end
            
           function bufferedCalendar = sortBuffer(buffer,link)
               %SORTBUFFER: allows to manage the packet queuing
               length = buffer.queue.eventList{1,1}.packetInfo.length;
               transmissionDelay = computeTransmissionDelay(link.rate,length);
               buffer.queue.eventList{1,1}.timeOccurrence = buffer.queue.eventList{1,1}.timeOccurrence + transmissionDelay;
               buffer.queue.eventList{1,2}.timeOccurrence = buffer.queue.eventList{1,2}.timeOccurrence + transmissionDelay;
               for( i = 2 : size(buffer.queue.eventList,1))
                  if(buffer.queue.eventList{i,2}.timeOccurrence < buffer.queue.eventList{i-1,2}.timeOccurrence)
                      delayDueBuffer = (buffer.queue.eventList{i-1,2}.timeOccurrence) - (buffer.queue.eventList{i,2}.timeOccurrence);
                      buffer.queue.eventList{i,1}.timeOccurrence = buffer.queue.eventList{i,1}.timeOccurrence + delayDueBuffer;
                      buffer.queue.eventList{i,2}.timeOccurrence = buffer.queue.eventList{i,2}.timeOccurrence + delayDueBuffer;
                      length = buffer.queue.eventList{i,1}.packetInfo.length;
                      transmissionDelay = computeTransmissionDelay(link.rate,length);
                      buffer.queue.eventList{i,1}.timeOccurrence = buffer.queue.eventList{i,1}.timeOccurrence + transmissionDelay;
                      buffer.queue.eventList{i,2}.timeOccurrence = buffer.queue.eventList{i,2}.timeOccurrence + transmissionDelay;
                  else if(buffer.queue.eventList{i,2}.timeOccurrence >= buffer.queue.eventList{i-1,2}.timeOccurrence)
                      length = buffer.queue.eventList{i,1}.packetInfo.length;
                      transmissionDelay = computeTransmissionDelay(link.rate,length);
                      buffer.queue.eventList{i,2}.timeOccurrence = buffer.queue.eventList{i,2}.timeOccurrence + transmissionDelay;
                      end
                  end
               end
               
               bufferedCalendar = Calendar(buffer.queue.eventList);  
            end
        
    
    end
end

