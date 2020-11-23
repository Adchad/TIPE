for i = 1:100 
    [LeftSignal,FrontLeftSignal,CenterLeftSignal, ...
    CenterRightSignal,FrontRightSignal,RightSignal]   = AllLightSensorsReadRoomba(serPort);

    disp([LeftSignal,FrontLeftSignal,CenterLeftSignal, ...
    CenterRightSignal,FrontRightSignal,RightSignal])
end

t1=clock;
AllLightSensorsReadRoomba(serPort);
t2 = t1-clock;
disp(t2)