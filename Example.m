%% An example on how to work with the behavioral data

%% Check whether dependencies are missing
DependencyCheck('load_xdf.m');

%% Load an xdf file
[experiment_data, fileheader] = load_xdf('testData/the_first_mobivr_pilot.xdf');

%% Lookup available streams in the file
% availableStreams contains all streams... this should contained
availableStreams = GetAvailableStreams(experiment_data);

%% Print an overview on the streams
PrettyPrint(availableStreams);
% Now you know all the names from the available streams 

%% it's time to get one specific stream
requested_streams = cellfun(@(stream) GetStreamsByName(stream, {'MoBIVR.SearchAndFind'}), experiment_data);
stream_set_wo_empty_cells = requested_streams(~cellfun(@isempty, requested_streams));

%% plot a time series for the marker stream
marker = stream_set_wo_empty_cells{1};
clear stream_set_wo_empty_cells

%% get all marker types
%  assuming that are defined in a way like
%  <MarkerType><delimiter>[<MarkerParams>]


%% get a subset of markers
expectedTrialTypes = {'BeginTrial', 'EndTrial'};
filtered_Stream_Containing_Trials = FilterStreamByMarkers(marker, expectedTrialTypes);
clear expectedTrialTypes

%% get timings for trials


%% TODO estimate timings for each maze

%% use imagesc http://de.mathworks.com/help/matlab/ref/imagesc.html
%  to plot the heatmap
%  Map brightness to timing (TIC) and colors to type of cell
%  None existing cells rendered black

