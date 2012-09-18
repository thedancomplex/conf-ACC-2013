
wrange = {10^1,10^3};
Ka = 10;
kv = 20;
ki =0.2;

Ra = 0.38;
L = 0.842;
Ke = 0.042685;
Kt = 6.046;

[AA,BB,CC,DD]=linmod('RizzoRezEq1'); % get the transfer funtion of the simulink who has that file name 
ssm=ss(AA,BB,CC,DD);            % get transfer to state space model
TFM=tf(ssm);                    % put ss model to transfer funciton
bode(TFM,'r', wrange);                      % find step funcion of system
%end