clc
clear all
close all

filename='saghi1.wav'
[y,Fs] = audioread(filename);

filename='saghi1_noise.wav'
[y_n,Fs] = audioread(filename);



y_n=y_n';
y_x=y';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

y_s_1=y_n;
h1=fft(y_s_1);
th_h1=max(abs(h1))*0.005;
fnd=find(abs(h1)<th_h1);
h1(fnd)=0;
h1=(h1.*1.2)/4;
y_s_1=ifft(h1);
y_s_1=real(y_s_1);


mu = 0.08;            
ha = adaptfilt.lms(16,mu);
[x,e]=filter(ha,y_s_1,y_n);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mx=mean(y_x);
my=mean(x);

varx=mean((y_x-mx).^2);
vary=mean((x-my).^2);


covxy=mean(abs((y_x-mx).*(x-my)));

g=covxy/sqrt(varx*vary);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

sound(x,Fs)

x=x';
name=sprintf('nonlinear_adaptive_filter_output_g_%1.4f.wav',g);
audiowrite(name,x,Fs);