#Processing Lung Sounds
#pkg load signal
clear all;

cd 'D:/LungSounds/ECE-Capstone-Lung-Processing'; #maps to my dir, change to where you have the files saved locally
myfolder1 = 'LungSoundsAbbr/*.wav'; #searches the lung sound library, change to match variable l
myfolderinfo = dir(myfolder1);
l = 'LungSoundsAbbr/'; #folder name for specific lung sounds in use, can be changed to search different library folders
l2 = 'FrequencyResponse/';
l3 = 'ActualLungSounds/';
#mfin = ;
#myfolderinfo.name #can be used to get an output of all files in myfolderinfo in the correct order
mfin = myfolderinfo(31).name #change this number to select file
recordedSigs = 'Test500Hz523mVv2.wav';
recordedLung = 'Test-3-29-2.wav';
#filename = strcat(l, mfin); #combines the folder name and file name since dir is wider than specific file
#filename = strcat(l2, recordedSigs); #used for the newly recorded signals
filename = strcat(l3, recordedLung);#used to pull from different directory

[x,fs] = audioread(filename);#reads our audio file into a graphable format
#info = audioinfo(filename(2,1))#prints audiofile details to console

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
    figure
    dt = 1/fs;
    t = 0:dt:(length(x)*dt)-dt;
    plot(t,x,'r'); xlabel('Seconds'); ylabel('Amplitude');
    grid on; xlim([0 10]); ylim([-.1 .1]);#beautifying the graph
    
    figure
    plot(fX, Xamp)
    grid on; xlim([0 max(fX)]); ylim([min(Xamp)-10 max(Xamp)+10]);#beautifying the graph 
    xlabel('Frequency, Hz'); ylabel('Magnitude, dB');#^^^
    
##    figure
##    xlabel('Frequency, Hz');ylabel('Amplitude');
##    xlim([0 max(fX)]);
##    plot(fX, x)
    
##    figure
##    plot(psd(spectrum.periodogram,y,'Fs',fs,'NFFT',length(y)));