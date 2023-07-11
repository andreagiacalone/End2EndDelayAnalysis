load('data/problemData.mat')
%% Initialization of main variables and costants of the script
NUM_PACKETS = size(packets,1);
INITIAL_TIME = 0.0;
packetEndToEndTable = packets.EndNodes;
nodeArray = table2array(D.Nodes);
totalCalendarOutput = zeros(8);


for(idx = 1 : NUM_PACKETS)

    packetLength = packets.Length(idx);
    packetSource = cell2mat(packetEndToEndTable(idx,1));
    packetDestination = cell2mat(packetEndToEndTable(idx,2));
    head = packetSource;
    headIdx = find(strcmp(nodeArray,packetSource));
    numHops = 1;
    singleCalendarOutput = zeros(1,8);

    startingTime = INITIAL_TIME;
    
    
    while(~(strcmp(head,packetDestination)))
        out = outdegree(D,head);
        
        if (out == 1)
            nextHop = successors(D,head);
            for(link = 1: size(linkInfo,1))
                if  strcmp(linkInfo.EndNodes{link,1},head)
                    if strcmp(linkInfo.EndNodes{link,2},nextHop)
                        linkRate = linkInfo.Rate(link);
                        linkPropDelay = linkInfo.propDelay(link);
                    end
                end
            end
            totalDelay = computeTotalDelay(computeTransmissionDelay(linkRate,packets.Length(idx)),linkPropDelay);
            head = nextHop;

        else if(out >= 2) %#ok<SEPEX>\
            nextOnes = successors(D,head);
            found = 0;
            while(found == 0)
                if(ismember(packetDestination,nextOnes))
                    nextHop = packetDestination;
                    found = 1;
                else
                    for(path = 1 : size(nextOnes,1))
                        tmp = successors(D,nextOnes(path));
                        if(ismember(packetDestination,tmp))
                            nextHop = nextOnes(path);
                            found = 1;
                        end
                    end
                end
            end
             for(link = 1: size(linkInfo,1))
                if  strcmp(linkInfo.EndNodes{link,1},head)
                    if strcmp(linkInfo.EndNodes{link,2},nextHop)
                        linkRate = linkInfo.Rate(link);
                        linkPropDelay = linkInfo.propDelay(link);
                    end
                end
             end
            totalDelay = computeTotalDelay(computeTransmissionDelay(D.Edges.Rate(headIdx),packets.Length(headIdx)),D.Edges.PropDelay(headIdx));
            head = nextHop; 
            end
        end
        
        headIdx = find(strcmp(nodeArray,head));
        numHops = numHops +1;
        startingTime = totalDelay;
        singleCalendarOutput(numHops) = startingTime;
    
    end
    totalCalendarOutput(idx,:) = singleCalendarOutput(:); 
    
    
end


%% Now we have to manage possible queuing problems and sort the time table.


plot(D)

    
    
    