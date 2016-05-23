function all_event_names  = GrabEventsByLabel( markerStream, expectedLabels )
%GRABEVENTSBYLABEL Summary of this function goes here
%   TODO find all events containing a specific label and return them all as
%   return a cell array which could be passed to eeglabs pop_epoch(
%   'typerange', output_args

    all_event_names = [];
    for n = 1:length(expectedLabels)
        expectedLabel = expectedLabels{n};
        tmp = strfind({markerStream(:).type},expectedLabel);
        index = find(~cellfun(@isempty,tmp));
        event_names = {markerStream(index).type};
        event_names = unique(event_names);
        all_event_names = [all_event_names event_names];
    end

end

