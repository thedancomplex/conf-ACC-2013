% Daniel Lofaro
% TR ss and tf compair confirm
% 2008-04-14

clear all
close all

s = tf('s')

Ja = 0.0023         % actuator inertia
JL = 0.0033         % Load inertia

Kc = 55             % spring constant of the coupler

Ba = 0              % damping of actuator, assummed to be zero
Bc = 0.005           % damping of the coupler
BL = 0              % damping of the load, assummed to be zero

flag = 6            % 1 = get tf
                    % 2 = get state space
                    % 3 = simulation tf
                    % 4 = load difference bode plot
                    % 5 = compare ss, tf, and sim
                    % 6 = plot tf and Rizzo
flag_bode = 0       % print bode for flag = 1

if flag == 1


    Gtf = (s^2/Ja+s*(Bc+BL)/(Ja*JL)+Kc/(Ja*JL))/(s^4+((BL+Bc)*Ja+(Bc+Ba)*JL)*s^3/(Ja*JL)+((Ba+Bc)*(BL+Bc)+Kc*JL-Bc^2)*s^2/(Ja*JL)+(((Ba+Bc)+(Bc+BL))*Kc-2*Bc)*s/(Ja*JL))
    Gtf2 = (s^2*JL+s*BL+Kc+s*Bc)/(s*(s^3*Ja*JL+s^2*Ja*BL+s*Ja*Bc+s^2*Ba*JL+s*Ba*BL+Ba*Kc+s*Ba*Bc+Kc*s*JL+Kc*BL+s^2*Bc*JL+s*Bc*BL)*Ja*JL)
    Gtf3 = (s^2/Ja+(Bc+BL)*s/(Ja*JL)+Kc/(Ja+JL))/(s^4+((Ba+Bc)*JL+(Bc+BL)*Ja)*s^3/(Ja*JL)+(-Kc*JL+Kc*Ja-Bc^2)*s^2/(Ja*JL)+(-(Bc+BL)*Kc+(Ba+Bc)*Kc-2*Kc*Bc)*s/(Ja*JL)+(-2*Kc^2)/(Ja*JL))
    Gtf4 = (JL*s^2+(Bc+BL)*s+Kc)/((JL*s^2+(Bc+BL)*s+Kc)*(Ja*s^2+(Ba*Bc)*s-Kc)-(Kc*Bc*s)^2)
    Gtf5 = (s^2*JL+s*BL+Kc+s*Bc)/(s^4*Ja*JL+(Ja*BL+Ba*JL+Bc*Ja+Bc*JL)*s^3+(Kc*Ja+Ba*BL+Bc*Ba+Kc*JL+Bc*BL)*s^2+(Kc*Ba+Kc*BL)*s)
    Gtf6 = (s^2*JL+s*BL+Kc+s*Bc)/(Ja*JL)/(s^4+(Ja*BL+Ba*JL+Bc*Ja+Bc*JL)*s^3/(Ja*JL)+(Kc*Ja+Ba*BL+Bc*Ba+Kc*JL+Bc*BL)*s^2/(Ja*JL)+(Kc*Ba+Kc*BL)*s/(Ja*JL))
    Gtf6 = (s^2*JL+Kc+s*Bc)/(Ja*JL)/(s^4+(Bc*Ja+Bc*JL)*s^3/(Ja*JL)+(Kc*Ja+Kc*JL)*s^2/(Ja*JL))
    Gtf6 = (s^2*JL+Kc+s*Bc)/(Ja*JL)/(s^2*(s^2+(Bc*Ja+Bc*JL)*s/(Ja*JL)+(Kc*Ja+Kc*JL)/(Ja*JL)))
    Gtf7 = (s^2*JL+Kc+s*Bc)/(Ja*JL)/(s^2*(s^2+(Bc*Ja+Bc*JL)*s/(Ja*JL)+(Kc*Ja+Kc*JL)/(Ja*JL)))

elseif flag == 2

    A = [ -(Ba+Bc)/Ja, -Kc/Ja, Bc/Ja, Kc/Ja;
        1, 0 , 0, 0;
        Bc/JL, Kc/JL, -(Bc+BL)/JL, -Kc/JL;
        0 , 0 , 1 , 0 ]

    B = [ 1/Ja ; 0 ; 0 ; 0 ]
    C = [ 0 1 0 0 ]
    D = 0

    Gss = ss(A,B,C,D)
