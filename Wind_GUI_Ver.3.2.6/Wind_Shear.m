function alpha_shear=Wind_Shear(wind_new)
    [mm,nn]=size(wind_new);
if nn==9%MySQL�����  
    
      i=find(isnan(wind_new.RMYoung_WS));%��Xwind_new.RMYoung_WS����NaN
      wind_new.RMYoung_WS(i)=0;%�令0
    
      j=find(isnan(wind_new.RMYoung_WS_1));%��Xwind_new.RMYoung_WS_1����NaN
      wind_new.RMYoung_WS_1(j)=0;%�令0
    
      k=find(isnan(wind_new.RMYoung_WS_2));%��Xwind_new.RMYoung_WS_2����NaN
      wind_new.RMYoung_WS_2(k)=0;%�令0
      
      M4=mean(wind_new.RMYoung_WS);
      M3=mean(wind_new.RMYoung_WS_1);
      M1=mean(wind_new.RMYoung_WS_2);
      M=sort([M4,M3,M1]);
      [c1,c2]=fit([M(1);M(2);M(3)],[30;50;70],'power1');
      x1=0:0.1:ceil(M(3));
      subplot(1,1,1);
      plot(x1,c1(x1),'r',M(1),30,'b.',M(2),50,'b.',M(3),70,'b.','markersize',30);
    
%     �H�U�O���|�X�{warning����k�A�����u���I��30m�B70m���������t�ȡA�L�k�ݥX30m�H�U�B70m�H�W�����t���p
%     �p�n�ϥΡA�Ч�18~21�����áA�����H�U�Y�i
%     Z4=(M4-mean(M))/std(M);
%     Z3=(M3-mean(M))/std(M);
%     Z1=(M1-mean(M))/std(M);
%     Z=sort([Z4,Z3,Z1]);
%     zfit = linspace(Z(1),Z(3),10);
%     K=[30,50,70];
%     PZ = polyfit(Z,K,2);
%     yfit = polyval(PZ,zfit);
%     xfit = linspace(M(1),M(3),10);
%     subplot(1,1,1);
%     plot(xfit,yfit,'r',M(1),30,'b.',M(2),50,'b.',M(3),70,'b.','markersize',30) 
      grid on;
      alpha_shear=log10(70/30)/log10(M(3)/M(1));%��Xalpha��

else%txt�����
    
      M1=mean(wind_new.WSavg_70mE);
      M2=mean(wind_new.WSavg_70mW);
      M3=mean(wind_new.WSavg_50m);
      M4=mean(wind_new.WSavg_30m);
      M=sort([M4,M3,M2,M1]);
      %cftool([M4 M3 M2 M1],[30 50 70 70]);%��toolbox��alpha����
      [c1,c2]=fit([M4;M3;M2;M1],[30;50;70;70],'power1');
      x1=0:0.1:ceil(M1);
      subplot(1,1,1);
      plot(x1,c1(x1),'r',M4,30,'b.',M3,50,'b.',M2,70,'b.',M1,70,'b.','markersize',30);   
    
%     �H�U�O���|�X�{warning����k�A�����u���I��30m�B70m���������t�ȡA�L�k�ݥX30m�H�U�B70m�H�W�����t���p
%     �p�n�ϥΡA�Ч�46~49�����áA�����H�U�Y�i
%     Z4=(M4-mean(M))/std(M);
%     Z3=(M3-mean(M))/std(M);
%     Z2=(M2-mean(M))/std(M);
%     Z1=(M1-mean(M))/std(M);
%     Z=sort([Z4,Z3,Z2,Z1]);
%     zfit = linspace(Z(1),Z(4),10);
%     K=[30,50,70];
%     PZ = polyfit([Z(1),Z(2),Z(4)],K,2);
%     yfit = polyval(PZ,zfit);
%     xfit = linspace(M(1),M(3),10);
%     subplot(1,1,1);
%     plot(xfit,yfit,'r',M(1),30,'b.',M(2),50,'b.',M(3),70,'b.',M(4),70,'b.','markersize',30)     
      grid on;
      alpha_shear=log10(70/30)/log10((M1+M2)/2/M4);%��Xalpha��

end

      set(gca,'XMinorTick','on','YMinorTick','on');%�e�p��u
      title('���ح������ƹ�');
      xlabel('���t (m/s)');
      ylabel('���� (m)');
      set(gca,'FontWeight','bold','fontsize',15);
end

