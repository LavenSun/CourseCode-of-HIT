t = -20:0.1:20;
A = atan(t);
A1 = diff(A, 1);
A2 = diff(A, 2);
subplot(2, 3, 1);
plot(t, A);
title('方位角变化曲线');
xlabel('t(a=b=1)');
ylabel('方位角');
grid on;
subplot(2, 3, 2);
plot( -20:0.1:19.9, A1);
title('方位角速度变化曲线');
xlabel('t(a=b=1)');
ylabel('方位角速度');
grid on;
subplot(2, 3, 3);
plot( -19.9:0.1:19.9, A2);
title('方位角加速度变化曲线');
xlabel('t(a=b=1)');
ylabel('方位角加速度');
grid on;
%fft计算过程
subplot(2, 3, 4);
Fs = 1000;
Ts=1/Fs;						% Sampling Time
f=50;							% Frequence of Signal
N=256;							% Length of Signal
t1=(0:N-1)*Ts;
b = atan(t1);
NFFT=2^nextpow2(N);				% Next power of 2 from length of x.
B=fft(b,NFFT);  
BB = abs(B);
f=(0:N-1)/(N*Ts);
plot(f, BB);
grid on;
%结束
subplot(2, 3, 5);
Fs = 50;
Ts=1/Fs;						% Sampling Time
f=50;							% Frequence of Signal
N=256;							% Length of Signal
t1=(0:N-1)*Ts;
b = atan(t1);
b1 = diff(b, 1);
NFFT=2^nextpow2(N);				% Next power of 2 from length of x.
B1=fft(b1,NFFT);  
BB1 = abs(B1);
f=(0:N-1)/(N*Ts);
plot(f, BB1);
grid on;
subplot(2, 3, 6);
Fs = 50;
Ts=1/Fs;						% Sampling Time
f=50;							% Frequence of Signal
N=256;							% Length of Signal
t1=(0:N-1)*Ts;
b = atan(t1);
b2 = diff(b, 2);
NFFT=2^nextpow2(N);				% Next power of 2 from length of x.
B2=fft(b2,NFFT);  
BB2 = abs(B2);
f=(0:N-1)/(N*Ts);
plot(f, BB2);
grid on;