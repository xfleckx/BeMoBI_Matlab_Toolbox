%% Load EEGLAB
eeglab 

%% Load MoBILAB
mobilab

%% load
allStreams = dataSourceXDF( 'testData\the_first_mobivr_pilot_MoBI');

%% Export the eeg and data stream to eeglab - the ID's are magic numbers 
%   coming from the xdf stream indicies
mobilab.allStreams.export2eeglab(1,7);

%% Plot angle velocities of body orientation
bodyOrientation = mobilab.allStreams.item{4}
absDiffVelo = abs(diff(bodyOrientation.data) * 0.01);
figure;
plot(absDiffVelo);

%% get Data stream after loading it through MoBILab
markerStream = EEG.event;
%%

requestedEventsForLeftTurns = GrabEventsByLabel(markerStream, {'LEFT'});
requestedEventsForStraightTurns = GrabEventsByLabel(markerStream, {'STRAIGHT'});
%% 
requestedEventsForObjectShown = GrabEventsByLabel(markerStream, {'ObjectFound'});

%% estimated sizes of Limits
epochLimits = [-1.5 0.2];

[epochsForLeftTurns,     indicesLeftTurns] = pop_epoch(EEG, requestedEventsForLeftTurns, epochLimits);
[epochsForStraightTurns, indicesStraightTurns] = pop_epoch(EEG, requestedEventsForStraightTurns, epochLimits);

%% Get the epochs 
objectShownEpochLimits = [-1 2];
[epochsForObjectShown, indicesObjectShown] = pop_epoch(EEG, requestedEventsForObjectShown, objectShownEpochLimits);

%% check the
pop_timtopo(epochsForObjectShown, [-1 2]);

%% try to average the ERP over all channels

%  not working
% epochsForObjectShown.data = mean(epochsForObjectShown.data);
% pop_timtopo(epochsForObjectShown, [-1 2]);

%%
%plot(erp);
%%
%pop_comperp(epochsForObjectShown,'chans', 10);

%% 
%figure; 
%topoplot(epochsForLeftTurns,EEG.chanlocs, 'style', 'blank', 'electrodes', 'labelpoint');
%pop_eegplot( 

