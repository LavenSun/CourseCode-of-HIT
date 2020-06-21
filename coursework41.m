Fs = 10;
Ts=1/Fs;						
f=10;							
N=128;					
t1=(0:N-1)*Ts;
f1 = exp(-0.1*abs(t1));
NFFT=2^nextpow2(N);			
F1=fft(f1,NFFT);  
FF1 = abs(F1);
f=(0:N-1)/(N*Ts);
figure(1);
plot(f, FF1);
xlabel('��Ƶ��');
ylabel('���ܶ�');
grid on;
w = 0:0.01:10;
f2 = (pi*w).^(-1);
figure(2);
plot(w,f2);
xlabel('��Ƶ��');
ylabel('���ܶ�');
grid on;
figure(3);
w = 0:0.01:10;
ff = pi^(-1)*0.1*(w.*w+0.01).^(-1);
plot(w,ff);
xlabel('��Ƶ��');
ylabel('���ܶ�');
grid on;