function Hd = iir_elliptic_3400_44100
%IIR_ELLIPTIC_3400_44100 Returns a discrete-time filter object.

% MATLAB Code
% Generated by MATLAB(R) 9.0 and the DSP System Toolbox 9.2.
% Generated on: 09-Nov-2016 11:02:46

% Elliptic Lowpass filter designed using FDESIGN.LOWPASS.

% All frequency values are in Hz.
Fs = 44100;  % Sampling Frequency

N     = 10;    % Order
Fpass = 3400;  % Passband Frequency
Apass = 0.5;   % Passband Ripple (dB)
Astop = 60;    % Stopband Attenuation (dB)

% Construct an FDESIGN object and call its ELLIP method.
h  = fdesign.lowpass('N,Fp,Ap,Ast', N, Fpass, Apass, Astop, Fs);
Hd = design(h, 'ellip');

% [EOF]
