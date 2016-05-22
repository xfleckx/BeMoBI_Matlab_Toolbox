classdef ConditionReader < handle
    %CONDITIONREADER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        markerBeginTrial = 'Begin Trial'
    end
    
    properties(Access = protected)
       streamSource 
       stateStack
       conditionInstance
    end
    
    methods
        
      function obj = ConditionReader()
      end
      
      function [newCondition, endIndex] = StartReading(obj, markerStream, index, states)
          % Read an marker stream and parse it and return an experiment instance
          
          obj.streamSource = markerStream;
          obj.stateStack = states;
          obj.parseForward(index);
          
          endIndex = obj.parseIndex;
          newCondition = obj.conditionInstance;
      end
    end
    
    methods (Access = protected)
        
        function parseForward(obj, index, stateStack)
            
            currentMarker = obj.streamSource(index).type;
            
            if strfind(currentMarker, obj.markerBeginTrial)
                disp(currentMarker);
                
                newTrialReader = TrialReader()
                
                [newTrial, endIndex] = newTrialReader.StartReading(index, stateStack)
                
                obj.conditionInstance.trials = [obj.conditionInstance.Trials newTrial];
                
                obj.parsindIndex = endIndex
            end
            
            if(strfind(currentMarker,stateStack.Peek()))
                return
            end
            
            obj.parseIndex = obj.parseIndex + 1;
            obj.parseForward(obj.parseIndex)
        end
        
    end
end

