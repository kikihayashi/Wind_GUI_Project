function ht =Wind_Time_Series_sql(wind_mysql30,wind_mysql50,wind_mysql70,wind_new,cut)
    [mm30,nn30]=size(wind_mysql30);
    [mm50,nn50]=size(wind_mysql50);
    [mm70,nn70]=size(wind_mysql70);
    [mm,nn]=size(wind_new);
   
    x=ceil(linspace(1,mm,cut));
    tt={};
    for j=1:cut
    tt=[tt,wind_new.dt{x(j),1}(6:16)];
    xposi(j)=x(j);
    end
    yposi=(555)*ones(1,cut);
    
    subplot('position',[.1,.6,.8,.32]);
    plot(1:mm70,wind_mysql70.RMYoung_WS,'Color',[0 0.4 0]);
    hold on
    plot(1:mm50,wind_mysql50.RMYoung_WS,'r',1:mm30,wind_mysql30.RMYoung_WS,'b');
    hold off
    set(gca,'XTick',xposi);
    set(gca,'XTickLabel',[]);
    axis([0 mm 0 ceil(max(wind_mysql70.RMYoung_WS))]);
    title('彰濱時間序列圖');
    ylabel('風速 (m/s)');
    legend('70m','50m','30m');
    set(gca,'FontWeight','bold','fontsize',15);
    subplot('position',[.1,.1,.8,.32]);
    plot(1:mm70,wind_mysql70.RMYoung_WD,'Color',[0 0.4 0]);
    hold on
    plot(1:mm50,wind_mysql50.RMYoung_WD,'r',1:mm30,wind_mysql30.RMYoung_WD,'b');
    hold off
    set(gca,'XTick',xposi);
    set(gca,'XTickLabel',[]);
    axis([0 mm 0 360]);
    xlabel('時間');
    ylabel('風向 (角度)');
    legend('70m','50m','30m');
    ht=text(xposi,yposi,tt,'HorizontalAlignment', 'right', 'rotation', 90,'FontWeight','bold','fontsize',10);
    set(gca,'FontWeight','bold','fontsize',15);
end


