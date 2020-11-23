function [LeftSignal,FrontLeftSignal,CenterLeftSignal, ...
    CenterRightSignal,FrontRightSignal,RightSignal] = LightBumpSignalStrengthRoomba(serPort)
%[Signal] = LightBumpCenterLeftSignalStrengthRoomba(serPort)
%Displays the strength of the left light sensor's signal.
%Ranges between 0-4095



% By; J Didier,2016
% Adapted from Joel Esposito, US Naval Academy, 2011

%Initialize preliminary return values
LeftSignal = nan;
FrontLeftSignal = nan;
CenterLeftSignal = nan;
CenterRightSignal = nan;
FrontRightSignal = nan;
RightSignal = nan;



try

%Flush Buffer    
N = serPort.BytesAvailable();
while(N~=0) 
fread(serPort,N);
N = serPort.BytesAvailable();
end

warning off
global td

fwrite(serPort, [142]);  fwrite(serPort,46);
LeftSignal =  fread(serPort, 1, 'uint16');
% pause(td)
fwrite(serPort, [142]);  fwrite(serPort,47);
FrontLeftSignal =  fread(serPort, 1, 'uint16');
% pause(td)
fwrite(serPort, [142]);  fwrite(serPort,48);
CenterLeftSignal =  fread(serPort, 1, 'uint16');
% pause(td)
fwrite(serPort, [142]);  fwrite(serPort,49);
CenterRightSignal =  fread(serPort, 1, 'uint16');
% pause(td)
fwrite(serPort, [142]);  fwrite(serPort,50);
FrontRightSignal =  fread(serPort, 1, 'uint16');
% pause(td)
fwrite(serPort, [142]);  fwrite(serPort,51);
RightSignal =  fread(serPort, 1, 'uint16');
% pause(td)



catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end