classdef TrialReader < handle
    %TRIALREADER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       patternBegin = 'BeginTrial';
       patternEnd = 'EndTrial';
    end
    
    properties (Access = private)
        trial
        current
    end
    
    methods
        function obj = TrialReader()
        end
        function newTrial = ReadFrom(obj, stream, atIndex)
            
            obj.current = stream(atIndex);
            
            if(strfind(obj.current.type, obj.patternBegin))
                
                disp(obj.current.type);
                
                obj.trial = Trial(); 
                
                while isempty(strfind(obj.current.type, obj.patternEnd))
                    disp(obj.current.type);    
                    
                    atIndex = atIndex + 1;
                    
                    if(atIndex > length(stream))
                        msgID = 'MYFUN:BadIndex';
                        msg = 'Trial has no End Marker...';
                        baseException = MException(msgID,msg);
                        throw(baseException)
                    end
                    
                    obj.current = stream(atIndex);
                end
                
                newTrial = obj.trial;
            end
            
        end
        
    end
    
end

