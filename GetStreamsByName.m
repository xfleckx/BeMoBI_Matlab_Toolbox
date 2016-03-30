function requested_Streams = GetStreamsByName( stream, names )
    requested_Streams = cell(1);
    for i = 1:numel(names)
        current_name = names{i};
        info = stream.info;
        if strcmp( info.name, current_name)
            requested_Streams{i} = stream;
        end
    end
end
