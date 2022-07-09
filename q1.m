clc; close all; clear all;

%Sampling frequency
fs = 500;

fm = 2;

fc = 50;

t = 0 : 1/fs :5; 

m1 = cos(2*pi*fm*t);
m2 = cos(6*pi*fm*t);

s = cos(2*pi*fc*t).*m1 + sin(2*pi*fc*t).*m2

figure(1)
plot(t,s,'r-o')
title("QAM MODULATED SIGNAL")

figure(2)
ns = length(s);
fre_s = fftshift(fft(s,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
stem(f_s,abs(fre_s)/ns,"r-o");
xlim([-100 100])
title("QAM Modulated Signal Frequency Spectrum");

m1received = s .*cos(2*pi*fc*t)*2;
m2received = s .*sin(2*pi*fc*t)*2;

figure(4);
ns = length(s);
fre_s = fftshift(fft(m1received,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
stem(f_s,abs(fre_s)/ns);
xlim([-150 150]),
title("Frequency spectrum of M1 Received Signal")

figure(5);
ns = length(s);
fre_s = fftshift(fft(m2received,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
stem(f_s,abs(fre_s)/ns);
xlim([-150 150]),
title("Frequency spectrum of M2 Received Signal")


fcutoff = 30;
lpf = designfilt('lowpassfir','PassbandFrequency',fcutoff,'StopbandFrequency',fcutoff+20,...
    'SampleRate',fs);
fvtool(lpf);


m1recovered = filter(lpf,m1received);

figure(6)
fre_s = fftshift(fft(m1recovered,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
stem(f_s,abs(fre_s)/ns,"b-o");
title("M1 Recovered Signal")

m2recovered = filter(lpf,m2received);

figure(7)
fre_s = fftshift(fft(m2recovered,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
stem(f_s,abs(fre_s)/ns,"b-o");
title("M2 Recovered Signal")


figure(8)
fre_s = fftshift(fft(m2,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
stem(f_s,abs(fre_s)/ns,"r-o");
title("M2 Original Signal")


figure(9)
fre_s = fftshift(fft(m1,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
stem(f_s,abs(fre_s)/ns,"r-o");
title("M1 Original Signal")

