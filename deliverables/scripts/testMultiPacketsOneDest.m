%% Script of a network topology following the example of EX.1.6(semplified)

%% Initializing the digraph
adjacencyMatrix = [0 1 0 0 0 0;0 0 1 0 1 1;0 0 0 1 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0];
nodeNames = ["R1","R2","R3","A","B","C"];
D = digraph(adjacencyMatrix,nodeNames);
plot(D)


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

%% Starting step by step
sourceIdx = 1;  %in this case we have just one source --> we don't need a check!
linkIdx = findLink(sources(sourceIdx).sourceLabel,successors(D,sources(sourceIdx).sourceLabel),links);
calendarFromSource = buildStartingCalendar(sources(sourceIdx),0,links(linkIdx));
calendarAfterLink = addPropDelay(links(1),calendarFromSource);

linkIdx(1) = findLink(nodes(1).nodeLabel,nodes(1).outInterfaces(1),links);

buffer(1) = buildBuffer(nodes(1),D,calendarAfterLink,nodes(1).outInterfaces(1));
bufferedCalendar = sortBuffer(buffer(1),links(linkIdx));

calendarAfterLink = addPropDelay(links(linkIdx),bufferedCalendar);

linkIdx = findLink(nodes(2).nodeLabel,nodes(2).outInterfaces(1),links);

clear buffer
buffer(1) = buildBuffer(nodes(2),D,calendarAfterLink,nodes(2).outInterfaces(1));
bufferedCalendar = sortBuffer(buffer(1),links(linkIdx));
calendarAfterLink = addPropDelay(links(linkIdx),bufferedCalendar);

finalOutput = buildFinalOutput(destinations(1),calendarAfterLink);











