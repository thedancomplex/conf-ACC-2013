% Torsonal Model Constants (one coupler) Bode
% Book 1 Page 4 for Model
% Book 1 Page 3 for system equations
% Name: Daniel M. Lofaro
% Date: 2006-12-01
clf
close all
clear all
TFconfirm

%% motor paramaters
Ra = 0.38;
L = 0.842;
Ke = 0.042685;
Kt = 6.046;

hold on
PlotRizzo


figure

s = zpk('s');
[AA,BB,CC,DD]=linmod('TRwithMotor'); % get the transfer funtion of the simulink who has that file name 
ssm=ss(AA,BB,CC,DD);            % get transfer to state space model
TFM=tf(ssm);                    % put ss model to transfer funciton
bode(TFM);                      % find step funcion of system
shg
grid on
axis([10e1, 10e3, -360, 360]);


figure 
hold on

%for( i=.01:0.2:10 )
Ka = 10;
kv = 20;
ki = 0.02;
[AA,BB,CC,DD]=linmod('RizzoRezEq1'); % get the transfer funtion of the simulink who has that file name 
ssm=ss(AA,BB,CC,DD);            % get transfer to state space model
TFM=tf(ssm);                    % put ss model to transfer funciton
bode(TFM, {10^1,10^3});                      % find step funcion of system
axis([10^1, 10^3, -120, -70]);
%end
shg
grid on
%axis([10e1, 10e3, -360, 360]);


% % figure
% % 
% % 
% % s = tf('s');
% % num = [ 6.244e8, 9.461e8, 1.041e16 ];
% % dom = [ 1, 217.5, 6.261e7, 1.035e8, 1.043e12];
% % g = tf(num,dom);
% % 
% % bode(g)
% % axis([10e1, 10e3, -360, 360]);