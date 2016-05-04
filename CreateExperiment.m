%Primary function
function experiment = CreateExperiment( stream )
%CREATEEXPERIMENT Summary of this function goes here
%   Detailed explanation goes here
 i = 1; 
 
 experiment = traverseMarker(stream, i);


end

%%Subfunctions - only accesible in the file within the primary function

function [ output_args ] = traverseMarker( stream , i)
%TRAVERSEMARKERSTREAM Summary of this function goes here
%   Detailed explanation goes here

for i = i:numel(stream.time_series)
    if(
end

end

function [ out ] = traverseCondition( markerStream, index ) 


end

function [ out ] = traverseTrial( markerStream, index)


end