function mazeModel = ImportMazeModel(filename)
    % ImportMazeModel expect a file containing the representation of a
    % Maze as binary matrix
    p = inputParser();
    addRequired(p,'filename',@ischar);
    parse(p,filename)
    if ~exist(filename, 'file')
            throw(MException('ImportMazeModel:FileNotFound', filename));
    end
    [~,name,~] = fileparts(filename);
    mazeModel = MazeModel();
    mazeModel.Name = name;
    mazeModel.Matrix = dlmread(filename);
end