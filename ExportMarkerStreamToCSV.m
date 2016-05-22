function ExportMarkerStreamToCSV( stream , filename)
%EXPORTMARKERSTREAMTOCSV Summary of this function goes here
%   Detailed explanation goes here

fileID = fopen(filename, 'w');

formatSpec = '%f\t%s\n';

for i = 1:numel(stream.time_series)
    timestamp = stream.time_stamps(i);
    marker = stream.time_series(i);
    fprintf(fileID,formatSpec, timestamp, marker{1});
end

fclose(fileID);
end

