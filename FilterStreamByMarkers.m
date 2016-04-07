function filteredStream = FilterStreamByMarkers( stream, markerPattern )
%FILTERSTREAMBYMARKER get a subset of elements from the stream by 
%   using patterns describing the markers you want

lengthOfAllSamples = length(stream.time_series);
samples = stream.time_series;
timeStamps = stream.time_stamps;
indexOfFilteredStream = 1

for i=1 : lengthOfAllSamples
    currentMarker = samples{i};
    for m=1 : numel(markerPattern)
      currentPattern = markerPattern{m};
      match = regexp(currentMarker, currentPattern, 'match');
      if ~isempty(match)
        selectedElements(indexOfFilteredStream).timeStamp = timeStamps(i);
        selectedElements(indexOfFilteredStream).marker = samples(i);
        indexOfFilteredStream = indexOfFilteredStream + 1;
      end
    end
end

    filteredStream = selectedElements
end

