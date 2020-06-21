t = -20:0.001:20;
F = 10*exp(-2*t);
F1 = diff(F, 1);
F2 = diff(F, 2);
subplot(2, 3, 1);
plot(t, F);
title('力矩函数变化曲线');
xlabel('t');
ylabel('力矩');
grid on;
subplot(2, 3, 2);
plot( -20:0.001:19.999, F1);
title('一阶导数变化曲线');
xlabel('t');
ylabel('一阶导数幅值');
grid on;
subplot(2, 3, 3);
plot( -19.999:0.001:19.999, F2);
title('二阶导数变化曲线');
xlabel('t');
ylabel('二阶导数幅值');
grid on;
subplot(2, 3, 4);
a = real(fft(F));
plot(t, a);
grid on;
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
title('力矩频域变化曲线');
xlabel('f/Hz');
ylabel('力矩幅值');
grid on;
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
title('一阶导数频域变化曲线');
xlabel('f/Hz');
ylabel('一阶导数幅值');
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
title('二阶导数频域变化曲线');
xlabel('f/Hz');
ylabel('二阶导数幅值');
grid on;

