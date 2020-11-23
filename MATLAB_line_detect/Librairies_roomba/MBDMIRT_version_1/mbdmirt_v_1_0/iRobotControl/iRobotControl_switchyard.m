function varargout = iRobotControl_switchyard(varargin)
%% SWITCHYARD - iRobotControl_switchyard(varargin)
% Install this callback by invoking it with the command
% iRobotControl_switchyard('init_model', modelName)
% at the MATLAB prompt with the appropriate model file open and selected.
%

global offset_landmark

action = varargin{1};

switch action
    case 'init_model'
    %% SWITCHYARD CASE - init_model
        % Model initialization function, located in this M-file
        init_fcn(varargin{2});
        
    case 'setup_StarGazer_landmark_offset_table'
    %% SWITCHYARD CASE - setup_StarGazer_landmark_offset_table
        
    % offset_landmark(row,:) = [landmarkID, x_offset, y_offset, th_offset]
    %
    % x_offset and y_offset are in centi-meters
    % th_offset is in degrees
    
        offset_landmark(1,:)  = [10546, -326,  545, 0.01];
        offset_landmark(2,:)  = [10576, -317,  300, -3.1];
        offset_landmark(3,:)  = [10678, -250,   75, -1.4];
        offset_landmark(4,:)  = [10578, -430,  -72, -2.1];
        offset_landmark(5,:)  = [10594, -243, -174, -2.1];
        offset_landmark(6,:)  = [10674,   -3, -245, -0.5];
        offset_landmark(7,:)  = [10596,    0,    0,    0];
        offset_landmark(8,:)  = [10640, -5.9,  242, -1.7];
        offset_landmark(9,:)  = [10610, -8.9,  488, -2.6];
        offset_landmark(10,:) = [10642,  181,  490, -2.1];
        offset_landmark(11,:) = [10608,  199,  243, -1.1];
        offset_landmark(12,:) = [10676,  203, -0.4,   -2];
        offset_landmark(13,:) = [10566,  205, -248, -1.4];
        
    case 'setup_localPCclock'
    %% SWITCHYARD CASE - setup_localPCclock
        sys = gcs;
        path_subsys_localpcclock = [sys '/subsys_localpcclock'];
        path_dsmem_localPcInitTime = [path_subsys_localpcclock '/dsmem_localPcInitTime'];
        
        % Read the initial local PC clock time
        current_time = iRobotControl_switchyard('local_pc_clock');
        
        % Write the initial local PC clock time into dsmem_localPcInitTime, such
        %   that the elapsed clock can be calculated
        set_param(path_dsmem_localPcInitTime, 'InitialValue', num2str(current_time))
        
    case 'local_pc_clock'
    %% SWITCHYARD CASE - local_pc_clock
        % c = clock;
        % [year month day hour minute seconds]
        %              |    |     |      |
        %             c(3) c(4)  c(5)   c(6)
        
        % T=fix(clock);
        T=clock;
        % output the elapsed local PC clock in seconds
        varargout{1}=T(3)*86400+T(4)*60*60+T(5)*60+T(6);
        
    case 'OverheadLocalizationCreate'
    %% SWITCHYARD CASE - OverheadLocalizationCreate
    % This case reads the message from the HAGISONIC StarGazer
    %
    % varargin{2} is the ID of the iRobot carrying the StarGazer
    % varargout{1} is the coordinate message [x,y,angle]
    % x and y are in meters; angle is in radians
    %
        irobotID = varargin{2};
        
        % Check if the iRobot with IROBOTID carries a overhead localization
        %   system (OLS)
        OLS_name = strcat('OLSonRobot_', num2str(irobotID));
        OLS_found = instrfind('UserData', OLS_name);
        
        if (~isempty(OLS_found))
            % The iRobot with IROBOTID carries an (OLS).
            
            % Clear the buffer for the serial object
            readSerOLS(OLS_found);
            % Read the output from the OLS
            message = readSerOLS(OLS_found);
            while ~strcmp(message(1),'~') || ...
                    ~strcmp(message(2),'^') || ...
                    ~strcmp(message(end),'`')
                message = readSerOLS(OLS_found);
            end
            data = sscanf(message, '~^I%g|%g|%g|%g|%g');
            landmark_id = data(1)
            
            % Check whether the captured landmark is an existent one
            for i = 1:length(offset_landmark)
                if offset_landmark(i,1) == landmark_id
                    % Landmark is found; it is not due to noise.
                    
                    % Do the convesion of global coordinates
                    x     = data(3) + offset_landmark(i, 2);
                    y     = data(4) + offset_landmark(i, 3);
                    angle = data(2) + offset_landmark(i, 4);
                    varargout{1} = x/100;   % output in meters
                    varargout{2} = y/100;   % output in meters
                    varargout{3} = angle*-1*pi/180; % output in radians
                    return
                end
            end
            
            % Due to noise, the captured landmark is a non-existent one,
            %   read StarGazer again
            
            % Clear the buffer for the serial object
            readSerOLS(OLS_found);
            % Read the output from the OLS
            message = readSerOLS(OLS_found);
            while ~strcmp(message(1),'~') || ...
                    ~strcmp(message(2),'^') || ...
                    ~strcmp(message(end),'`')
                message = readSerOLS(OLS_found);
            end
            data = sscanf(message, '~^I%g|%g|%g|%g|%g');
            landmark_id = data(1)
            
            % Check whether the captured landmark is an existent one
            for i = 1:length(offset_landmark)
                if offset_landmark(i,1) == landmark_id
                    % Landmark is found; it is not due to noise.
                    
                    % Do the convesion of global coordinates
                    x     = data(3) + offset_landmark(i, 2);
                    y     = data(4) + offset_landmark(i, 3);
                    angle = data(2) + offset_landmark(i, 4);
                    varargout{1} = x/100;   % output in meters
                    varargout{2} = y/100;   % output in meters
                    varargout{3} = angle*-1*pi/180; % output in radians
                    return
                end
            end
            
            % Due to the failure to read StarGazer
            %   output default readings
            varargout{1} = 10^12;     % output x
            varargout{2} = 10^12;     % output y
            varargout{3} = 10^12;     % output angle
            
        else
            % The iRobot with IROBOTID does not carry an OLS
            varargout{1} = 10^12;     % output x
            varargout{2} = 10^12;     % output y
            varargout{3} = 10^12;     % output angle
            fprintf('iRobot_%d does not have a overhead localization system\n',...
                irobotID)
        end
        
    case 'close_iRobotControl'
    %% SWITCHYARD CASE - close_iRobotControl
        clear global offset_landmark
