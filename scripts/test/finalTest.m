%% Script of a network topology following the example of EX.1.6

%% Initializing the digraph
adjacencyMatrix = [0 1 0 0 0 0;0 0 1 0 1 1;0 0 0 1 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0];
nodeNames = ["R1","R2","R3","A","B","C"];
D = digraph(adjacencyMatrix,nodeNames);
plot(D,'layout','circle')


%% Initializing links
links(1) = Link(512,1,"R1","R2");
links(2) = Link(256,2,"R2","R3");
links(3) = Link(64,4,"R3","A");
links(4) = Link(1024,3,"R2","B");
links(5) = Link(256,5,"R2","C");


%% Initializing packets
packets(1) = PacketInfo("R1","A",1,512);
packets(2) = PacketInfo("R1","A",2,512);
packets(3) = PacketInfo("R1","B",3,512);
packets(4) = PacketInfo("R1","B",4,512);
packets(5) = PacketInfo("R1","C",5,512);
packets(6) = PacketInfo("R1","C",6,512);


%% Initializing sources
sources(1) = SourceStation("R1",packets);


%% Initializing nodes
nodes(1) = Node("R2",successors(D,"R2")');  %improved instruction: we can use successors function to find next hops!
nodes(2) = Node("R3",successors(D,"R3")');


%% Initializing destinations
destinations(1) = DestinationStation("A");
destinations(2) = DestinationStation("B");
destinations(3) = DestinationStation("C");

%% Starting step by step : testing the model
sourceIdx = 1;  %%in this case we have just one source --> we don't need a check!
linkIdx = findLink(sources(sourceIdx).sourceLabel,successors(D,sources(sourceIdx).sourceLabel),links);
calendarFromSource = buildStartingCalendar(sources(sourceIdx),0,links(linkIdx));
calendarAfterLink = addPropDelay(links(1),calendarFromSource);


linkIdx(1) = findLink(nodes(1).nodeLabel,nodes(1).outInterfaces(1),links);
linkIdx(2) = findLink(nodes(1).nodeLabel,nodes(1).outInterfaces(2),links);
linkIdx(3) = findLink(nodes(1).nodeLabel,nodes(1).outInterfaces(3),links);


buffer(1) = buildBuffer(nodes(1),D,calendarAfterLink,nodes(1).outInterfaces(1));
buffer(2) = buildBuffer(nodes(1),D,calendarAfterLink,nodes(1).outInterfaces(2));
buffer(3) = buildBuffer(nodes(1),D,calendarAfterLink,nodes(1).outInterfaces(3));

bufferedCalendar(1) = sortBuffer(buffer(1,1),links(linkIdx(1)));
bufferedCalendar(2) = sortBuffer(buffer(1,2),links(linkIdx(2)));
bufferedCalendar(3) = sortBuffer(buffer(1,3),links(linkIdx(3)));

calendarAfterLink(1) = addPropDelay(links(linkIdx(1)),bufferedCalendar(1));
if(findDestination(links(linkIdx(1)).outTerminal,destinations) ~= -1)
    finalOutput{1} = buildFinalOutput(destinations(1),calendarAfterLink(1));
end
calendarAfterLink(2) = addPropDelay(links(linkIdx(2)),bufferedCalendar(2));
if(findDestination(links(linkIdx(2)).outTerminal,destinations) ~= -1)
    finalOutput{2} = buildFinalOutput(destinations(2),calendarAfterLink(2));
end
calendarAfterLink(3) = addPropDelay(links(linkIdx(3)),bufferedCalendar(3));
if(findDestination(links(linkIdx(3)).outTerminal,destinations) ~= -1)
    finalOutput{3} = buildFinalOutput(destinations(3),calendarAfterLink(3));
end
finalOutput{2} = buildFinalOutput(destinations(2),calendarAfterLink(2));
finalOutput{3} = buildFinalOutput(destinations(3),calendarAfterLink(3));

clear linkIdx
linkIdx = findLink(nodes(2).nodeLabel,nodes(2).outInterfaces(1),links);

clear buffer
buffer = buildBuffer(nodes(2),D,calendarAfterLink(1),nodes(2).outInterfaces(1));
clear bufferedCalendar
bufferedCalendar = sortBuffer(buffer(1),links(linkIdx));

calendarAfterLink(1) = addPropDelay(links(linkIdx),bufferedCalendar);
if(findDestination(links(linkIdx(1)).outTerminal,destinations) ~= -1)
    finalOutput{1} = buildFinalOutput(destinations(1),calendarAfterLink(1));
end






