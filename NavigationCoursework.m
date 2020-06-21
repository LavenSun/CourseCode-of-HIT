%��֪����
k=20;%��̬��������n
T=0.04;%��TΪ0.04s
K=187925;%����ʱ��6000s
R=6371000;%����뾶
We=7.292e-5;%������ת���ٶ�
%��ʼ���������͵������
Q=zeros(4,187926);%����任��Ԫ������
Longitude=zeros(1,187926);%���峤��Ϊ6000�ľ�������
Latitude=zeros(1,187926);%���峤��Ϊ6000��γ������
H=zeros(1,187926);%���峤��Ϊ5400�ĸ߶�����
Q(:,1)=[-cos(12.5/180*pi);0;0;sin(12.5/180*pi)];%��ʼ����Ԫ�����ɱ�ƫ��-25�ȼ���ã����ǹ���ϵ�������
Longitude(1)=118.05;%��ʼ������
Latitude(1)=24.27;%��ʼ��γ��
H(1)=120;%��ʼ���߶�
g=zeros(1,187926);
g(1)=9.780327;
%g=9.780327;
%�����ٶȾ���
Ve=zeros(1,187926);%�����ٶ�
Vn=zeros(1,187926);%�����ٶ�
Vu=zeros(1,187926);%�����ٶ�
Ve(1)=0;%��ʼ�ٶ�Ϊ0
Vn(1)=0;
Vu(1)=0;
%������ٶȾ���
FE=zeros(1,187926);%������ٶ�
FN=zeros(1,187926);%������ٶ�
FU=zeros(1,187926);%������ٶ�
load HB2020.mat;%���������ļ�
for N=1:K%��ʼλ�á��ٶȵ���
    g(N+1)=g(1)*(1+0.0053024*sin(Latitude(N)/180*pi)^2-0.0000058*sin(2*Latitude(N)/180*pi)^2)-0.000003086*H(N);
    %q1=zeros(4,187926);
    q1(:,1)=Q(:,N);
    for n=1:k%��ʼ��̬����
        WX=((0.01/3600)/180*pi)*GMM((N-1)*10+n,1);%0.01���뻻��ɻ����ƽ��е���
        WY=((0.01/3600)/180*pi)*GMM((N-1)*10+n,2);
        WZ=((0.01/3600)/180*pi)*GMM((N-1)*10+n,3);
        %�����Ԫ����΢�ַ���
        w=[WX,WY,WZ];
        normw=norm(w);
        W=[0,-w(1),-w(2),-w(3);%����������ǶȾ�����������ƱϿ���
           w(1),0,w(3),-w(2);
           w(2),-w(3),0,w(1);
           w(3),w(2),-w(1),0];
       I=eye(4);
       S=1/2-normw^2/48;
       C=1-normw^2/8+normw^4/384;
       q1(:,n+1)=(C*I+S*W)*q1(:,n);%�Ľ׽��ƱϿ���
    end
    Q(:,N+1)=q1(:,n+1);
    WE=-Vn(N)/R;%��������ϵת�����ٶȷ���������������̬
    WN=Ve(N)/R+We*cos(Latitude(N)/180*pi);
    WH=Ve(N)/R*tan(Latitude(N)/180*pi)+We*sin(Latitude(N)/180*pi);
    gama=[WE,WN,WH]'*T;%��������ϵ��ת����Ԫ��
    normgama=norm(gama);
    QG=[cos(normgama/2);sin(normgama/2)*n];
    Q1=quml(qiuni(QG),Q(:,N+1));
    Q(:,N+1)=Q1(1);
    FX=1e-6*g(N)*AMM(N*1,1); %���ٶȼƲ�õı���
    FY=1e-6*g(N)*AMM(N*1,2); 
    FZ=1e-6*g(N)*AMM(N*1,3);
    Fb=[FX FY FZ]';
%����������������ϵ�ֽ⵽��������ϵ
    F=quml(Q(:,N+1),quml([0;Fb],qiuni(Q(:,N+1))));
    FE(N)=F(2);
    FN(N)=F(3);
    FU(N)=F(4);
%����������Ե�������ϵ�ļ��ٶ�
    VED(N)=FE(N)+Ve(N)*Vn(N)/R*tan(Latitude(N)/180*pi)-(Ve(N)/R+2*We*cos(Latitude(N)/180*pi))*Vu(N)+2*Vn(N)*We*sin(Latitude(N)/180*pi) ;
    VND(N)=FN(N)-2*Ve(N)*We*sin(Latitude(N)/180*pi)-Ve(N)*Ve(N)/R*tan(Latitude(N)/180*pi)-Vn(N)*Vu(N)/R;
    VUD(N)=FU(N)+2*Ve(N)*We*cos(Latitude(N)/180*pi)+(Ve(N)^2+Vn(N)^2)/R-g(N);
%�������������ٶ�
    Ve(N+1)=VED(N)*T+Ve(N);
    Vn(N+1)=VND(N)*T+Vn(N);
    Vu(N+1)=VUD(N)*T+Vu(N);
%����ƽ���ٶȼ��������λ��
    Longitude(N+1)=0.5*(Ve(N)+Ve(N+1))/R*cos(Latitude(N)/180*pi)*T/pi*180+Longitude(N);
    Latitude(N+1)=0.5*(Vn(N)+Vn(N+1))/R*T/pi*180+Latitude(N);
    H(N+1)=0.5*(Vu(N)+Vu(N+1))*T+H(N);
end
%��ͼ
%����ս�����ľ���γ�ȱ仯���ߣ��Ծ���Ϊ���ᣩ
figure(1)
hold on
grid on
plot(Longitude,Latitude,'LineWidth',2);
xlabel('����');
ylabel('γ��');
title('��γ�ȹ켣');
%����ս�����ĸ߶ȱ仯����
figure(2)
hold on
grid on
plot([0:187925],H,'LineWidth',2);
xlabel('ʱ��');
ylabel('�߶�');
title('�߶ȱ仯');
%���
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
str8='total horizontal distance��';
fprintf(1,'%s\n',str8);
%����ս�����ܹ����й�����
DIS=0;%��ʼ����Ϊ��
for a=1:187925%����ʱ��
DIS=DIS+(((Ve(a))^2+(0+Vn(a))^2+(Vu(a))^2)^0.5*1);%�����������ٶ�ƽ����������ϳ��ٶ������ʱ����˵õ�����ʱ���ڷ��о���
end
DIS=DIS+(((Ve(187925))^2+(0+Vn(187925))^2+(Vu(187925))^2)^0.5*1);%��ÿ�β���ʱ���ڵľ�����͵õ��������
load E.mat;
E(:,1)=E(:,1)*180/pi;
E(:,2)=E(:,2)*180/pi;
E(:,3)=E(:,3)*180/pi;
figure(3);
subplot(3,1,1);
plot(E(:,1));
xlabel('ʱ��');
ylabel('pitch');
subplot(3,1,2);
plot(E(:,2));
xlabel('ʱ��');
ylabel('head');
subplot(3,1,3);
plot(E(:,3));
xlabel('ʱ��');
ylabel('roll');
HPRatt=E;
LonM=Longitude;
LatM=Latitude;
HtM=H;
save FlightData HPRatt LonM LatM HtM
