clc; clear; close all;

% Task 1

Fs = 4000; % Sampling Frequency
fc = 300; % Cutoff Frequency
N = 61; % Filter Length
n = 0:N-1; % Center Index
M = (N-1)/2; % Center Index

fc_norm = fc/Fs; % Normalised Cutoff Frequency

h = 2*fc_norm * sinc(2*fc_norm*(n - M)); % Impulse Response

figure;
stem(n, h, 'filled');
title('61-Point Truncated Sinc Impulse Response');
xlabel('n');
ylabel('h[n]');

[H,F] = freqz(h, 1, 1024, Fs);

figure;
plot(F, abs(H));
title('Magnitude Spectrum');
xlabel('Frequency (Hz)');
ylabel('(|H(f)|');
grid on;

% Task 2

t = 0:1/Fs: 1-1/Fs;
duration

x = sin(2*pi*150*t) + sin(2*pi*800*t);

y = filter(h,1,x);

figure;
subplot(2,1,1);
plot(t,x);
title('Original Signal (150Hz - 800Hz)');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

subplot(2,1,2);
plot(t,y);
title('Filtered Signal');
xlabel('Time (s)');
ylabel('Amplitude');
grid on;

X = fft(x);
Y = fft(y);

f = (0:length(X)-1)*(Fs/length(x));

figure
plot(f, abs(x)); hold on;
plot(f, abs(Y));
xlim([0 1200]);
legend('Original','Filtered');
title('Magnitude Spectrum Comparison');
xlabel('Frequency (Hz)');
ylabel('|x(f)|');
grid on;

% Task 3

h_ideal = 2*fc_norm * sinc(2*fc_norm*(n-M));

w = hamming(N);

h_hamming = h_ideal .* w;

figure
subplot(2,1,1);
stem(n, h_ideal, 'filled');
title('Impulse Response - Rectangular');
xlabel('n');
ylabel('h[n]');
grid on;

subplot(2,1,2);
stem(n, h_hamming, 'filled');
title('Impulse Response - Hamming Window');
xlabel('n');
ylabel('h[n]');
grid on;

[H_rect,f] = freqz(h_ideal,1,1024,Fs);
[H_ham,f] = freqz(h_hamming,1,1024,Fs);

figure;
plot(f,abs(H_rect), 'b', 'LineWidth',1.2);
hold on;
plot(f,abs(H_ham), 'r', 'Linewidth',1.2);
legend('Rectangular','Hamming');
title('Magnitude Spectrum Comparison');
xlabel('Frequency(Hz)');
ylabel('|H(f)|');
xlim([0 1000]);

% Task 4 

Q = 0.707;

[b,a] = bj_higpass(Fc, Fs, Q);

t = 0:1/Fs:1-1/Fs;
x = sin(2*pi*150*t) + SIN(2*pi*800*t);

omega = 2*pi*Fc/Fs;
alpha = sin(omega)/(2*Q);

b0 = (1 + cos(omega))/2;
b1 = -(1 + cos(omega));
b2  (1 + cos(omega))/2;

a0 = 1 + alpha;
a1 = -2*cos(omega);
a2 = 1 - alpha;

b = [b0 b1 b2]/a0;
a = [1 a1/a0 a2/a0];


y = filter(b, a, x);

figure;
plot(t, x, 'b'); hold on;
plot(t, y, 'r');
legend('Original', 'Filtered');
title('Bristow-Johnson Low-Pass');
xlabel('Time (s)');
grid on;

