function duration = CalcExperimentDuration( input_args )
%CALCEXPERIMENTDURATION Summary of this function goes here
%   Detailed explanation goes here

deltaBetween_Start_End = input_args(2).timeStamp - input_args(1).timeStamp;

duration = deltaBetween_Start_End;

end

