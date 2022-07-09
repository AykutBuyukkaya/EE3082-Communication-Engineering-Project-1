clc; close all; clear all;

%Sampling frequency
fs = 500;

fm = 2;

fc = 50;

t = 0 : 1/fs :5;

m = cos(2*pi*fm*t) + 2*cos(6*pi*fm*t)

mh = hilbert(m);

usb = m.*cos(2*pi*fc*t) - mh .* sin(2*pi*fc*t);
lsb = m.*cos(2*pi*fc*t) + mh .* sin(2*pi*fc*t);

figure(1)
plot(t,usb,'r-o')
grid on;
title("Upper Side Band Modulated Signal")
legend("USB")

figure(2)
plot(t,lsb,'b-o');
grid on
title("Lower Side Band Modulated Signal")
legend("LSB")


figure(3)
ns = length(usb);
fre_s = fftshift(fft(usb,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
stem(f_s,abs(fre_s)/ns,"r-o");
xlim([-100 100])
title("Frequency Spectrum Of USB Signal")

figure(4)
ns = length(lsb);
fre_s = fftshift(fft(lsb,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
stem(f_s,abs(fre_s)/ns,"b-o");
xlim([-100 100])
title("Frequency Spectrum Of LSB Signal")


usbDemod = usb .* cos(2*pi*fc*t)*2;
figure(5)
ns = length(usbDemod);
fre_s = fftshift(fft(usbDemod,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
stem(f_s,abs(fre_s)/ns,"r-o");
xlim([-100 100])
title("Frequency Spectrum Of Demodulated LSB Signal")

fcutoff = 30;
lpf = designfilt('lowpassfir','PassbandFrequency',fcutoff,'StopbandFrequency',fcutoff+20,...
    'SampleRate',fs);
fvtool(lpf);
usbFiltered = filter(lpf,usbDemod);

figure(7)
plot(t,usbFiltered,'b-o','LineWidth',2)
hold on;
grid on;
plot(t,m,'r-o','LineWidth',2)
legend("Demodulated Signal","Original Signal")


figure(8)
ns = length(usbFiltered);
fre_s = fftshift(fft(usbFiltered,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
subplot(1,2,1)
stem(f_s,abs(fre_s)/ns,"r-o");
axis([-100 100 -0.5 1.5])
title("Demodulated Signal Spectrum ")

ns = length(m);
fre_s = fftshift(fft(m,ns));
f_s = (-(ns-1)/2:(ns-1)/2)*(fs/ns);
subplot(1,2,2)
stem(f_s,abs(fre_s)/ns,"b-o");
axis([-100 100 -0.5 1.5])
title("Original Signal Spectrum")


