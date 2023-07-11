function destinationIdx = findDestination(destinationLabel,destinationList)
%FINDDESTINATION : allows to find the index of a destination station given
%its label
%@destinationLabel: string label of the station to find
%@destinationList: list of Destination Station
%@destinationIdx: index of the Destination Station matching the label
    destinationIdx = -1;
    for(i = 1 : size(destinationList,2))
        if(strcmp(destinationList(i).destinationLabel,destinationLabel))
            destinationIdx = i;
        end
    end
end

