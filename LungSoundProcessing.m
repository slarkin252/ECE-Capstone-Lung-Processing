##Processing Lung Sounds
#pkg load signal #run the first time to import package
clear all;

cd 'D:/LungSounds/ECE-Capstone-Lung-Processing'; #maps to my dir, change to where you have the files saved locally
myfolder1 = 'LungSoundsAbbr/*.wav'; #searches the lung sound library, change to match variable l
myfolderinfo = dir(myfolder1);
l = 'LungSoundsAbbr/'; #folder name for specific lung sounds in use, can be changed to search different library folders
l2 = 'FrequencyResponse/';

#myfolderinfo.name #can be used to get an output of all files in myfolderinfo in the correct order
mfin = myfolderinfo(31).name #change this number to select file
recordedSigs = 'Test500Hz523mVv2.wav'; #change to the specific file to analyze

#filename = strcat(l, mfin); #combines the folder name and file name since dir is wider than specific file
filename = strcat(l2, recordedSigs); #used for the newly recorded signals


[x,fs] = audioread(filename);#reads our audio file into a graphable format
#info = audioinfo(filename(2,1))#prints audiofile details to console

xlen = length(x);                   
t = (0:length(x)-1)/fs;
wlen = 1024; #window length                        
nfft = 4*wlen; #normalized fourier frequency transform                      
hop = wlen/4;#offset for specgram                                   
w1 = hanning(wlen, 'periodic'); #hanning function

[dummy, fS, tS] = specgram(x, wlen, fs);#spectrogram translated from matlab


w2 = hanning(xlen, 'periodic');#makes the reference periodic
[PS, fX] = periodogram(x, w2, nfft, fs);#PS is power spectral density, fX are our output frequencies
Xamp = 20*log10(sqrt(PS)*sqrt(2)); #Normalization of some of the data


x = x(:,1);
    figure
    dt = 1/fs;
    t = 0:dt:(length(x)*dt)-dt;
    plot(t,x,'r'); xlabel('Seconds'); ylabel('Amplitude');
    grid on; xlim([0 10]); ylim([-.1 .1]);#cleaning up the graph
    
    figure
    plot(fX, Xamp)
    grid on; xlim([0 max(fX)]); ylim([min(Xamp)-10 max(Xamp)+10]);#cleaning up the graph 
    xlabel('Frequency, Hz'); ylabel('Magnitude, dB');#labels