clc
clear all
close all

t=0:0.01:1;
th=91+1800*t.^3-2700*t.^4+1080*t.^5;
thp=5400*t.^2-10800*t.^3+5400*t.^4;
thpp=10800*t-32400*t.^2+21600*t.^3;

figure('Name','Posición, Velocidad y Aceleración Angular');...
	subplot(3,1,1), plot(t,th),title('Posición'),xlabel('Tiempo (s)'),...
	ylabel('Posición (deg)'),grid; subplot(3,1,2),plot(t,thp),...
	title('Velocidad'),xlabel('Tiempo (s)'),ylabel('Velocidad (deg/s)'),grid;...
	subplot(3,1,3),plot(t,thpp), title('Aceleración'),xlabel('Tiempo (s)'),...
	ylabel('Aceleración (deg/s^2)'),grid;