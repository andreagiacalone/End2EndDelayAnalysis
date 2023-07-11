
classdef Node
    % NODE it represents an abstraction of a network node.

    properties
        nodeLabel
        outInterfaces
    end
    
    methods
        function node = Node(nodeLabel,names)
            %NODE Construct an instance of this class
            node.nodeLabel = nodeLabel;
            node.outInterfaces = names;
            
        end
        
        function nextHopBuffer = buildBuffer(node,digraph,calendar2Filter,nextHop)
            %BUILDBUFFER: allows to build a buffer in order to filter
            %packets according to their destinations.
            idx = 1;
            flag = 0;
            if(ismember(nextHop,node.outInterfaces)) %%optional check, doesn't really need it...
                for(eventIdx = 1 : size(calendar2Filter.eventList,1))
                    destination = calendar2Filter.eventList{eventIdx,1}.packetInfo.destinationLabel;
                    if(strcmp(nextHop,findNextHop(digraph,node.nodeLabel,destination))==1)
                        flag = 1;
                        eventList{idx,1} = calendar2Filter.eventList{eventIdx,1};
                        eventList{idx,2} = calendar2Filter.eventList{eventIdx,2};
                        nextHopBuffer = Buffer(nextHop,node.nodeLabel,Calendar(eventList));
                        idx=idx+1;
                    end
                end
                if (flag == 0)
                    nextHopBuffer = [];
                end
            
            end
        
        end
    end
end