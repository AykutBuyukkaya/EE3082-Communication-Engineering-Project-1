NOTE: You can find Matlab codes and Simulink models under the q1, q2, and q3 folders.
==========

Question 1
==========

In this question, I'll implement a QAM modulator-demodulator system. The
QAM modulator allows us to transmit two separate signals on the same
channel. For the transmitting part, we are multiplying message signals with
two different sine and cosine carrier signals. These signals create a
channel signal without any overlapping on frequency responses of
original signals. For the receiver part, we simply multiply the incoming
signal with signals that we multiplied on the transmitter part to
receive the frequency response of the original message. In the end, we simply
perform a low-pass filtering operation to cancel other frequencies.

Q1.a
----

This is our modulated signal that carries both of our message signals in
the time domain. To generate this signal, we multiplied our message
signals with sign and cosine signals separately. In this way, we can
transmit two separate signals over the same channel.

![](media/image1.png)

Q1.b
----     

![](media/image2.png)

This is the QAM modulated signal in the frequency domain You can find the
hand calculations below. Spectrum matches my hand calculation.

![](media/image3.png)

Q1.c
----

To receive original signals, we need to multiply incoming
signs with the encoding signals that we used in the transmitter part.
After separate multiplications, we can see the frequency responses of the
demodulated signals.

![](media/image4.png)

![](media/image5.png)

From the graphs above, we can see that our demodulator and modulator
seems to work quite well. The only thing left for us to do is remove
those frequency components at the edge of the spectrum. We can see that
our signals lie between 0-50 planes for both sides. So we can use a low
pass filter that has a stopband frequency of 50Hz.

![](media/image6.png)

Here is the magnitude response of our low pass filter. This low pass
the filter will remove all components which have a frequency greater than
50 Hz.

Q1.d
----

![](media/image7.png)

Here we can see the recovered and original signals. Since they are
almost the same, which means the QAM modulator and demodulator work quite well.

Q2.a
----

![](media/image11.png)

Here we can see both USB and LSB modulated signals in the time domain.
The main purpose of DSB modulation is to transfer only the upper of the lower part
of the signal since they are both same. This allows us to transmit
signals with a small amount of energy.

Q2.b
----

![](media/image12.png)
Here we can see the frequency spectrums of
both signals. As we predicted, these signals have the same spectrums. This
means we can regenerate the original signal from only one of these signals.

Q2.c
----

![](media/image13.png)

![](media/image14.png)
In this graph, we can see our original
and SSB-recovered signals. Since they are almost the same, our modulator and
demodulator seem working.

After analyzing the frequency spectrum of demodulated LSB signal, I decided
to use the filter that I used for the first question. Since we do not have
any required components to reconstruct our signal that has a frequency
greater than 50 Hz this filter will fit our system.

![](media/image15.png)

This is the frequency spectrum for LSB demodulated signal. We can see
the components at 2 and 6 Hz. These components are needed for
the reconstruction of our original signal. To remove other unwanted
components, we need to use the low pass filter with the graph given above.

Q2.d
----

![](media/image16.png)

From the graph above we can see that frequency components of demodulated
and original signals are almost the same.

Q3.a
----

For this part of the project, I have used formulas and functions written
in Week 2 lab session. A little modification was needed for this
question.

![](media/image17.png)
This is the sawtooth signal created by
the sawtooth function on Matlab. I have shifted its frequency by 0.5 so
it'll make integral calculations easy.

Q3.b
----

![](media/image18.png)
Here we can see that all of the five
coefficients are matching with the signal spectrum components.

Q3.c
----

![](media/image19.png)
Here we can see the frequency modulation
of our sawtooth signal. In frequency modulation, frequency is dependent
on the value of the function. A higher value means higher frequency. We
can see that the frequency of the modulated signal is higher when the
sawtooth signal has a value close to one.

Q3.d
----

![](media/image20.png)
Here is the demodulated FM signal that we
calculated in the previous step. Demodulation is done by an envelope detector.
