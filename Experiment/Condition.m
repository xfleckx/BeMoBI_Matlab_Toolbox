classdef Condition < handle
    %CONDITION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Name
        Trials
    end
    
    methods
        
        function obj = Condition(name)
           obj.Name = name; 
        end
        
        function Add(obj, trial)
            obj.Trials = [obj.Trials trial];
        end
        
    end
    
end

