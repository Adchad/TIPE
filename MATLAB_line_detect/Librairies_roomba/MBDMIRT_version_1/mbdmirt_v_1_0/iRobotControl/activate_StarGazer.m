function activate_StarGazer(irobotID, StarGazerComPortNum)
%[] = activate_StarGazer(irobotID, StarGazerComPortNum)
% activate_StarGazer initializes a SIIG RS-232 Serial to Bluetooth Adapter
%   that is connected with a StarGazer indoor localization system. This
%   function also establish the relation between the StarGazer and the
%   iRobot carrying it, such that the MBDMIRT toolbox can read the
%   StarGazer simply through the iRobot's ideal ID number
%
% irobotID is the desired ideal ID for the iRobot Create carrying the
%   StarGazer
%
% StarGazerComPortNum is the COM port connected to the SIIG RS-232 Serial
%   to Bluetooth Adapter installed with the StarGazer
%
% Shih-Kai 9/22/2012 with code from
% MATLAB Serial Communication Tutorial by Esposito

% COM_num = varargin{2};
% irobotID = varargin{3};

port = strcat('COM', num2str(StarGazerComPortNum));

% Check if THAT serial port is already defined in MATLAB
out = instrfind('Port', port);

if (~isempty(out))  % It is defined
    disp('WARNING:  port in use.  Closing.')
    if (~strcmp(get(out(1), 'Status'),'open'))  % Is it open?
        delete(out(1)); % If not, delete
    else  % is open
        fclose(out(1));
        delete(out(1));
    end
end

OLS_name = strcat('OLSonRobot_', num2str(irobotID));
% Define serial port
serOLS = serial(port,...
    'BaudRate', 115200,...
    'DataBits', 8,...
    'StopBits', 1,...
    'Parity', 'none',...
    'FlowControl', 'none',...
    'Tag', 'StarGazer',...
    'UserData', OLS_name,...
    'Timeout', 0.1,...
    'InputBufferSize', 512,...
    'Terminator', '`');

% Open it
fopen(serOLS);

% Give it a second to start getting data
pause(1)
% varargout{1} = serOLS;
% Assign the established StarGazer Serial Object to MATLAB base workspace
%   for the MBDMIRT toolbox use
stargazerObjStr = sprintf('OLSonRobot_%d', irobotID);
assignin('base', stargazerObjStr, serOLS);

fprintf('StarGazer on iRobot_%d initialized\n', irobotID)
