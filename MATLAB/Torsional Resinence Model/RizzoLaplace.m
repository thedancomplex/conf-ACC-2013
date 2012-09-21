clear all 
close all

s = tf('s');
g = (2.122e6*s^2 + 4.73e6*s+5.203e10)/(s^5+455*s^4+1.744e6*s^3+1.852e7*s^2+2.221e9*s);

bode(g)