elseif flag ==3
    [aa bb cc dd] = linmod('TR_Single_Coupler_For_Subsystem',1,1)
    [num, den] = ss2tf(aa, bb, cc, dd, 1)
    Gsim = minreal(tf(num(1,:),den))
elseif flag == 4
    Gtf7 = (s^2*JL+Kc+s*Bc)/(Ja*JL)/(s^2*(s^2+(Bc*Ja+Bc*JL)*s/(Ja*JL)+(Kc*Ja+Kc*JL)/(Ja*JL)))
    temp1 = Kc
    temp2 = Bc
    JLtemp = JL
    Jatemp = Ja
    Kc = 0
    Bc = 0
    Ga = (s^2*JL+Kc+s*Bc)/(Ja*JL)/(s^2*(s^2+(Bc*Ja+Bc*JL)*s/(Ja*JL)+(Kc*Ja+Kc*JL)/(Ja*JL)))
    Ja = Ja+JL
    GaL = (s^2*JL+Kc+s*Bc)/(Ja*JL)/(s^2*(s^2+(Bc*Ja+Bc*JL)*s/(Ja*JL)+(Kc*Ja+Kc*JL)/(Ja*JL)))
    bode(Gtf7)
    hold on
    bode(Ga)
    bode(GaL)
    legend('TR System','Only Ja','JL+Ja')
elseif flag == 5
    Gtf7 = (s^2*JL+Kc+s*Bc)/(Ja*JL)/(s^2*(s^2+(Bc*Ja+Bc*JL)*s/(Ja*JL)+(Kc*Ja+Kc*JL)/(Ja*JL)))
    [aa bb cc dd] = linmod('TR_Single_Coupler_For_Subsystem',1,1)
    [num, den] = ss2tf(aa, bb, cc, dd, 1)
    Gsim = minreal(tf(num(1,:),den))
        A = [ -(Ba+Bc)/Ja, -Kc/Ja, Bc/Ja, Kc/Ja;
        1, 0 , 0, 0;
        Bc/JL, Kc/JL, -(Bc+BL)/JL, -Kc/JL;
        0 , 0 , 1 , 0 ]

    B = [ 1/Ja ; 0 ; 0 ; 0 ]
    C = [ 0 1 0 0 ]
    D = 0
    bode(Gtf7)
    hold on
    bode(ss(A,B,C,D))
    bode(Gsim)
    legend('Transfer Funciton','State Space','Simulink')
elseif flag == 6
    Gtf7 = (s^2*JL+Kc+s*Bc)/(Ja*JL)/(s^2*(s^2+(Bc*Ja+Bc*JL)*s/(Ja*JL)+(Kc*Ja+Kc*JL)/(Ja*JL)))
    wrange = {10^1,10^3};
    bode(Gtf7,wrange)
    
    hold on
   
    
    
    
    %% Rizzo
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
    bode(TFM/s,'r',wrange);                      % find step funcion of system
    
     
    %% change paramaters
   
    
    axis([10^1, 10^3, -190, 10]);
    legend('System with TR','System with RE')
    title('Bode Diagram of System with TR and with RE');
     h = gcf;
    set(findall(h,'type','text'),'fontSize',14,'fontWeight','bold')
end
    

if flag_bode == 1
    % bode(Gss)
    hold on
    % bode(Gtf)
    % bode(Gtf2)
    % bode(Gtf3)
    % bode(Gtf4)
    % bode(Gtf5)
    % bode(Gtf6)
    bode(Gtf7)
end

    % legend('Gss','Gtf','Gtf2','Gtf3','Gtf4','Gtf5','Gtf6','Gtf7')

    % 
ccpole = -(Bc*Ja+Bc*JL)/(2*Ja*JL)+i/2*sqrt(4*(Kc*Ja+Kc*JL)/(Ja*JL)-((Bc*Ja+Bc*JL)/(Ja*JL))^2)
    % 
    % War = sqrt(Kc/JL)           % anti resonance frequency as calculated by rizzo