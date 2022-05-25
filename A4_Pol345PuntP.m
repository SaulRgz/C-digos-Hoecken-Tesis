clc
clear all
close all

th1=0;
L1=20; L2=10; L3=50/2; L4=25;i=0;            %Declaramos las longitudes

%Ecuaciones obtenidas perfil polinomial (empleando ciclo for e if)
for t=0:0.01:2 %Considerando 91° en t=0,180°+91° en t=1s,360°+91° en t=2s 
    i=i+1;
    if t<=1 %****Se evaluó en con theta inicial 91° y final 271°
    ti(:,i)=t;
    th(:,i)=(91+1800*t.^3-2700*t.^4+1080*t.^5)*(pi/180); %**almacenamos en una misma variable para toda la trayectoria
    thp(:,i)=(5400*t.^2-10800*t.^3+5400*t.^4)*(pi/180); %**almacenamos en una misma variable para toda la velicidad
    thpp(:,i)=(10800*t-32400*t.^2+21600*t.^3)*(pi/180); %***almacenamos en una misma variable para toda la aceleración
    else %****Se evaluó en con theta inicial 271° y final 451°
    ti(:,i)=t;
    th(:,i)=(-5309+21600*t-32400*t^2+23400*t^3-8100*t^4+1080*t^5)*(pi/180); %***almacenamos en una misma variable para toda la trayectoria
    thp(:,i)=(21600-32400*2*t+23400*3*t^2-8100*4*t^3+1080*5*t^4)*(pi/180); %***almacenamos en una misma variable para toda la velicidad
    thpp(:,i)=(-32400*2+23400*3*2*t-8100*4*3*t^2+1080*5*4*t^3)*(pi/180); %***almacenamos en una misma variable para toda la aceleración
    end
 %**Resolviendo posición para th
        e=sqrt((L1^2)+(L2^2)-2*L1*L2*cos(th(i)));
        alfa=acos(((L3^2)+(e^2)-(L4^2))/(2*L3*e));
        miu=acos(((e^2)+(L1^2)-(L2^2))/(2*L1*e));
        beta=acos(((e^2)+(L4^2)-(L3^2))/(2*e*L4));
        gamma=acos(((L3^2)+(L4^2)-(e^2))/(2*L3*L4));
        if th(i)<=pi
        th2=alfa-miu;
        th3=pi-miu-beta;
        elseif th(i)<=2*pi 
        th2=alfa+miu;
        th3=pi+miu-beta;
        else 
        th2=alfa-miu;
        th3=pi-miu-beta;
        end          
        Px(:,i)=L2*cos(th(i))+2*L3*cos(th2);
        Py(:,i)=(L2*sin(th(i))+2*L3*sin(th2));
  %***Resolviendo para velocidad 
        thp2=((L2*(sind(th(i))*cos(th3) - cos(th(i))*sin(th3)))/...
        (L3*(cos(th2)*sin(th3)-cos(th3)*sin(th2))))*thp(i);
        thp3=((L2*(sin(th(i))*cos(th2) - cos(th(i))*sin(th2)))/...
        (L4*(cos(th2)*sin(th3)-cos(th3)*sin(th2))))*thp(i);
         %Velocidad del punto de interés
        Vpx=-L2*sin(th(i))*thp(i)-2*L3*sin(th2)*thp2;
        Vpy=L2*cos(th(i))*thp(i)+2*L3*cos(th2)*thp2;
        Vp(:,i)=sqrt((Vpx*Vpx)+(Vpy*Vpy)); %Resusltante de Vpx y Vpy
  %***Resolviendo para aceleración 
        thpp2= ( L2*( cos(th(i))*cos(th3) + sin(th(i))*sin(th3) )*(thp(i)*thp(i)) + ...
                 L3*( cos(th2)*cos(th3) + sin(th2)*sin(th3) )*( thp2*thp2 ) - ...
                 L2*( sin(th3)*cos(th(i))-sin(th(i))*cos(th3) )*(thpp(i)) - ...
                 L4*(thp3*thp3) ) / ( L3*( sin(th3)*cos(th2) - sin(th2)*cos(th3) ) ) ;
        thpp3= ( L2*( cos(th(i))*cos(th2) + sin(th(i))*sin(th2) )*( thp(i)*thp(i) ) - ...
                 L2*( cos(th(i))*sin(th2) - sin(th(i))*cos(th2) )*( thpp(i) ) - ...
                 L4*( sin(th2)*sin(th3) + cos(th2)*cos(th3) )*( thp3*thp3 ) + ...
                 L3*( thp2*thp2 ) ) / ( L4*( sin(th3)*cos(th2) - cos(th3)*sin(th2) ) )  ;
      %Aceleración del punto de Interés
        Apx = -L2*( sin(th(i))*thpp(i) + cos(th(i))*( thp(i)*thp(i) ) ) - ...
               2*L3*( sin(th2)*thpp2 + cos(th2)*( thp2*thp2 ) );
        Apy =  L2*( cos(th(i))*thpp(i) - sin(th(i))*( thp(i)*thp(i) ) ) + ...
               2*L3*( cos(th2)*thpp2 - sin(th2)*( thp2*thp2 ) ) ;
        Ap(:,i) = sqrt( (Apx*Apx) + (Apy*Apy) ) ;  
end
%Graficamos el perfil polinomial
figure('Name','Posición, Velocidad y Aceleración Angular');
    subplot(3,1,1), plot(ti,th),title('Posición'),xlabel('Tiempo (s)'),ylabel('Posición (deg)'),grid;
    subplot(3,1,2),plot(ti,thp),title('Velocidad'),xlabel('Tiempo (s)'),ylabel('Velocidad (deg/s)'),grid;
    subplot(3,1,3),plot(ti,thpp),title('Aceleración'),xlabel('Tiempo (s)'),ylabel('Aceleración (deg/s^2)'),grid;
figure('Name','Posición, Velocidad y Aceleración lineal');
    subplot(3,1,1),plot(Px,Py),title('Posición Punto de Interés'),xlabel('x (mm)'),ylabel('y (mm)'),grid;
    subplot(3,1,2),plot(ti,Vp),title('Velocidad Punto de Interés'),xlabel('Tiempo (s)'),ylabel('Velocidad (mm/s)'),grid;
    subplot(3,1,3),plot(ti,Ap),title('Aceleración Punto de Interés'),xlabel('Tiempo (s)'),ylabel('Aceleración (mm/s^2)'),grid;
