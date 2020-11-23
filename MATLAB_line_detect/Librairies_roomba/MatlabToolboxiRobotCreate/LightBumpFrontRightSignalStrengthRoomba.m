function [Signal] = LightBumpFrontRightSignalStrengthRoomba(serPort)
%[Signal] = LightBumpFrontLeftSignalStrengthRoomba(serPort)
%Displays the strength of the left light sensor's signal.
%Ranges between 0-4095



% By; J Didier,2016
% Adapted from Joel Esposito, US Naval Academy, 2011

%Initialize preliminary return values
Signal = nan;

try

%Flush Buffer    
N = serPort.BytesAvailable();
while(N~=0) 
fread(serPort,N);
N = serPort.BytesAvailable();
end

warning off
global td
fwrite(serPort, [142]);  fwrite(serPort,50);

Signal =  fread(serPort, 1, 'uint16');

pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end