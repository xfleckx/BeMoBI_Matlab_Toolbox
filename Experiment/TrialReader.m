classdef TrialReader < handle
    %TRIALREADER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       patternBegin = 'BeginTrial'
       patternEnd = 'EndTrial'
       unitEnter = 'Entering Unit'
       unitExit = 'Exiting Unit'
       turn = 'Turn'
       turnCorrect = 'Turn From'
       turnIncorrect = 'Incorrect Turn'
    end
    
    properties (Access = private)
        trial
        current
        next
        maze
        unitEnterTime
    end
    
    
    methods
        function obj = TrialReader()
        end
        function newTrial = ReadFrom(obj, stream, atIndex)
            
            obj.current = stream(atIndex);
            
            if(strfind(obj.current.type, obj.patternBegin))
                
                disp('Start Parsing one Trial');
                
                obj.trial = Trial(); 
                obj.unitEnterTime = 0;
                while isempty(strfind(obj.current.type, obj.patternEnd))
                    disp(obj.current.type);    
                    
                    if(atIndex > length(stream))
                        msgID = 'MYFUN:BadIndex';
                        msg = 'Trial has no End Marker...';
                        baseException = MException(msgID,msg);
                        throw(baseException)
                    end
                    
                    if(strfind(obj.current.type, obj.unitEnter))
            
                        obj.next = stream(atIndex + 1);            
                        obj.unitEnterTime = obj.current.latency;
                        disp(obj.next);
                        
                              
%                         msgID = 'MYFUN:CorruptStream';
%                         msg = 'Missing Exiting Unit Marker!';
%                         baseException = MException(msgID,msg);
%                         throw(baseException) 
                        
                    end
                     
                    if(strfind(obj.current.type, obj.turn))
                            disp(obj.current.type);
                    end
                    
                    if(strfind(obj.current.type, obj.unitExit))

                        c = regexp(obj.current.type, '\d', 'match');
                        x = c{1};
                        y = c{2};
                        deltaTime = obj.current.latency - obj.unitEnterTime;

                        obj.trial.Tics(x,y) = deltaTime;
                    end
                    
                    atIndex = atIndex + 1;
                    obj.current = stream(atIndex);
                    
                end
                
                disp('End Parsing one Trial');
                obj.trial.Tics(all(~obj.trial.Tics, 1), : ) = [];
                
                obj.trial.Tics( :, all(~obj.trial.Tics, 1)) = [];
                
                newTrial = obj.trial;
            end
            
        end
        
    end
    
end

