
function PrettyPrint( streamInfos )
%PRETTYPRINT Just show name and type of the streams in the given set
%streamInfos
    for i=1:numel(streamInfos),
        info = streamInfos{i};
        formated = sprintf([info.idx, '# ', 'Name: ', info.name, '\n', '       ', 'Type: ' info.type ]);
        disp(formated);
        clear formated info
    end
end

