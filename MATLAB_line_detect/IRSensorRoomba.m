function [IRomni,IRleft,IRright] = IRSensorRoomba(serPort);
%[ButtonAdv,ButtonPlay] = ButtonsSensorRoomba(serPort)
%Displays the state of Create's Play and Advance buttons, either pressed or
%not pressed.

%initialize preliminary return values
ButtonAdv = nan;
ButtonPlay = nan;

% By; Joel Esposito, US Naval Academy, 2011
try
    
%Flush Buffer    
N = serPort.BytesAvailable();
while(N~=0) 
fread(serPort,N);
N = serPort.BytesAvailable();
end

warning off
global td


fwrite(serPort, [142]);  fwrite(serPort,17);
IRomni = fread(serPort, 1);
% disp(IRomni)
pause(td)
fwrite(serPort, [142]);  fwrite(serPort,52);
IRleft = fread(serPort, 1);
% disp(IRleft)
pause(td)
fwrite(serPort, [142]);  fwrite(serPort,53);
IRright = fread(serPort, 1);
% disp(IRright)
pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end