%         delete_iRobot_serObj;
%         delete_StarGazer_serObj;
        
    otherwise
    %% SWITCHYARD CASE - otherwise
        error_message = ['Unrecongnized case in ', mfilename, '.m'];
        error(error_message);
end


function init_fcn(modelName)
%% BLK CB - init_fcn
% Configure the model callbacks
% This function should be executed once when the block is created
% to define the callbacks. After it is executed, save the model
% and the callback definitions will be saved with the model. There is no need
% to reinstall the callbacks when the block is copied; they are part of the
% block once the model is saved.
%
cbFcn_1 = strcat(mfilename, '(''setup_localPCclock'')');
cbFcn_2 = strcat(mfilename, '(''setup_StarGazer_landmark_offset_table'')');
initFcnStr = strcat(cbFcn_1, ';', cbFcn_2);
set_param(modelName,'InitFcn', initFcnStr);
set_param(modelName,'CloseFcn', [mfilename, ' close_iRobotControl']);


function msg = readSerOLS(serOLS)
%% readSerOLS
% This function is used to read the message a speicfied HAGISONIC StarGazer
%   or clear the buffer for the serial object, SEROLS
%
% SEROLS is the seiral object estabished for the StarGazer
% MSG is the coordinate message [x,y,angle]
%
N = serOLS.BytesAvailable;
while N ~= 0
	fread(serOLS,N);
	N = serOLS.BytesAvailable;
end
msg = fscanf(serOLS);

