function [ phase_shift12,average_phaseshift12] = phaseshift12( csi_trace )
% This function is to calculate the phaseshift between 12 an 13
% Read the csi trace in your main script, then call this function
 csi_ant1=zeros(30,length(csi_trace));
 csi_ant2=zeros(30,length(csi_trace));
 csi_ant3=zeros(30,length(csi_trace));
 csi_ant123=zeros(3,length(csi_trace));
 
 power_a=zeros(length(csi_trace),1); %The power parameters are prepared for check the possible power problem 
 power_b=zeros(length(csi_trace),1);
 power_c=zeros(length(csi_trace),1);
 
 phase_shift12=zeros(30,length(csi_trace));
 phase_shift13=zeros(30,length(csi_trace));
 
 for q=1:length(csi_trace)
    csi_entry=csi_trace{q};
    csi=get_scaled_csi(csi_entry);
    squeezed_csi=squeeze(csi);
    csi_ant1(:,q)=squeezed_csi(1,:).';
    csi_ant2(:,q)=squeezed_csi(2,:).';
    csi_ant3(:,q)=squeezed_csi(3,:).';
    power_a(q,1)=csi_entry.rssi_a;
    power_b(q,1)=csi_entry.rssi_b;
    power_c(q,1)=csi_entry.rssi_c;
 end
  for q=1:30
    csi_ant123(1,:)=csi_ant1(q,:);
    csi_ant123(2,:)=csi_ant2(q,:);
    csi_ant123(3,:)=csi_ant3(q,:);
    unwrap_phase=unwrap(angle(csi_ant123));
    phase_shift12(q,:)=unwrap_phase(2,:)-unwrap_phase(1,:);
    phase_shift13(q,:)=unwrap_phase(3,:)-unwrap_phase(1,:);
   %phase_shift(q,:)=angle(csi_ant12(2,:))-angle(csi_ant12(1,:));
    %Phase unwrap is necessary here, or the phaseshift will oscilate 
  end
  average_phaseshift12=mean(phase_shift12,2);
  average_phaseshift13=mean(phase_shift13,2);
  powershift(1,:)=abs(power_a-power_b);
  powershift(2,:)=abs(power_a-power_c);
  powershift(3,:)=abs(power_b-power_c);
average_powershift=mean(powershift.');
if min(average_powershift)>10
     Information=strcat('Some problem with RSSI of ',path_name,'\n');
     fprintf(Information);
end
end

