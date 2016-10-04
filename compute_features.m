function [ features, t ] = compute_features( y,Fs,winlength,ncep )
%compute_features Computes feature vector series that combine normalized 
%static and dynamic features
%   features
%   t - time
[mfccs,~,~,t] = GetSpeechFeatures(y,Fs,winlength,ncep);
d1 = diff(mfccs,1,2);
d2 = diff(mfccs,2,2);
features = [mfccs(:,3:end); d1(:,2:end); d2];
%normalize
features = mapstd(features);
t = t(3:end);
end

