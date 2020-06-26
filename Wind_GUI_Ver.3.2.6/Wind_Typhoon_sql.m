function Wind_Typhoon_sql(wind_typhoon,cut,title_typhoon)  
    [m,n]=size(wind_typhoon);%取得資料庫的列、行值
    x=ceil(linspace(1,m,cut)); %將列項平分成cut-1等分
    %以下設定橫軸資訊，將日期顯示在圖的橫坐標，總共顯示cut個，每格之間的距離一樣
    tt={};
    for j=1:cut
    tt=[tt,wind_typhoon{x(j),1}(7:16)];
    xposi(j)=x(j);%此為cut個日期的x座標
    end
    yposi=(ceil(min(cell2mat(wind_typhoon(:,2))))-5.5)*ones(1,cut);%此為cut個日期的y座標
    
    subplot(2,1,1);
    plot(1:m,cell2mat(wind_typhoon(:,2)),'r');%做出時間與壓力的圖
    grid on
    set(gca,'XTick',xposi);  %讓橫軸上的刻度線等於cut個日期的x座標
    set(gca,'XTickLabel',[]);%不顯示橫軸的資訊(這裡橫軸資訊是自己設定的)
    axis([0 m ceil(min(cell2mat(wind_typhoon(:,2))))-5 ceil(max(cell2mat(wind_typhoon(:,2))))]);%設定縱橫軸邊界
    title(title_typhoon);
    ylabel('氣壓 (百帕)');
    set(gca,'FontWeight','bold','fontsize',15);%設定字體大小
    %將橫軸資訊貼到圖上
    ht=text(xposi,yposi,tt,'HorizontalAlignment', 'right', 'rotation', 90,'FontWeight','bold','fontsize',10);
    
    subplot(2,1,2);
    plot(1:m,cell2mat(wind_typhoon(:,3)),'b');%做出時間與風速的圖
    grid on
    set(gca,'XTick',xposi);  %讓橫軸上的刻度線等於cut個日期的x座標
    set(gca,'XTickLabel',[]);%不顯示橫軸的資訊(這裡橫軸資訊是自己設定的)
    axis([0 m ceil(min(cell2mat(wind_typhoon(:,3))))-5 ceil(max(cell2mat(wind_typhoon(:,3))))]);%設定縱橫軸邊界
    xlabel('時間');
    ylabel('風速 (m/s)');
    set(gca,'FontWeight','bold','fontsize',15);%設定字體大小
    
end

