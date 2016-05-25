classdef TrialReader < handle
    %TRIALREADER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
       patternBegin = 'BeginTrial'
       patternEnd = 'EndTrial'
       unitEnter = 'Entering Unit'
       unitExit = 'Exiting Unit'
       turn = 'Turn'
       turnCorrect = 'Correct'
       turnIncorrect = 'Incorrect'
       delimiter = char(9)
    end
    
    properties (Access = private)
        trial
        current
        next
        maze
        unitEnterTime
        experimentData
    end
    
    
    methods
        function obj = TrialReader( experimentData )
           obj.experimentData = experimentData;
        end
        function [lastIndex, newTrial] = ReadFrom(obj, stream, atIndex)
            
            obj.current = stream(atIndex);
            marker = obj.current.type;
            if(strfind(marker, obj.patternBegin))
                
                disp('Start Parsing one Trial');
                
                trialDefinition = strsplit(marker, obj.delimiter);
                obj.trial = Trial(); 
                obj.trial.Tics = obj.experimentData.Maze
                obj.trial.Tics = zeros(10,13);
                
                obj.unitEnterTime = 0;
                while isempty(strfind(marker, obj.patternEnd))
                    marker = obj.current.type;
                    if(atIndex > length(stream))
                        msgID = 'MYFUN:BadIndex';
                        msg = 'Trial has no End Marker...';
                        baseException = MException(msgID,msg);
                        throw(baseException)
                    end
                    
                    if(strfind(marker, obj.unitEnter))
            
                        obj.next = stream(atIndex + 1);            
                        obj.unitEnterTime = obj.current.latency;
                        disp(obj.next);
                        
                              
%                         msgID = 'MYFUN:CorruptStream';
%                         msg = 'Missing Exiting Unit Marker!';
%                         baseException = MException(msgID,msg);
%                         throw(baseException) 
                        
                    end
                     
                    if(strfind(marker, obj.turn))
                        values = strsplit(marker, obj.delimiter);
                        newTurn.typeOfTurn = 'Correct';
                        newTurn.egocentricDirection = values{end};
                        newTurn.offsetToLastTurn = 0;
                        newTurn.typeOfDecision = values{end-1};
                        obj.trial.AddTurn(newTurn);
                    end
                    %special case here for pilot data
                    if(strfind(obj.current.type, obj.turnIncorrect))
                        values = strsplit(marker, obj.delimiter);
                        newTurn.typeOfTurn = 'Incorrect';
                        newTurn.egocentricDirection = values(end);
                        newTurn.offsetToLastTurn = 0;
                        newTurn.typeOfDecision = values(end-1);
                        obj.trial.AddTurn(newTurn);
                    end
                    
                    if(strfind(marker, obj.unitExit))

                        c = regexp(marker, '\d', 'match');
                        x = str2num( c{1} ) + 1;
                        y = str2num( c{2} ) + 1;
                        deltaTime = obj.current.latency - obj.unitEnterTime;

                        obj.trial.Tics(x,y) = deltaTime;
                    end
                    
                    atIndex = atIndex + 1;
                    obj.current = stream(atIndex);
                    
                end
                
                disp('End Parsing one Trial'); 
                
                newTrial = obj.trial;
                lastIndex = atIndex;
            end
            
        end
        
    end
    
end

