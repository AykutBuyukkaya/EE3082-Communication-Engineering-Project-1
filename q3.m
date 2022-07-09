clc; close all; clear all;

%Sampling frequency
fs = 500;

fm = 1
Tm = 1/fm

t = -2:1/fs:2

%Shifting the signal
m = sawtooth(2*pi*(t-Tm/2))

plot(t,m,'r','LineWidth',2)
axis([-2 2 -2 2])
title("Sawtooth Signal")


k_harmonics = 5
k_vec = -k_harmonics:k_harmonics
cc = 1
m_approx = 0



while cc<=length(k_vec)
    k = k_vec(cc) 
    fun = @(x) 2*x.*exp(-j*2*pi*k*fm*x)
    
    fcoef(cc) = integral(fun,-Tm/2,Tm/2);
    D(cc) = abs(fcoef(cc));
    m_approx = m_approx + fcoef(cc)* exp(2*pi*k*fm*t);
    cc = cc+1
end

n = length(m)
fre = fftshift(fft(m,n))
f = (-(n-1)/2:(n-1)/2) * fs/n

figure(2)
stem(f,abs(fre)/n,'b')
xlim([-20 20])
hold on
stem(k_vec*fm,D,'r-*')
grid on
ylim([0 0.5])
xlabel("Frequency - Hz")
ylabel('Gain')
legend('Message Spectrum',sprintf('First %d coefficents',k_harmonics))


m_int = (1/fs)*cumsum(m);
A = 1
kf = 80
fc = 50
s = A * cos(2*pi*fc*t +kf*m_int);

figure(3)
subplot(2,1,2)
plot(t,s ,"r-o")
title("FM Modulated Signal")
grid on
subplot(2,1,1)
plot(t,m,'b-o')
title("Original Sawtooth Signal")

figure(4)
s_der = diff([s(1) s]) /(1/fs)/kf
m_received = envelope(s_der);
plot(t,m_received,'r-o');
title("FM Demodulated Signal")

