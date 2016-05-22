classdef ExperimentReader < handle
    %EXPERIMENTREADER Factory for BeMoBI Experiments
    %   Build an experiment from an set of marker
    
    properties(Access = public)
        markerStartCondition = 'Begin Condition';
        markerEndCondition = 'End Condition';
    end
    
    properties (Access = protected)
        streamSource
        states = CStack()
        experimentInstance
        parseIndex
    end
    
    methods
      function obj = ExperimentReader()
      end
      
      function StartReading(obj, markerStream)
          % Read an marker stream and parse it and return an experiment instance
          if(~isstruct(markerStream))
              disp('stream should be a eeg event struct');
              return
          end
          
          obj.streamSource = markerStream;
          
          obj.experimentInstance = Experiment();
          obj.parseIndex = 1;
          obj.parseForward();
          
          notify(obj,'ReadingFinished');
          return
      end
    end
    
    methods (Access = protected)
        
        function parseForward(obj)
            
            currentMarker = obj.streamSource(obj.parseIndex).type;
            
            if strfind(currentMarker, obj.markerStartCondition)
                disp(currentMarker);
                
                newConditionReader = ConditionReader()
                
                [newCondition, endIndex] = newConditionReader.StartReading(obj.streamSource, obj.parseIndex, obj.states);
                
                if(~isempty(newCondition))
                    obj.experimentInstance.conditions = [obj.experimentInstance.conditions newCondition];
                end
                
                obj.parseIndex = endIndex
            end
            
            if obj.parseIndex == length(obj.streamSource)
                return
            end
            
            obj.parseIndex = obj.parseIndex + 1;
            obj.parseForward()
        end
        
    end
    
    events
      ReadingFinished
    end
end

