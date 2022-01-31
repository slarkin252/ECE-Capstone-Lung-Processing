#Processing Lung Sounds
#pkg load signal

filename(1,:) = 'LungSoundsAbbr//BP1_Asthma,I E W,P L L,70,M.wav';
filename(2,:) = 'LungSoundsAbbr//BP2_Asthma,E W,P L L R,52,F.wav';
#plans to automate the array to easily switch between sound library

[x,fs] = audioread(filename(1,:));

info = audioinfo(filename(1,:))#prints audiofile details to console

xlen = length(x);                   
t = (0:length(x)-1)/fs;
#plot(t*1E+3, x);
wlen = 1024; #window length?                        
nfft = 4*wlen; #normalized fourier frequency transform                      
hop = wlen/4;#I think offset for specgram?                       
##TimeRes = wlen/fs;        #Probably extraneous variables          
##FreqRes = 2*fs/wlen;               
##TimeResGrid = hop/fs;               
##FreqResGrid = fs/nfft;              
w1 = hanning(wlen, 'periodic');

[dummy, fS, tS] = specgram(x, wlen, fs);#spectrogram translated from matlab
#spectrogram(x, w1, wlen, nfft, fs) -> specgram(x, wlen, fs)


#Samp = 20*log10(sqrt(PSD.*enbw(w1, fs))*sqrt(2)); dont have access to PSD
w2 = hanning(xlen, 'periodic');#makes the reference periodic
[PS, fX] = periodogram(x, w2, nfft, fs);#PS is power spectral density, fX are our output frequencies
Xamp = 20*log10(sqrt(PS)*sqrt(2)); #Not really sure but probably some normalization magic


x = x(:,1);
    dt = 1/fs;
    t = 0:dt:(length(x)*dt)-dt;
    plot(t,x); xlabel('Seconds'); ylabel('Amplitude');
    
    figure
    plot(fX, Xamp)
    grid on; xlim([0 max(fX)]); ylim([min(Xamp)-10 max(Xamp)+10]);#beautifying the graph 
    view(-90, 90); xlabel('Frequency, Hz'); ylabel('Magnitude, dB');#^^^
    
##    figure
##    plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));