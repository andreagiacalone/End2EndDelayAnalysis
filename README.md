# End2EndDelaysAnalysis


## Project Description
The following project focuses on the analysis of transmission delays in a network topology. 

Given a digraph and the initialization of its nodes, each class of the network model allows to manage multiple source-destination transmissions, following a proper packet queuing policy.

At the end of the computation, a list of final output times will show the final time of occurrence for every packet which reaches its destination.


## Network Model:
- **Source Station** : allows to build a starting Calendar given a list of packet infos;
- **Link** : allows to compute and add transmission and propagation delays for each entry of the input Calendar;
- **Node** : allows to filter packets wrapped in input Calendar objects received from each input interfaces of the node and forward it, following the right 
path for their destination;
- **Buffer** : allows to manage packet queuing inside of each network node employing a FIFO queue;
- **Destination Station** : allows to build a list of times of occurrence for each packet that reaches that destination.
    
 ## Demo:
 ![ex1 6](https://user-images.githubusercontent.com/55977365/123873003-1e046d00-d936-11eb-8216-0551a960f0f0.PNG)
> Given the network topology of this example, I tested the proper implementation of the behaviour of each class (check it out the script [here](https://github.com/andreagiacalone/End2EndDelayAnalysis/blob/main/scripts/test/finalTest.m)).

*DISCLAIMER*: to test yourself, before executing the code, you should add the "deliverables" folder to Matlab path.
