function Wind_TI(current_data_S,current_data_Std)

subplot(1,1,1);
plot(current_data_S,100*current_data_Std./current_data_S,'bo'); grid on;
set(gca,'XMinorTick','on','YMinorTick','on');%畫小格線
title(' Turbulence Intensity Diagram');
xlabel('風速 (m/s)');
ylabel('T.I (%)');
set(gca,'FontWeight','bold','fontsize',15);
hold on
x=0:0.05:ceil(max(current_data_S));
for e=1:length(x)
ya(e)=100*0.16*(0.75*x(e)+3.8)/x(e);
yb(e)=100*0.14*(0.75*x(e)+3.8)/x(e);
yc(e)=100*0.12*(0.75*x(e)+3.8)/x(e);
end

ylim([0 50]);

ha=plot(x,ya,'Color',[1 0 0]);
set( ha , 'linewidth' , 1.5 );
hb=plot(x,yb,'Color',[0 0.5 0]);
set( hb , 'linewidth' , 1.5 );
hc=plot(x,yc,'Color',[1 0.5 0]);
set( hc , 'linewidth' , 1.5 );
legend([ha,hb,hc],'IEC Class A','IEC Class B','IEC Class C');

hold off

end

