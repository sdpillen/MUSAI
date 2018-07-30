function markers = module_read_neurone_events(basePath, samplingRate)
%MODULE_READ_NEURONE_EVENTS   Read events from NeurOne file format.
%
%  Version 1.1.3.10 (2015-11-10)
%  See version_history.txt for details.
%
%  Inputs
%         basePath     : Path to directory containing NeurOne data files
%                        from one measurement.
%         samplingRate : Sampling frequency of the measurement to
%                        calculate occurence times of events.
%
%  Output
%         markers      : A structure containing event types, data indices
%                        and occurence times.
%
%  Dependencies: none
%
%  Module_read_neurone_events is part of NeurOne Tools for Matlab.
%
%  The NeurOne Tools for Matlab consists of the functions:
%       module_read_neurone.m, module_read_neurone_data.m,
%       module_read_neurone_events.m, module_read_neurone_xml.m
%
%  ========================================================================
%  COPYRIGHT NOTICE
%  ========================================================================
%  Copyright 2009 - 2015
%  Andreas Henelius (andreas.henelius@ttl.fi)
%  Finnish Institute of Occupational Health (http://www.ttl.fi/)
%  and
%  Mega Electronics Ltd (mega@megaemg.com, http://www.megaemg.com)
%  ========================================================================
%  This file is part of NeurOne Tools for Matlab.
%
%  NeurOne Tools for Matlab is free software: you can redistribute it
%  and/or modify it under the terms of the GNU General Public License as
%  published by the Free Software Foundation, either version 3 of the
%  License, or (at your option) any later version.
%
%  NeurOne Tools for Matlab is distributed in the hope that it will be
%  useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
%  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%  GNU General Public License for more details.
%
%  You should have received a copy of the GNU General Public License
%  along with NeurOne Tools for Matlab.
%  If not, see <http://www.gnu.org/licenses/>.
%  ========================================================================

%% Events are stored in three files:
% (1) events.bin
% (2) eventData.bin
% (3) eventDescriptions.bin

% Define files
EVENTSFILE            = [basePath filesep 'events.bin'];
EVENTDATAFILE         = [basePath filesep 'eventData.bin'];
EVENTDESCRIPTIONSFILE = [basePath filesep 'eventDescriptions.bin'];

%% Read events.bin
% Each event is stored in an 88-byte struct, so we read the data in
% chunks of 88 bytes.

% Get number of events
tmp = dir(EVENTSFILE);
nEvents = tmp.bytes / 88;

% Empty structure for event data
markers.type = cell(nEvents, 1);
markers.port = cell(nEvents, 1);
markers.index = NaN(nEvents, 1);
markers.time = NaN(nEvents, 1);
markers.mainUnitIndex = NaN(nEvents, 1);
markers.timeStampMicro = NaN(nEvents, 1);
markers.inputNumber = NaN(nEvents, 1);

% Read events.bin
% RFU (Reserved for Future Use) are not used in this version of the reader.
fileIdEvents = fopen(EVENTSFILE, 'rb');
for k = 1:nEvents
    % Read the whole event structure
    Revision = fread(fileIdEvents,1,'int32');
    RFU = fread(fileIdEvents,1,'int32');
    Type = fread(fileIdEvents,1,'int32');
    SourcePort = fread(fileIdEvents,1,'int32');
    
    % Number of the input bound to the event. Zero means all inputs.
    InputNumber = fread(fileIdEvents,1,'int32');

    % Value of an 8-bit trigger
    Code = fread(fileIdEvents,1,'int32');
    
    StartSampleIndex = fread(fileIdEvents,1,'uint64');    
    StopSampleIndex = fread(fileIdEvents,1,'uint64');

    % Location and size of event description
    DescriptionLength = fread(fileIdEvents,1,'uint64');
    DescriptionOffset = fread(fileIdEvents,1,'uint64');

    % Location and size of event data (e.g. comment text)
    DataLength = fread(fileIdEvents,1,'uint64');
    DataOffset = fread(fileIdEvents,1,'uint64');
    
    % Time stamp of the event in microsecond precision, calculated
    % from the beginning of the measurement
    TimeStamp = fread(fileIdEvents,1,'double');

    % Index of the NeurOne Main Unit that generated the Event.
    % If using a SyncBox system with several main units, the index is:
    %   -1: Unknown
    %    0: Master Main Unit
    %    1: Slave Main Unit 1 ...
    % If using a standalone system (one main unit), index is always zero.
    MainUnitIndex = fread(fileIdEvents,1,'int32');
    RFU = fread(fileIdEvents,1,'int32');
    
    % Check if the data format has changed
    if Revision > 5
        warning(strcat('This reader does not support the revision of events.bin (', ...
            num2str(Revision), '). Please contact mega@megaemg.com for an update.'))
    end
    
    % Determine the source port
    switch SourcePort
        case 0
            SourcePort = 'N/A';
        case 1
            SourcePort = 'A';
        case 2
            SourcePort = 'B';
        case 3
            SourcePort = 'EightBit';
        case 4
            SourcePort = 'Syncbox Button';
        case 5
            SourcePort = 'SyncBox EXT';
        case 6
            % The name of the software component that generated the
            % event is read from eventDescriptions.bin.
            
            % Read the description, if it's available
            if (DescriptionLength > 0)
                fileIdEventDesc = fopen(EVENTDESCRIPTIONSFILE,'rb');
                component = fread(fileIdEventDesc,[1 DescriptionOffset/2],'int16');
                component = fread(fileIdEventDesc,[1 DescriptionLength/2],'int16');
                fclose(fileIdEventDesc);
                SourcePort = ['Software (' char(component) ')'];
            else
                SourcePort = 'Software';
            end
        otherwise
            SourcePort = 'Unknown';
    end
    
    % Determine the type of the event
    switch Type
        case 0
            Type = 'N/A';
        case 1
            Type = 'Stimulation';
        case 2
            Type = 'Video';
        case 3
            Type = 'Mute';
        case 4
            Type = num2str(Code);
        case 5
            Type = 'Out';
        case 6
            % User-entered comments will be read from file eventData.bin
            fileIdEventData = fopen(EVENTDATAFILE,'rb');
            comments = fread(fileIdEventData,[1 DataOffset/2],'int16');
            comments = fread(fileIdEventData,[1 DataLength/2],'int16');
            Type = char(comments);
            fclose(fileIdEventData);
        case 7
            % Start of single response
            Type = 'RS Start';
        case 8
            % End of single response
            Type = 'RS End';
        case 9
            % Start of average response
            Type = 'RA Start';
        case 10
            % End of average response
            Type = 'RA End';
        case 100
            Type = 'MEP';
        case 2147483638
            % Start of response data buffer
            Type = 'RD Start';
        case 2147483639
            % End of response data buffer
            Type = 'RD End';
        otherwise
            Type = 'Unknown';
    end
    
    % Store the obtained data
    markers.type(k,1) = cellstr(Type);
    markers.port(k,1) = cellstr(SourcePort);
    markers.index(k,1) = StartSampleIndex;
    markers.time(k,1) = StartSampleIndex/samplingRate;
    markers.mainUnitIndex(k,1) = MainUnitIndex;
    markers.timeStampMicro(k,1) = TimeStamp;
    markers.inputNumber(k,1) = InputNumber;
    
end
fclose(fileIdEvents);

end