clc
clear all
close all

filename='saghi.mp3'
[y,Fs] = audioread(filename);




filename='saghi1.wav'
audiowrite(filename,y(:,1),Fs);


randn('seed',sum(clock*200));
n=randn(size(y));
n(:,2)=0;
n=n*0.02*(max(y(:,1))-min(y(:,1)));

y_n=(n(:,1)+y(:,1));


filename='saghi1_noise.wav'
audiowrite(filename,y_n,Fs);
