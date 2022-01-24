#Processing Lung Sounds

filename = 'LungSoundsAbbr//BP1_Asthma,I E W,P L L,70,M.wav';
[y,fs] = audioread(filename);

info = audioinfo(filename)

y = y(:,1);
    dt = 1/fs;
    t = 0:dt:(length(y)*dt)-dt;
    plot(t,y); xlabel('Seconds'); ylabel('Amplitude');
##    figure
##    plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));