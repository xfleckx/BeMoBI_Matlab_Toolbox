function available = DependencyCheck( expected_function_file )
%DEPENDENCYCHECK Summary of this function goes here
%   Detailed explanation goes here
the_file_doesnt_exists = not( exist(expected_function_file, 'file') == 2 );

if (the_file_doesnt_exists)
    error(strcat(expected_function_file ,' file is missing in the path'));
else
    containing_path = which(expected_function_file);
    message = strcat('Found load_xdf.m @ ', containing_path);
    disp(message);
end
    available = the_file_doesnt_exists;
end

