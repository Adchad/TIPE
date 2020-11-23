function [LeftSignal,FrontLeftSignal,CenterLeftSignal, ...
    CenterRightSignal,FrontRightSignal,RightSignal]   = AllLightSensorsReadRoomba(serPort);
%[LeftSignal,FrontLeftSignal,CenterLeftSignal, ...
%    CenterRightSignal,FrontRightSignal,RightSignal]   = AllSensorsReadRoomba(serPort)
% Reads Roomba Sensors
% [BumpRight (0/1), BumpLeft(0/1), BumpFront(0/1), Wall(0/1), virtWall(0/1), CliffLft(0/1), ...
%    CliffRgt(0/1), CliffFrntLft(0/1), CliffFrntRgt(0/1), LeftCurrOver (0/1), RightCurrOver(0/1), ...
%    DirtL(0/1), DirtR(0/1), ButtonPlay(0/1), ButtonAdv(0/1), Dist (meters since last call), Angle (rad since last call), ...
%    Volts (V), Current (Amps), Temp (celcius), Charge (milliamphours), Capacity (milliamphours), pCharge (percent)]
% Can add others if you like, see code
% Esposito 3/2008
% initialize preliminary return values
% By; J Didier 2016
LeftSignal = nan;
FrontLeftSignal = nan;
CenterLeftSignal = nan;
CenterRightSignal = nan;
FrontRightSignal = nan;
RightSignal = nan;


try

%Flush buffer
N = serPort.BytesAvailable();
while(N~=0) 
fread(serPort,N);
N = serPort.BytesAvailable();
end

warning off
global td
sensorPacket = [];
% flushing buffer
confirmation = (fread(serPort,1));
while ~isempty(confirmation)
    confirmation = (fread(serPort,26));
end


%% Get (142) ALL(0) data fields
fwrite(serPort, [142 106]);

%% Read data fields
LeftSignal =  fread(serPort, 1, 'uint16');
FrontLeftSignal =  fread(serPort, 1, 'uint16');
CenterLeftSignal =  fread(serPort, 1, 'uint16');
CenterRightSignal =  fread(serPort, 1, 'uint16');
FrontRightSignal =  fread(serPort, 1, 'uint16');
RightSignal =  fread(serPort, 1, 'uint16');
% pause(td)

%checksum =  fread(serPort, 1)

pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end