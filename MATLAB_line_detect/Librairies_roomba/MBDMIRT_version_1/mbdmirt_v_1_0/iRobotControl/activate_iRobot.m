function activate_iRobot(irobotID, BAMcomPortNum)
%[] = activate_iRobot(irobotID, BAMcomPortNum)
% activate_iRobot initializes an iRobot Create and assigns it with an ideal
% ID number. RoombaInit in the MTIC toolbox is called internally.
%
% irobotID is the desired ideal ID for the iRobot Create
%
% BAMcomPortNum is the COM port connected to the BAM installed on the
%   iRobot
%
% by Shih-Kai Su, ASU, 2012

% Initialize the iRobot
irobotSerObj = RoombaInit(BAMcomPortNum);

% Assign the established iRobot Serial Object to MATLAB base workspace for
%   the MBDMIRT toolbox use
irobotObjStr = sprintf('iRobot_%d', irobotID);
assignin('base', irobotObjStr, irobotSerObj);