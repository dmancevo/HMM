%% Feature extraction for speech recognition

% Parameters
addTitles = true;
winlength = 0.03;
ncep = 13;

% Read signal from wav files
[ y1, Fs1, x1 ] = read_sound('female.wav');
[ y2, Fs2, x2 ] = read_sound('male.wav');
[ y3, Fs3, x3 ] = read_sound('music.wav');

% Get features
[mfccs1,spectgram1,f1,t1] = GetSpeechFeatures(y1,Fs1,winlength,ncep);
[mfccs2,spectgram2,f2,t2] = GetSpeechFeatures(y2,Fs2,winlength,ncep);
[mfccs3,spectgram3,f3,t3] = GetSpeechFeatures(y3,Fs3,winlength,ncep);

%Log spectrograms
log_sp1 = log(spectgram1);
log_sp2 = log(spectgram2);
log_sp3 = log(spectgram3);

%Normalized MFCCs (normalize to 0 mean and std 1)
mfccs1_norm = mapstd(mfccs1);
mfccs2_norm = mapstd(mfccs2);
mfccs3_norm = mapstd(mfccs3);

%% Sound Signals Plots

%Female speech signal
figure(1);
plot(x1,y1);
xlabel('Time, sec.');
ylabel('Signal intensity');
if addTitles
    title('Female speech signal');
end

%Female speech signal zoomed
figure(2);
plot(x1(16000:17000),y1(16000:17000));
xlabel('Time, sec.');
ylabel('Signal intensity');
if addTitles
    title('Female speech signal (zoomed in)');
end

% Music signal
figure(3);
plot(x3,y3);
xlabel('Time, sec.');
ylabel('Signal intensity');
if addTitles
    title('Music signal');
end

% Music signal zoomed
figure(4);
plot(x3(10000:10500),y3(10000:10500));
xlabel('Time, sec.');
ylabel('Signal intensity');
if addTitles
    title('Music signal (zoomed in)');
end

% Female speech voiced segment
figure(5);
plot(x1(26460:44100),y1(26460:44100));
xlabel('Time, sec.');
ylabel('Signal intensity');
if addTitles
    title('Voiced segment of speech signal (female)');
end

% Female speech unvoiced segment
figure(6);
plot(x1(6615:11025),y1(6615:11025));
xlabel('Time, sec.');
ylabel('Signal intensity');
if addTitles
    title('Unvoiced segment of speech signal (female)');
end

%% The Fourier Transform Plots

% Spectrogram of the music signal
figure(7);
imagesc('XData',t3,'YData',f3,'CData',log_sp3);
colorbar;
xlim([0,t3(end)]);
ylim([0,f3(end)]);
xlabel('Time, sec.')
ylabel('Frequencies, Hz.')
if addTitles
    title('Music signal spectrogram in log-scale');
end

% Spectrogram of the music signal (zoomed in) with annotations
figure(8);
imagesc('XData',t3,'YData',f3(1:230),'CData',log_sp3(1:230,:));
colorbar;
xlim([0,t3(end)]);
ylim([0,f3(230)]);
xlabel('Time, sec.')
ylabel('Frequencies, Hz.')
if addTitles
    title('Music signal spectrogram in log-scale (zoomed in)');
end
%harmonics annotations
a1 = annotation('textarrow',[0.4 0.26],[0.46 0.26],'String','3f');
a1.FontSize = 15;
a2 = annotation('textarrow',[0.4 0.26],[0.41 0.21],'String','2f');
a2.FontSize = 15;
a3 = annotation('textarrow',[0.4 0.26],[0.36 0.16],'String','f');
a3.FontSize = 15;

% Spectrogram of the female speech signal
figure(9);
imagesc('XData',t1,'YData',f1,'CData',log_sp1);
colorbar;
xlim([0,t1(end)]);
ylim([0,f1(end)]);
xlabel('Time, sec.')
ylabel('Frequencies, Hz.')
if addTitles
    title('Female speech signal spectrogram in log-scale ');
end
%voiced and unvoiced sounds annotation
a1 = annotation('textarrow',[0.5 0.17],[0.75 0.4],'String','Unvoiced');
a1.FontSize = 14;
annotation('textarrow',[0.5 0.28],[0.75 0.4],'String','');
annotation('textarrow',[0.5 0.58],[0.75 0.4],'String','');

a2 = annotation('textarrow',[0.4 0.24],[0.4 0.15],'String','Voiced');
a2.FontSize = 14;
annotation('textarrow',[0.4 0.37],[0.4 0.15],'String','')
annotation('textarrow',[0.4 0.72],[0.4 0.15],'String','')

% Spectrogram of the female speech signal (zoomed in) with annotations
figure(10);
imagesc('XData',t1,'YData',f1(1:230),'CData',log_sp1(1:230,:));
colorbar;
xlim([0,t1(end)]);
ylim([0,f1(230)]);
xlabel('Time, sec.')
ylabel('Frequencies, Hz.')
if addTitles
    title('Female speech signal spectrogram in log-scale (zoomed in)');
end

% Spectrogram of the male speech signal
figure(11);
imagesc('XData',t2,'YData',f2,'CData',log_sp2);
colorbar;
xlim([0,t2(end)]);
ylim([0,f2(end)]);
xlabel('Time, sec.')
ylabel('Frequencies, Hz.')
if addTitles
    title('Male speech signal spectrogram in log-scale ');
end

%% MFCCs Plots

%Female speech cepstogram
figure(12);
imagesc('XData',t1, 'CData',mfccs1_norm);
colorbar;
xlim([0,t1(end)]);
ylim([0.5,13.5]);
xlabel('Time, sec.')
ylabel('Cepstral coefficient')
if addTitles
    title('Female speech signal cepstogram (normalised)');
end

%Male speech cepstogram
figure(13);
imagesc('XData',t2, 'CData', mfccs2_norm);
colorbar;
xlim([0,t2(end)]);
ylim([0.5,13.5]);
xlabel('Time, sec.')
ylabel('Cepstral coefficient')
if addTitles
    title('Male speech signal cepstogram (normalised)');
end

% Music cepstogram
figure(14);
imagesc('XData',t3, 'CData', mfccs3_norm);
colorbar;
xlim([0,t3(end)]);
ylim([0.5,13.5]);
xlabel('Time, sec.')
ylabel('Cepstral coefficient')
if addTitles
    title('Music signal cepstogram (normalised)');
end

%% Comparison between correlation matrices for spectrogram and cepstogram
%female
figure(15);
imagesc(abs(corr(log_sp1.')));
colorbar;
if addTitles
    title('Correlation matrix (abs) of female speech signal log-spectrogram');
end

figure(16);
imagesc(abs(corr(mfccs1_norm.')));
colorbar;
if addTitles
    title('Correlation matrix (abs) of female speech signal normalized cepstogram');
end

%% Dynamic Features
%female
[features,t] = compute_features(y1, Fs1, winlength,ncep);
figure(17);
imagesc('XData',t, 'CData',features);
colorbar;
xlim([t(1),t(end)]);
ylim([0.5,39.5]);
xlabel('Time, sec.')
ylabel('Features')
if addTitles
    title('Combined static and dynamic features');
end
