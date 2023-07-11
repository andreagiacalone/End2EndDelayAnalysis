%% Script of a simple test for the main features of the model objects and their interactions

%% Initializing the digraph
adjacencyMatrix = [0 1 0 0 0 0;0 0 1 0 1 1;0 0 0 1 0 0;0 0 0 0 0 0;0 0 0 0 0 0;0 0 0 0 0 0];
nodeNames = ["R1","R2","R3","A","B","C"];
D = digraph(adjacencyMatrix,nodeNames);
plot(D)


%% Initializing links
link(1) = Link(512,1,"R1","R2");
link(2) = Link(256,2,"R2","R3");
link(3) = Link(64,4,"R3","A");
link(4) = Link(1024,3,"R2","B");
link(5) = Link(256,5,"R2","C");


%% Initializing sources
sources(1) = SourceStation("R1",PacketInfo("R1","A",1,512));


%% Initializing nodes
nodes(1) = Node("R2",["R3" "B" "C"]);
nodes(2) = Node("R3", ["A"]);


%% Initializing destinations
destinations(1) = DestinationStation("A");
destinations(2) = DestinationStation("B");
destinations(3) = DestinationStation("C");

%% Starting step by step
calendarFromSource = buildStartingCalendar(sources(1),0,link(1));

calendarAfterLink = addPropDelay(link(1),calendarFromSource);



%node acts just as a filter --> the real queue is in buffer

buffer(1) = buildBuffer(nodes(1),D,calendarAfterLink,nodes(1).outInterfaces(1));
bufferedCalendar = sortBuffer(buffer(1));

idx = findLink(buffer(1).owner,buffer(1).outPortLabel,link);

calendarAfterLink = addTransmissionDelay(link(idx),bufferedCalendar);
calendarAfterLink = addPropDelay(link(idx),bufferedCalendar);

buffer(2) = buildBuffer(nodes(2),D,calendarAfterLink,nodes(2).outInterfaces(1));
bufferedCalendar = sortBuffer(buffer(2));

idx = findLink(buffer(2).owner,buffer(2).outPortLabel,link);

calendarAfterLink = addTransmissionDelay(link(idx),bufferedCalendar);
calendarAfterLink = addPropDelay(link(idx),bufferedCalendar);

%is destination? then select

dIdx = findDestination(buffer(2).outPortLabel,destinations);
finalOutput = buildFinalOutput(destinations(dIdx),calendarAfterLink);



