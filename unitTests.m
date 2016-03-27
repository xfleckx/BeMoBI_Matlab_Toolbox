function tests = unitTests
tests = functiontests(localfunctions);
end

function test_NameOfMazeIsNameOfFile(testCase)
    pathToTestFile = 'testData\aCorrect.maze';
    correctImportedMaze = ImportMazeModel(pathToTestFile);
    verifyEqual(testCase,correctImportedMaze.Name,'aCorrect');
end


