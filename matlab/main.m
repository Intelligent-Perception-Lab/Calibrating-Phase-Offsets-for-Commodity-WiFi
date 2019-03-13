clear
close all
clc
addpath('./read_function')
dbstop if error

%% Calculate the phase shift of 12 and 13 by exchanging the external cable 
csi_trace=read_bf_file('./cal190218/190218sRE27ch60cal12ft1.dat');
[ c12phase_shift12,c12average_phaseshift12] = phaseshift12( csi_trace );
csi_trace=read_bf_file('./cal190218/190218sRE27ch60cal21ft1.dat');
[ c21phase_shift12,c21average_phaseshift21] = phaseshift12( csi_trace );
csi_trace=read_bf_file('./cal190218/190218sRE27ch60cal13ft1.dat');
[ c13phase_shift13,c13average_phaseshift13] = phaseshift13( csi_trace );
csi_trace=read_bf_file('./cal190218/190218sRE27ch60cal31ft1.dat');
[ c31phase_shift31,c31average_phaseshift31] = phaseshift13( csi_trace );

%% Average the measurement
phase12out=(c12average_phaseshift12+c21average_phaseshift21)/2;
phase13out=(c13average_phaseshift13+c31average_phaseshift31)/2;

%% Check whether there are some errors 
if abs(c12average_phaseshift12-c21average_phaseshift21)>pi | abs(c13average_phaseshift13-c31average_phaseshift31)>pi
    printf('May error')
end

%% Phase offset output
mphase12=mean(phase12out);
mphase13=mean(phase13out);

