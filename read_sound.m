function [ y, Fs, t ] = read_sound( filename )
%read_sound Read sound from specified file
%   y - sound signal
%   Fs - sample rate, in Hertz
%   t - time in sec (computed based on Fs)
[y,Fs] = audioread(filename);
t = 1:size(y,1);
t = reshape(t,[size(t,2),1]);
t = t/Fs;
end

