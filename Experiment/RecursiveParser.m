classdef RecursiveParser < handle
    %RECURSIVEPARSER Summary of this class goes here
    %   Detailed explanation goes here
    %    WARNING - will not work regarding missing tail call recursion
    %    optimization
    properties
        markerStartCondition = 'Begin Condition';
        markerEndCondition = 'End Condition';
        
        markerStartExperiment = 'Start Experiment';
        markerEndExperiment = 'End Experiment';
        
        expressionForConditionName = 'Condition ';
        
    end
    
    properties (Access = private)
        experiment
    end
    
    methods
        function experimentInstance = TraverseEventData(obj, markerStream)
            
            head = Head(markerStream);
            
            if(isempty(head))
                experimentInstance = obj.experiment;
                return
            end
            
            headOfTail = Head(Tail(markerStream));
            
            if(strfind( head.type, obj.markerStartExperiment) )
               
                obj.experiment = Experiment();
                
            elseif(strfind(headOfTail.type, obj.markerStartCondition))
                
                TraverseConditionData(Tail(markerStream), obj.experiment);
                
            end
            
            experimentInstance = obj.TraverseEventData(markerStream);
        end 
        
        function TraverseConditionData(obj, markerStream, instanceOfExperiment)
            current = Head(markerStream);
            
            if(strfind(current.type, obj.markerStartCondition))
                nameOfCondition = regexp(current.type, obj.expressionForConditionName, 'match');
                newCondition = Condition(nameOfCondition);
                instanceOfExperiment.Add(newCondition);
            end
            
        end
    end
    
end

