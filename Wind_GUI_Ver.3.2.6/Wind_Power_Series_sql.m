function [hp,total_energy] =Wind_Power_Series_sql(wind_new,wind_mysql70_ms,cut,power_curve)
    %[mm,nn]=size(wind_new);
    [nn70,mm70]=size(wind_mysql70_ms);
    
    x=ceil(linspace(1,mm70*10,cut));
    tt={};
    for j=1:cut
    tt=[tt,wind_new.dt{x(j),1}(6:16)];
    xposi(j)=x(j);
    end
    yposi=(-500)*ones(1,cut);
    
%-----------------------------------------------------------------------------------------

    subplot('position',[.56,.72,.4,.22]);
    plot(power_curve.Wind_speed_m_s,power_curve.Power_kW,'b');
    title('Power curve');
    ylabel('Power (kW)');
    xlabel('Wind speed (m/s)');
    axis([0 35 0 2500]);
    set(gca,'FontWeight','bold','fontsize',15);
    grid on;
    hold on;

%-----------------------------------------------------------------------------------------

    q=find(power_curve.Power_kW~=0);%找power_curve.Power_kW不等於0的風速值
    %power_curve.Wind_speed_m_s(q(1))=4(m/s)，第一個出現不是0kW的風速值
    %power_curve.Wind_speed_m_s(max(q))=25(m/s)，最後一個不是0kW的風速值
    max_power=power_curve.Power_kW(max(q));%將最大功率值找出來
    w=find(power_curve.Power_kW==max_power);%將最大功率對應的風速值找出來(不只一個)
    %power_curve.Wind_speed_m_s(w(1))=17(m/s)，為第一個輸出功率為2000kW的風速
    
    power_70m=zeros(mm70,1);
    total_energy=0;
    for j=1:mm70    
              %如果小於4(m/s)
       if     wind_mysql70_ms(j)<power_curve.Wind_speed_m_s(q(1))
              power_70m(j)=0;
 
              %如果大於25(m/s)
       elseif wind_mysql70_ms(j)>power_curve.Wind_speed_m_s(max(q))
              power_70m(j)=0;
              
              %如果介於17(m/s)~25(m/s)之間
       elseif power_curve.Wind_speed_m_s(w(1))<=wind_mysql70_ms(j) & wind_mysql70_ms(j)<=power_curve.Wind_speed_m_s(max(q))
              power_70m(j)=2000;
              total_energy=total_energy+power_70m(j)*60*1000;%單位:焦耳
              
       else   %如果介於4(m/s)~17(m/s)之間
              [c1,c2]=fit((floor(wind_mysql70_ms(j)):floor(wind_mysql70_ms(j))+2)',...
              power_curve.Power_kW(floor(wind_mysql70_ms(j))+1:floor(wind_mysql70_ms(j))+3),'power2');
              power_70m(j)=c1(wind_mysql70_ms(j));
              total_energy=total_energy+power_70m(j)*60*1000;%單位:焦耳
       end
   
    end

%-----------------------------------------------------------------------------------------

    subplot('position',[.11,.2,.85,.32]);
    plot(1:10:mm70*10,power_70m,'r');
    hold on
    grid on
    set(gca,'XTick',xposi);
    set(gca,'XTickLabel',[]);
    axis([0 mm70*10 0 2500]);
    xlabel('時間');      
    ylabel('Power (kW)');
    title('功率-時間序列圖');
    set(gca,'FontWeight','bold','fontsize',15);
    hp=text(xposi,yposi,tt,'HorizontalAlignment', 'right', 'rotation', 90);
    
end

