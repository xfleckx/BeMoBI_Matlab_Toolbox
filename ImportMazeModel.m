function mazeModel = ImportMazeModel(fileName)
    % ImportMazeModel expect a file containing the representation of a
    % Maze as binary matrix
    if ~exist(fileName, 'file')
        throw MException('File not found', fileName);
    end


    mazeModel = MazeModel()
    
end