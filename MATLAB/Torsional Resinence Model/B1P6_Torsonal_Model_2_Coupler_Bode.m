% Torsonal Model Constants (two couplers) Bode
% Book 1 Page 7 for Model
% Book 1 Page 6 for system equations
% Name: Daniel M. Lofaro
% Date: 2006-12-01
clf
s = zpk('s');
[AA,BB,CC,DD]=linmod('B1P6_Torsonal_Model_2_Coupler_TF_Ouput'); % get the transfer funtion of the simulink who has that file name 
ssm=ss(AA,BB,CC,DD);            % get transfer to state space model
TFM=tf(ssm);                    % put ss model to transfer funciton
bode(TFM);                      % find step funcion of system
shg
grid on