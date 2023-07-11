function idxLink = findLink(in,out,linkList)
%FINDLINK : allows to find the index of the link in a link list given its
%terminals
idxLink = -1;
for(i = 1 : size(linkList,2))
    if(strcmp(linkList(i).inTerminal,in) && strcmp(linkList(i).outTerminal,out))
        idxLink = i;
    end
end
end

