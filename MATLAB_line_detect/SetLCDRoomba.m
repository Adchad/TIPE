function [] = SetLCDRoomba(serPort,D3,D2,D1,D0)
%

try
    
%Flush Buffer    
N = serPort.BytesAvailable();
while(N~=0) 
fread(serPort,N);
N = serPort.BytesAvailable();
end

warning off
global td


fwrite(serPort, [164]); fwrite(serPort, D3);fwrite(serPort, D2);fwrite(serPort, D1);fwrite(serPort, D0);
disp('LCD Changing')
pause(td)
catch
    disp('WARNING:  function did not terminate correctly.  Output may be unreliable.')
end
