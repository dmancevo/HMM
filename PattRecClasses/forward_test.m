%forward algorithm tests
%----------------------------------------------------
%Code Authors: Olga Mikheeva, Diego A. Mancevo
%----------------------------------------------------

%correct values
alfaHat_correct = [1.0000    0.3847    0.4189;
                   0         0.6153    0.5811];
               
c_scaled_correct = [1.0000 0.1625 0.8266 0.0581];

c_unscaled_correct = [0.3910 0.0318 0.1417 0.0581];

%create HMM
mc = MarkovChain([1 0], [0.9 0.1 0; 0 0.9 0.1]);
g1=GaussD('Mean',0,'StDev',1);
g2=GaussD('Mean',3,'StDev',2);
h = HMM(mc, [g1,g2]);

%this is the infinite version
% mc = MarkovChain([1 0 0], [0.9 0.1 0; 0 0.9 0.1;0 0 1]);
% g1=GaussD('Mean',0,'StDev',1);
% g2=GaussD('Mean',3,'StDev',2);
% g3=GaussD('Mean',50,'StDev',2);
% h = HMM(mc, [g1,g2,g3]);

x = [-0.2 2.6 1.3]; %emission sequence

N = mc.nStates;
T = length(x);
isFinite = size(mc.TransitionProb,2) == size(mc.TransitionProb,1) + 1;

[p_scaled, logS] = prob(h.OutputDistr,x);
[alfaHat, c_scaled] = forward(mc, p_scaled)
c_unscaled = c_scaled .* [exp(logS),ones(isFinite)]

%Check errors
%Errors_alphaHat = abs(alfaHat_correct - alfaHat)
%Errors_c_scaled = abs(c_scaled_correct - c_scaled)
%Errors_c_unscaled = abs(c_unscaled_correct - c_unscaled)

logP = logprob([h],x)

