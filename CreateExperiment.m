%Primary function
function experiment = CreateExperiment( stream )
%CREATEEXPERIMENT Summary of this function goes here
%   Detailed explanation goes here
 i = 1; 
 
 experiment = traverseMarker(stream, i);


end

%%Subfunctions - only accesible in the file within the primary function

function [ output_args ] = traverseMarker( stream, i)
%TRAVERSEMARKERSTREAM Summary of this function goes here
%   Detailed explanation goes here
markerStartCondition = '(Start Condition)';
markerEndCondition = '(End Condition)'

for i = i:numel(stream.time_series)
    
    current = stream.time_series{i};
    
    if(~isempty(regexp(current,markerStartCondition)))
        display('Found Start Condition');
    elseif(~isempty(regexp(current,patternForEndCondition)))
        display('Found Start Condition');
    end
    
end

end

function [ out ] = traverseCondition( markerStream, index ) 


end

function [ out ] = traverseTrial( markerStream, index)


end