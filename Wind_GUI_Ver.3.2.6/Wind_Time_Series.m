function ht =Wind_Time_Series(wind_new,mm,cut)
    
    x=ceil(linspace(1,mm,cut));
    tt={};
    for j=1:cut
    tt=[tt,wind_new.TIMESTAMP{x(j),1}(6:16)];
    xposi(j)=x(j);
    end
    yposi=(541)*ones(1,cut);
    
    subplot('position',[.1,.6,.8,.32]);
    plot(1:mm,wind_new.WSavg_70mW,'k',1:mm,wind_new.WSavg_70mE,'r',1:mm,wind_new.WSavg_30m,'b');
    hold on
    plot(1:mm,wind_new.WSavg_50m,'Color',[0 0.4 0]);
    hold off
    set(gca,'XTick',xposi);
    set(gca,'XTickLabel',[]);
    axis([0 mm 0 ceil(max(wind_new.WSavg_70mE))]);
    title('彰濱時間序列圖');
    ylabel('風速 (m/s)');
    legend('70mE','70mW','50m','30m');
    set(gca,'FontWeight','bold','fontsize',15);
    subplot('position',[.1,.1,.8,.32]);
    plot(1:mm,wind_new.WDavg_70mW,'k',1:mm,wind_new.WDavg_70mE,'r',1:mm,wind_new.WDavg_30m,'b');
    hold on
    plot(1:mm,wind_new.WDavg_50m,'Color',[0 0.4 0]);
    hold off
    set(gca,'XTick',xposi);
    set(gca,'XTickLabel',[]);
    axis([0 mm 0 360]);
    xlabel('時間');
    ylabel('風向 (角度)');
    legend('70mE','70mW','50m','30m');
    set(gca,'FontWeight','bold','fontsize',15);
    ht=text(xposi,yposi,tt,'HorizontalAlignment', 'right', 'rotation', 90);
    
end

