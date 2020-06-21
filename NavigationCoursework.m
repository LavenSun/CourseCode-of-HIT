%已知参数
k=20;%姿态迭代次数n
T=0.04;%△T为0.04s
K=187925;%导航时间6000s
R=6371000;%地球半径
We=7.292e-5;%地球自转角速度
%初始导航参数和地球参数
Q=zeros(4,187926);%定义变换四元数矩阵
Longitude=zeros(1,187926);%定义长度为6000的经度数组
Latitude=zeros(1,187926);%定义长度为6000的纬度数组
H=zeros(1,187926);%定义长度为5400的高度数组
Q(:,1)=[-cos(12.5/180*pi);0;0;sin(12.5/180*pi)];%初始化四元数，由北偏东-25度计算得，且是惯性系相对载体
Longitude(1)=118.05;%初始化经度
Latitude(1)=24.27;%初始化纬度
H(1)=120;%初始化高度
g=zeros(1,187926);
g(1)=9.780327;
%g=9.780327;
%定义速度矩阵
Ve=zeros(1,187926);%东向速度
Vn=zeros(1,187926);%北向速度
Vu=zeros(1,187926);%天向速度
Ve(1)=0;%初始速度为0
Vn(1)=0;
Vu(1)=0;
%定义加速度矩阵
FE=zeros(1,187926);%东向加速度
FN=zeros(1,187926);%北向加速度
FU=zeros(1,187926);%天向加速度
load HB2020.mat;%载入数据文件
for N=1:K%开始位置、速度迭代
    g(N+1)=g(1)*(1+0.0053024*sin(Latitude(N)/180*pi)^2-0.0000058*sin(2*Latitude(N)/180*pi)^2)-0.000003086*H(N);
    %q1=zeros(4,187926);
    q1(:,1)=Q(:,N);
    for n=1:k%开始姿态迭代
        WX=((0.01/3600)/180*pi)*GMM((N-1)*10+n,1);%0.01角秒换算成弧度制进行迭代
        WY=((0.01/3600)/180*pi)*GMM((N-1)*10+n,2);
        WZ=((0.01/3600)/180*pi)*GMM((N-1)*10+n,3);
        %求解四元数的微分方程
        w=[WX,WY,WZ];
        normw=norm(w);
        W=[0,-w(1),-w(2),-w(3);%陀螺仪输出角度矩阵，用来求近似毕卡解
           w(1),0,w(3),-w(2);
           w(2),-w(3),0,w(1);
           w(3),w(2),-w(1),0];
       I=eye(4);
       S=1/2-normw^2/48;
       C=1-normw^2/8+normw^4/384;
       q1(:,n+1)=(C*I+S*W)*q1(:,n);%四阶近似毕卡解
    end
    Q(:,N+1)=q1(:,n+1);
    WE=-Vn(N)/R;%地理坐标系转动角速度分量，用来修正姿态
    WN=Ve(N)/R+We*cos(Latitude(N)/180*pi);
    WH=Ve(N)/R*tan(Latitude(N)/180*pi)+We*sin(Latitude(N)/180*pi);
    gama=[WE,WN,WH]'*T;%地理坐标系的转动四元数
    normgama=norm(gama);
    QG=[cos(normgama/2);sin(normgama/2)*n];
    Q1=quml(qiuni(QG),Q(:,N+1));
    Q(:,N+1)=Q1(1);
    FX=1e-6*g(N)*AMM(N*1,1); %加速度计测得的比力
    FY=1e-6*g(N)*AMM(N*1,2); 
    FZ=1e-6*g(N)*AMM(N*1,3);
    Fb=[FX FY FZ]';
%将比力从载体坐标系分解到地理坐标系
    F=quml(Q(:,N+1),quml([0;Fb],qiuni(Q(:,N+1))));
    FE(N)=F(2);
    FN(N)=F(3);
    FU(N)=F(4);
%计算载体相对地理坐标系的加速度
    VED(N)=FE(N)+Ve(N)*Vn(N)/R*tan(Latitude(N)/180*pi)-(Ve(N)/R+2*We*cos(Latitude(N)/180*pi))*Vu(N)+2*Vn(N)*We*sin(Latitude(N)/180*pi) ;
    VND(N)=FN(N)-2*Ve(N)*We*sin(Latitude(N)/180*pi)-Ve(N)*Ve(N)/R*tan(Latitude(N)/180*pi)-Vn(N)*Vu(N)/R;
    VUD(N)=FU(N)+2*Ve(N)*We*cos(Latitude(N)/180*pi)+(Ve(N)^2+Vn(N)^2)/R-g(N);
%计算载体的相对速度
    Ve(N+1)=VED(N)*T+Ve(N);
    Vn(N+1)=VND(N)*T+Vn(N);
    Vu(N+1)=VUD(N)*T+Vu(N);
%利用平均速度计算载体的位置
    Longitude(N+1)=0.5*(Ve(N)+Ve(N+1))/R*cos(Latitude(N)/180*pi)*T/pi*180+Longitude(N);
    Latitude(N+1)=0.5*(Vn(N)+Vn(N+1))/R*T/pi*180+Latitude(N);
    H(N+1)=0.5*(Vu(N)+Vu(N+1))*T+H(N);
end
%画图
%绘制战斗机的经、纬度变化曲线（以经度为横轴）
figure(1)
hold on
grid on
plot(Longitude,Latitude,'LineWidth',2);
xlabel('经度');
ylabel('纬度');
title('经纬度轨迹');
%绘制战斗机的高度变化曲线
figure(2)
hold on
grid on
plot([0:187925],H,'LineWidth',2);
xlabel('时间');
ylabel('高度');
title('高度变化');
%输出
str1='final longitude:';
fprintf(1,'%s%f\n',str1,Longitude(187926));
str2='final latitude:';
fprintf(1,'%s%f\n',str2,Latitude(187926));
str3='final height:';
fprintf(1,'%s%f\n',str3,H(187926));
str4='final velocity of east:';
fprintf(1,'%s%f\n',str4,Ve(187926));
str5='final velocity of north:';
fprintf(1,'%s%f\n',str5,Vn(187926));
str6='final velocity of vertical:';
fprintf(1,'%s%f\n',str6,Vu(187926));
str7='final attitude quaternion:';
fprintf(1,'%s\n',str7);
QQ=Q(:,187925);
str8='total horizontal distance：';
fprintf(1,'%s\n',str8);
%计算战斗机总共飞行过距离
DIS=0;%初始距离为零
for a=1:187925%总体时间
DIS=DIS+(((Ve(a))^2+(0+Vn(a))^2+(Vu(a))^2)^0.5*1);%对三个方向速度平方开根号求合成速度与采样时间相乘得到采样时间内飞行距离
end
DIS=DIS+(((Ve(187925))^2+(0+Vn(187925))^2+(Vu(187925))^2)^0.5*1);%对每段采样时间内的距离求和得到总体距离
load E.mat;
E(:,1)=E(:,1)*180/pi;
E(:,2)=E(:,2)*180/pi;
E(:,3)=E(:,3)*180/pi;
figure(3);
subplot(3,1,1);
plot(E(:,1));
xlabel('时间');
ylabel('pitch');
subplot(3,1,2);
plot(E(:,2));
xlabel('时间');
ylabel('head');
subplot(3,1,3);
plot(E(:,3));
xlabel('时间');
ylabel('roll');
HPRatt=E;
LonM=Longitude;
LatM=Latitude;
HtM=H;
save FlightData HPRatt LonM LatM HtM
