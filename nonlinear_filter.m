clear all;
close all;
clc;

filename='saghi1.wav'
[y,Fs] = audioread(filename);

filename='saghi1_noise.wav'
[y_n,Fs] = audioread(filename);

y_n=y_n';
y_x=y';

y_f=y_n;



mx_yf=max(y_f);

f=[0 0.2  1];
m=[1 0.1  0];
n=128;

b=fir2(n,f,m);
a=[1,zeros(1,length(b)-1)];

y_n=filter(b,a,y_n);

Y_n=fft(y_n);
Y_n=Y_n.^1.16;
y_n=real(ifft(Y_n));

f=[0 0.2  1];
m=[1 0.1  0];
n=128;
b=fir2(n,f,m);

a=[1,zeros(1,length(b)-1)];
y_n=filter(b,a,y_n);

Y_n=fft(y_n);
Y_n=Y_n.^1.1;
y_n=real(ifft(Y_n));
n=filter(b,a,y_n);

mx_yn=max(y_n);

Y_n=fft(y_n);
Y_n=Y_n.^0.95;
y_n=real(ifft(Y_n));

y_n=y_n*mx_yf/mx_yn;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mx=mean(y_n);
my=mean(y_x);

varx=mean((y_x-mx).^2);
vary=mean((y_n-my).^2);


covxy=mean(abs((y_x-mx).*(y_n-my)));

g=covxy/sqrt(varx*vary);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y_n=3*y_n;
sound(y_n,Fs);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
y_n=y_n';
name=sprintf('nonlinear_filter_output_g_%3.2f.wav',g);
audiowrite(name,y_n,Fs);
