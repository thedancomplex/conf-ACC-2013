% Torsonal Model Constants from V. Rizzo(one coupler)
% Book 1 Page 15 for Model
% Name: Daniel M. Lofaro
% Date: 2007-01-21


Ke = 10;                % BEMF
Ka = 10;                % amplifyer
R = 10;                 % armature resistance
Kt = 10;                % torque constant
Jm = 0.0023;            % motor inertia
JL = 0.0033;            % load inertia
Wr = 100;               % resinence (rad/s)
War = 95;               % anti resinence (rad/s)

F = (s^2/Wr^2+b/K*s+1)/(s^2/War^2+b/K*s+1);
                        % peeking factor

Ms = 1/((Jm+JL)*s*F);    % resonant load
Kr = 10;                % Tachemeter