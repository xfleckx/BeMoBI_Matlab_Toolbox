function infos = GetAvailableStreams( experiment_data )
%GETAVAILABLESTREAMS Summary of this function goes here
%   Detailed explanation goes here
    streamCount = length(experiment_data);
    infos = {streamCount};
    for i=1:streamCount
        a_single_stream = experiment_data{i};
        stream_info.name = a_single_stream.info.name;
        stream_info.type = a_single_stream.info.type;
        infos{i} = stream_info;
        clear i a_single_stream
    end
end