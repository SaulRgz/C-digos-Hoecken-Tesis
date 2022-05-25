close all
clear all
clc
r1=100; r2=35 ;r3=125 ;r4=125; BP =125;
A = [0,0];
D = [r1,0];
axis(gca,'equal');
axis([-100,300,-300,200]);
w2=(2*pi)/3;
for t=1:500;

 theta2=w2*(t/50);

 %Valores de ángulos
 rac=sqrt(r1.^2+r2.^2-(2*r1*r2*cos(theta2)));
 thetae = asin((-r2*sin(theta2))/(rac));
 theta4 = (-acos((r3.^2-rac.^2-r4.^2)/(2*rac*r4))+ thetae);
 theta3 = asin((r4*sin(theta4)-r2*sin(theta2))/r3);

 %Posiciones de las juntas
 B = [r1+(r4*cos(theta4))-(r3*cos(theta3)),(r4*sin(theta4))-(r3*sin(theta3))];
 C = [r1+(r4*cos(theta4)),r4*sin(theta4)];
 P = [r1+(r4*cos(theta4))+(BP*cos(theta3)),r4*sin(theta4)+(BP*sin(theta3))];
 %Creación de eslabones

l2_line=line([A(1),B(1)],[A(2),B(2)],'LineWidth',2,'Color','k');
l3_line=line([B(1),C(1)],[B(2),C(2)],'LineWidth',2,'Color','k');
l4_line=line([C(1),D(1)],[C(2),D(2)],'LineWidth',2,'Color','k');
l5_line=line([C(1),P(1)],[C(2),P(2)],'LineWidth',2,'Color','k');

 %Trayectoria
p_traj=viscircles(P,0.1,'Color','k'); 


pause(0.001);
 delete(l2_line);
 delete(l3_line);
 delete(l4_line);
 delete(l5_line);

end

