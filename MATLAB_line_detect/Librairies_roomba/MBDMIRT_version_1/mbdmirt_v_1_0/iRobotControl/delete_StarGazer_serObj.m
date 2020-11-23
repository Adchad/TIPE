function delete_StarGazer_serObj
%[] = delete_StarGazer_serObj
% delete_StarGazer_serObj deletes all the StarGazer serial object existent
%   in MATLAB base workspace. This function is intended to work with the
%   MBDMIRT toolbox and do necessary housecleaning after the toolbox is
%   closed.
%
% by Shih-Kai Su, ASU, 2012

expression = ['instrfind(''Tag'', ''StarGazer'')'];
allStarGazer = evalin('base', expression);

StarGazerQty = length(allStarGazer);
for i=1:StarGazerQty
    expression1 = sprintf('fclose(OLSonRobot_%d)', i);
    expression2 = sprintf('delete(OLSonRobot_%d)', i);
    expression3 = sprintf('clear OLSonRobot_%d', i);
    evalin('base', expression1)
    evalin('base', expression2)
    evalin('base', expression3)
end