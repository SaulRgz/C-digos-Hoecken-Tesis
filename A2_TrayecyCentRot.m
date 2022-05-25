%Se buscara seguir la trayectoria recta que se genera en el mecanismo de 4
%barras Hoecken
%Saúl Efrén Rodríguez Canchola  OCTUBRE/2019

clear
clc
th1=0; th2=0; th3=0;                       %Iniciamos los ángulos en cero
L1=20; L2=10; L3=50/2; L4=25;              %Declaramos las longitudes
Px=zeros(360,1); Py=zeros(360,1);          %Inicializamos Vectores
XC1=zeros(60,1); YC1=zeros(60,1);          %Arreglos de valores de posicion para angulos de 0 a 60
XC2=zeros(60,1); YC2=zeros(60,1);          %Arreglos de valores de posicion para angulos de 300 a 360
Xcr=zeros(60,1); Ycr=zeros(60,1);          % XcrLR=zeros(60,1); YcrLR=zeros(60,1); 

for i=1:181
        th1=i-1;
        
        e=     sqrt((L1*L1)+(L2*L2)-2*L1*L2*cosd(th1));
        alfa=  acosd(((L3*L3)+(e*e)-(L4*L4))/(2*L3*e));
        miu=   acosd(((e*e)+(L1*L1)-(L2*L2))/(2*L1*e));
        beta=  acosd(((e*e)+(L4*L4)-(L3*L3))/(2*e*L4));
        gamma= acosd(((L3*L3)+(L4*L4)-(e*e))/(2*L3*L4));
        
        th2=alfa-miu;
        th3=180-miu-beta;
        
        Px(i)=  L2*cosd(th1)+2*L3*cosd(th2);
        Py(i)=  (L2*sind(th1)+2*L3*sind(th2));
        
end    %Ciclo for para th1 de 0° a 180°

for i=182:361
        th1=i-1;
        
        e=      sqrt((L1*L1)+(L2*L2)-2*L1*L2*cosd(th1));
        alfa=   acosd(((L3*L3)+(e*e)-(L4*L4))/(2*L3*e));
        miu=    acosd(((e*e)+(L1*L1)-(L2*L2))/(2*L1*e));
        beta=   acosd(((e*e)+(L4*L4)-(L3*L3))/(2*e*L4));
        gamma=  acosd(((L3*L3)+(L4*L4)-(e*e))/(2*L3*L4));
        
        th2=alfa+miu;
        th3=180+miu-beta;
        
        Px(i)=  L2*cosd(th1)+2*L3*cosd(th2);
        Py(i)=  (L2*sind(th1)+2*L3*sind(th2));
        
end  %Ciclo for para th1 de 181° a 360°

P=[Px Py];        %Se guardan los valores de Px y Py en un vector para ambos
plot(Px,Py);      %Graficamos Px con Py
hold on
grid on 
xlabel("x (mm)");
ylabel("y (mm)");
% Para escribir en .txt
% fid = fopen('Posiciones.txt','w');
% fprintf(fid,'%6s %12s\r\n','x','y');
% fprintf(fid,'%6.2f %12.8f\r\n',P);
% fclose(fid);
% 
X2=Px(1); Y2=Py(1);
j=1;
for i=2:61
    XC1(j)=Px(i);
    YC1(j)=Py(i);
    j=j+1;
end
j=1;
for i=360:-1:301
    XC2(j)=Px(i);
    YC2(j)=Py(i);
    j=j+1;
end

j=1;
for i=1:60
    X1=XC2(i); X3=XC1(i); 
    Y1=YC2(i); Y3=YC1(i);
    
     M12=(Y2-Y1)/(X2-X1);
     M23=(Y2-Y3)/(X2-X3);
     PmX12=(X2+X1)/2;
     PmX23=(X2+X3)/2;
     PmY23=(Y2+Y3)/2;
     PmY12=(Y1+Y2)/2;
     Mp12=(-1/M12);
     Mp23=(-1/M23);
    
    Xcr(j)= ((Mp23*PmX23)-(Mp12*PmX12)-PmY23+PmY12)/(Mp23-Mp12);
    Ycr(j)= Mp23*(Xcr(j)-PmX23)+PmY23;
     j=j+1;
end

CR=[Xcr, Ycr];
plot(Xcr,Ycr);
% Q1=[5;5;35;35]; Q2=[40;45;45;40]; plot(Q1,Q2);
% Q3=[10;10;30;30]; Q4=[40;46;46;40]; plot(Q3,Q4);
% Q5=[15;15;25;25]; Q6=[40;47;47;40]; plot(Q5,Q6);
% 
