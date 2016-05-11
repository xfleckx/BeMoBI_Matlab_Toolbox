classdef MoBIExperiment < handle
    properties
        Streams
    end
    
    events
        LoadingExperimentFinished
        ErrorOnLoadingExperiment
    end
    
    methods
        function LoadFrom(xdf_file)
            notify( 'LoadingExperimentFinished')
        end
    end
end