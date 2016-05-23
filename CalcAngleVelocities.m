
%% Better version
% diffVelo = diff(matrix) * 0.01

function angleVelocities = CalcAngleVelocities( matrixContainingOrientationData )
%CALCANGLEVELOCITIES Summary of this function goes here
%   Detailed explanation goes here

 [length dim] = size(matrixContainingOrientationData);
 angleVelocities = zeros(dim, length - 1);
 last = zeros(dim, 1);
 i = 0;
 tp =  matrixContainingOrientationData';
 for col = tp
   i = i + 1;
   angleVelocities(:,i) = quat2eul(col')' - last;
 end

end

