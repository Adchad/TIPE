function delete_iRobot_serObj
%[] = delete_iRobot_serObj
% delete_iRobot_serObj deletes all the iRobot serial object existent in
%   MATLAB base workspace. This function is intended to work with the
%   MBDMIRT toolbox and do necessary housecleaning after the toolbox is
%   closed.
%
% by Shih-Kai Su, ASU, 2012

expression = ['instrfind(''Tag'', ''Roomba'')'];
allRoomba = evalin('base', expression);
roombaQty = length(allRoomba);
for i=1:roombaQty
    expression1 = sprintf('delete(iRobot_%d)', i);
    expression2 = sprintf('clear iRobot_%d', i);
    evalin('base', expression1)
    evalin('base', expression2)
end