classdef Trial < handle
    %TRIAL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Maze
        Path
        Object
        Turns
        Tics
    end
    
    methods
        function AddTurn(obj, turn)
            obj.Turns = [obj.Turns turn];
        end
    end
    
end

