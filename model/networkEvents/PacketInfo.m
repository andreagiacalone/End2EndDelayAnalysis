classdef PacketInfo
    %PACKETINFO wraps all main variables which identify a specific packet.
    
    properties
        sourceLabel
        destinationLabel
        orderNumber
        length
    end
    
    methods
        function packet = PacketInfo(sourceLabel,destinationLabel,orderNumber,length)
            %PACKETINFO: constructor of the class.
            packet.sourceLabel = sourceLabel;
            packet.destinationLabel = destinationLabel;
            packet.orderNumber = orderNumber;
            packet.length = length;
        end
        
        function sLabel = getSource(packet)
            %GETSOURCE getter of the source label.
            %   returns the source label of packet.
            sLabel = packet.sourceLabel;
        end
        function dLabel = getDestination(packet)
            %GETDESTINATION getter of the destination label.
            %   returns the destination label of packet.
            dLabel = packet.destinationLabel;
        end
        
        function number = getNumber(packet)
            %GETNUMBER getter of the order number.
            %   returns the order number of packet.
            number = packet.orderNumber;
        end
        
        function pLength = getLength(packet)
            %GETLENGTH getter of the length.
            %   returns the length of packet.
            pLength = packet.length;
        end
        
        function setNumber(packet,newNumber)
            %SETNUMBER setter of the order number.
            %   sets the new number of packet.
            packet.orderNumber = newNumber;
        end
        
    end
end

