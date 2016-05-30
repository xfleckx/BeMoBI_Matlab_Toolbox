classdef ExperimentDataReader
    %EXPERIMENTDATAREADER Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        mazeData
        mazeGridPattern = 'matrix';
    end
    
    methods
        
        function obj = ExperimentDataReader()
        end
        
        function allMazes = LoadMazes(obj, directoryContainingMazeData)
            
            
            if ~isdir(directoryContainingMazeData)
                disp([directoryContainingMazeData ' is not a directory']);
            end
            
            filesContainingMazeData = dir([directoryContainingMazeData '\*.maze']);
             
            
            for xi = 1:length(filesContainingMazeData);
                currentFile = filesContainingMazeData(xi);
                
                pathToCurrentFile = [directoryContainingMazeData '\' currentFile.name];
                
                newMazeData = obj.readMaze(pathToCurrentFile, currentFile);
                
                obj.mazeData = [obj.mazeData newMazeData];
                
            end
            
            allMazes = obj.mazeData;
        end
        
        function mazeInfo = readMaze(obj, pathToMazeDataFile, fileName)
            fileID = fopen(pathToMazeDataFile);
            
            mazeInfo = [];
            
            tline = fgetl(fileID);
            
            while ischar(tline)
                
                lineContainsMatlabMatrixString = strfind(tline, obj.mazeGridPattern);
                
                if(lineContainsMatlabMatrixString)
                    mazeInfo.name = fileName.name;
                    mazeInfo.grid = [];
                    splitted = strsplit(tline, char(9));
                    mazeInfo.grid = eval( splitted{2} );
                end
                
                tline = fgetl(fileID);
            end
            
        end
    end
     
end

