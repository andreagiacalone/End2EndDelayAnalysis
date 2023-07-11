function nodeIdx = findNode(nodeLabel,nodeList)
%FINDNODE : allows to find the index of a node in a node list given its
%label
    nodeIdx = -1;
    for(i = 1 : size(nodeList,2))
        if(strcmp(nodeList(i).nodeLabel,nodeLabel))
            nodeIdx = i;
        end
    end
end

