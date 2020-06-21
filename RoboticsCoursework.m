%{0}相对于C的矩阵
T1=[1,0,0,-0.4;
    0,-1,0,0.4;
    0,0,-1,1;
    0,0,0,1];
%A和A0之间的变换
%沿z轴平移
t1=transl(0,0,-0.2);
%绕y轴旋转
r1=troty(pi);
%A0相对于C的位姿
T2=[0,1,0,0.15;
    1,0,0,0.2;
    0,0,-1,0.95;
    0,0,0,1];
%B和B0之间的变换
%沿z轴平移
t2=transl(0,0,-0.2);
%绕y轴旋转
r2=troty(-pi/2);
%B0相对于C的位姿
T3=[0,1,0,0.3;
    1,0,0,-0.3;
    0,0,-1,0.9;
    0,0,0,1];
%钻头在PA点时{6}相对于{0}的位姿
T21=inv(T1)*T2*r1*t1;
%钻头在PB点时{6}相对于{0}的位姿
T31=inv(T1)*T3*r2*t2;
%轨迹求解
mdl_puma560;
t=0:0.05:2;
q0=p560.ikine6s(T21);
qf=p560.ikine6s(T31);
%笛卡尔空间轨迹规划
Ts1=ctraj(T21,T31,length(t));
q1=p560.ikine6s(Ts1);
figure(1);
%teach(p560,q1);
plot(t,q1);
title('笛卡尔空间轨迹规划');
grid on;
%关节空间轨迹规划
[q2,q2d,q2dd]=jtraj(q0,qf,t);
figure(2);
%teach(p560,q2);
plot(t,q2,'LineWidth',2);
title('关节空间轨迹规划');
grid on;
%效果比较
T=p560.fkine(q2);
p1=transl(T);
p2=transl(Ts1);
figure(3);
plot(p1(:,1),p1(:,2));
title('效果比较1');
grid on;
figure(4);
plot(p2(:,1),p2(:,2));
title('效果比较2');
grid on;

