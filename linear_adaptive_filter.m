clc
clear all
close all



filename='saghi1.wav'
y = audioread(filename);

filename='saghi1_noise.wav'
[y_n,Fs] = audioread(filename);

l=floor(length(y)/4);
y=y(1:l,1);
y_n=y_n(1:l,1);

y_n=y_n';
y_x=y';
y_f=y_n;


cut=0.6
f=[0  cut  cut+0.002   1];
m=[1  1    0      0];
N=128;

b=fir2(N,f,m);
a=[1,zeros(1,length(b)-1)];
y_n=filter(b,a,y_n);




mu = 0.009;            
ha = adaptfilt.lms(256,mu);
x=filter(ha,y_f,y_n);

mu = 0.009;            
ha = adaptfilt.lms(256,mu);
x=filter(ha,x,y_f);

mu = 0.0005;            
ha = adaptfilt.lms(256,mu);
[x,e]=filter(ha,x,y_f);



sound(x,Fs)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mx=mean(x);
my=mean((y'));
varx=mean((x-mx).^2);
vary=mean((y'-my).^2);
covxy=mean(abs((x-mx).*(y'-my)));
g=covxy/sqrt(varx*vary);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


x=x';
name=sprintf('linear_adaptive_filter_output_g_%1.4f.wav',g);
audiowrite(name,x,Fs);