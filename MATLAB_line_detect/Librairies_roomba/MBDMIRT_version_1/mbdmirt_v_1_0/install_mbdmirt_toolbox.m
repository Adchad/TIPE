function install_mbdmirt_toolbox()
% This function will install the MBDMIRT toolbox on the PC.
%   It sets the path to MBDMIRT folder into the MATLAB search path.
%

path_mbdmirt = pwd;
path_mbdmirt_irobotSimulation = strcat(path_mbdmirt, '\iRobotSimulation');
path_mbdmirt_irobotControl = strcat(path_mbdmirt, '\iRobotControl');
path_mbdmirt_mapConfig = strcat(path_mbdmirt, '\map_config_example');
path_mbdmirt_sfExample = strcat(path_mbdmirt, '\sf_example');

addpath(path_mbdmirt_irobotSimulation)
addpath(path_mbdmirt_irobotControl)
addpath(path_mbdmirt_mapConfig)
addpath(path_mbdmirt_sfExample)
