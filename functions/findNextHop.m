function nextHop = findNextHop(digraph,questionedNode, destination)
%FINDNEXTHOP : allows to find the next hop node in order to choose the
%right path and reach the destination station.

if(size(successors(digraph,questionedNode),1)==0)
     nextHop =[]
     return
else if(ismember(destination,successors(digraph,questionedNode))==1)
        nextHop = destination;
        return
    else
        nextOnes = successors(digraph,questionedNode);
        for(i = 1: size(nextOnes,1))
            nextHop = findNextHop(digraph,nextOnes(i),destination);
            if(strcmp(nextHop,destination)==1)
                break;
            end
        end
        nextHop = nextOnes(i);

    end
end
end
            
