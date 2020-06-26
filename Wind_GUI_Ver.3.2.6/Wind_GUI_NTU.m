function Wind_GUI_NTU()
    clc;clear;clear all;
    global wind_int wind_new current_data_S current_data_D current_data_Std v_int val_fin alpha message
    global panel h_temp position_temp panel_temp position_paneltemp pre_message 
    global position_plot position_message position_message_h plot_botton pre_edit position_day_pop_int position_day_pop_fin   
    global fun_name pop_name val_int m choose_int choose_fin plot_num pre_num time_num power_num ht hp
    global conn position_yearsql_pop_int  position_yearsql_pop_fin position_monthsql_pop_int 
    global position_monthsql_pop_fin position_daysql_pop_int position_daysql_pop_fin position_heightsql_pop position_datesql_check
    global year_int year_fin month_int month_fin day_int day_fin wind_mysql30 wind_mysql50 wind_mysql70 
    global wind_mysql30_std wind_mysql50_std wind_mysql70_std wind_mysql30_ms wind_mysql50_ms wind_mysql70_ms
    global wind_mysql30_md wind_mysql50_md wind_mysql70_md button_color
   
%創建GUI--------------------------------------------------------------------------------------------------------------------

    f = figure('Name','Wind-Data','Menubar','none');%建立一個figure，存入變數f
    s = warning('off', 'MATLAB:uitabgroup:OldVersion');
    %創建分頁群，將它們放在f上
    tab_group = uitabgroup('Parent',f);
    warning(s);
    %製作每個分頁的名稱
    tab_name={'風速分布圖','風花圖','T.I圖','時間序列圖','風切指數圖','風速預測圖','發電量預測',...
              '颱風風況資料1','颱風風況資料2','颱風風況資料3'};
    
%製作函數的名稱--------------------------------------------------------------------------------------------------------------

    fun_name={@wind_speed_dist_Callback,...        %(01)風速分布圖的按鈕
              @wind_rose_Callback,...              %(02)風速花圖的按鈕
              @ti_Callback,...                     %(03)T.I圖的按鈕
              @time_series_Callback,...            %(04)時間序列圖的按鈕
              @wind_shear_Callback,...             %(05)風切指數圖的按鈕
              @wind_max_predict_Callback,...       %(06)風速預測圖的按鈕
              @power_series_Callback,...           %(07)功率時間序列圖的按鈕
              @conMySQL_Callback,...               %(08)連接MySQL的按鈕
              @loading_Callback,...                %(09)載入檔案的按鈕
              @height_pop_Callback,...             %(10)觀測高度下拉式選單
              @pre_botton_Callback,...             %(11)未來風速預測值的按鈕              
              @day_pop_int_Callback,...            %(12)開始時間下拉式選單
              @day_pop_fin_Callback,...            %(13)結束時間下拉式選單
              @yearsql_pop_int_Callback,...        %(14)開始年下拉式選單
              @yearsql_pop_fin_Callback,...        %(15)開始年下拉式選單
              @monthsql_pop_int_Callback,...       %(16)開始月下拉式選單
              @monthsql_pop_fin_Callback,...       %(17)開始月下拉式選單
              @daysql_pop_int_Callback,...         %(18)開始日下拉式選單
              @daysql_pop_fin_Callback,...         %(19)開始日下拉式選單
              @datesql_check_Callback,...          %(20)sql日期確認按鈕
              @heightsql_pop_Callback};            %(21)sql觀測高度下拉式選單
              
%設定GUI各個功能鍵位置大小-----------------------------------------------------------------------------------------------------
                       
    position_conMySQL=[.01,.735,.1,.06];           %連接MySQL按鈕大小位置
    position_loading=[.01,.655,.1,.06];            %載入檔案按鈕大小位置
    position_plot_botton=[.009,.595,.1005,.06];    %作圖按鈕大小位置
    position_information=[.009,.515,.1005,.06];    %風況資訊按鈕大小位置
    position_height_pop=[.011,.265,.098,.15];      %下拉式選單(觀測高度)大小位置 
    position_day_pop_int=[.011,.17,.098,.15];      %下拉式選單(開始時間)大小位置
    position_day_pop_fin=[.011,.08,.098,.15];      %下拉式選單(結束時間)大小位置       
    position_panelplot=[.13,.06,.85,.765];         %panel(作圖區)大小位置[.13,.12,.85,.71];
    position_panelplot_power=[.13,.06,.85,.92];    %panel(作圖區)大小位置[.13,.12,.85,.71];
    position_panelplot_pressure=[.13,.06,.85,.92]; %panel(作圖區)大小位置[.13,.12,.85,.71];
    position_plot=[.05,.06,.9,.9];                 %作圖圖片大小位置
    position_panelpic=[.0105,.82,.0995,.122];      %panel(logo區)大小位置
    %position_panelpic=[.0105,.812,.0995,.122];    %panel(logo區)大小位置
    position_pic=[.05,.05,.9,.9];                  %圖片(logo)大小位置  
    position_panelmessage=[.131,.842,.35,.14];     %panel(訊息顯示區)大小位置
    position_message=[.25,.3,.52,.57];             %訊息顯示大小位置[.25,.4,.5,.5]; 
    position_message_h=[.1,.12,.8,.6];             %訊息顯示(現在高度)大小位置[.1,.16,.8,.7];  
    position_pre_panel=[.492,.842,.488,.141];      %panel(未來風速預測)大小位置
    position_pre_botton=[.025,.4,.2,.45];          %未來風速預測按鈕大小位置
    position_pre_message=[.535,.28,.45,.5];        %未來風速預測訊息大小位置
    position_pre_edit=[.255,.4,.25,.43];           %未來風速預測編輯大小位置    
    position_paneltemp=[9,.057,.1,.1];             %panel(暫存作圖區)大小位置，處理後續cla reset axes的問題
    position_temp=[.05,.06,.9,.9];                 %暫存圖片大小位置
    position_lab_logo=[.47,.003,.6,.05];           %文字(lab_logo)大小位置
    position_yearsql_pop_int=[.011,.17,.044,.15];  %下拉式選單sql(開始年)大小位置
    position_yearsql_pop_fin=[.011,.08,.044,.15];  %下拉式選單sql(結束年)大小位置 
    position_monthsql_pop_int=[.061,.17,.03,.15];  %下拉式選單sql(開始月)大小位置
    position_monthsql_pop_fin=[.061,.08,.03,.15];  %下拉式選單sql(結束月)大小位置 
    position_daysql_pop_int=[.096,.17,.03,.15];    %下拉式選單sql(開始日)大小位置
    position_daysql_pop_fin=[.096,.08,.03,.15];    %下拉式選單sql(結束日)大小位置 
    position_heightsql_pop=[.011,.265,.098,.15];   %下拉式選單sql(觀測高度)大小位置 
    position_datesql_check=[.011,.12,.09,.05];     %sql日期確認按鈕大小位置 
    
    button_color=[206/255,205/255,214/255];        %設定按鈕顏色

%執行程式初始設定------------------------------------------------------------------------------------------------------------  

for i=1:7 %設定('風速分布圖','風花圖','T.I圖','時間序列圖','風切指數圖','風速預測圖','發電量預測')分頁
    
    %將分頁放在分頁群上，並且命名分頁名稱
    tab(i)  = uitab('Parent',tab_group,'Title',char(tab_name(i)));
    
    %製作panel，設定名稱、字體大小、背景顏色、放置位置、7個分頁都放、有等比例放大縮小功能(normalized)
    panel(i)= uipanel('Title','結果圖','FontSize',11,'BackgroundColor','white',...
                      'Position',position_panelplot,'Parent',tab(i),'Units','normalized'); 
          
    %製作plot_botton，設定種類(pushbutton)、名稱、字體大小、有等比例放大縮小功能、放置位置、7個分頁都放、函數關聯
    plot_botton(i)=uicontrol('Style','pushbutton', 'String','作圖','FontSize',11,'Units','normalized',...
                             'backgroundcolor',button_color,'Position',position_plot_botton,...
                             'Parent',tab(i), 'Callback',fun_name(i));

    %製作panel(i+6)，設定名稱、字體大小、放置位置、有等比例放大縮小功能、7個分頁都放(沒寫'Parent',...就是都放)
    panel(i+7) = uipanel('Title','訊息顯示區','FontSize',11,'Parent',tab(i),'Position',position_panelmessage,'Units','normalized');
    
    %製作message，設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在panel(7)的上面、字靠左對齊
    message(i)= uicontrol('Style','text','String','請先載入檔案或連接MySQL','Units','normalized','FontSize',11,...
                          'Position',position_message_h,'Parent',panel(i+7),'horizontalalignment','center');
end

%發電量作圖按鈕製作----------------------------------------------------------------------------------------------------------

    delete(plot_botton(7));%刪除發電量作圖按鈕名稱，改成載入Power curve按鈕
    delete(panel(7));      %刪除發電量結果圖，換一個新的結果圖(較大)
    %製作plot_botton，設定種類(pushbutton)、名稱、字體大小、有等比例放大縮小功能、放置位置、放在發電量分頁、函數關聯
    plot_botton(7)=uicontrol('Style','pushbutton', 'String','載入Power curve','FontSize',11,'Units','normalized',...
                             'backgroundcolor',button_color,'Position',position_plot_botton,...
                             'Parent',tab(7), 'Callback',fun_name(7));
    %製作panel，設定名稱、字體大小、背景顏色、放置位置、7個分頁都放、有等比例放大縮小功能(normalized)
    panel(7)= uipanel('Title','結果圖','FontSize',11,'BackgroundColor','white',...
                      'Position',position_panelplot_power,'Parent',tab(7),'Units','normalized');                     
                         
%程式LOGO圖片製作------------------------------------------------------------------------------------------------------------
       
    %製作panel(15)，設定名稱、放置位置、背景顏色、有等比例放大縮小功能、7個分頁都放      
    panel(15) = uipanel('Title','','Position',position_panelpic,'BackgroundColor','white','Units','normalized');        
    %製作pic(NTU logo)，放在panel(15)的上面、有等比例放大縮小功能、設定放置位置
    pic = axes('Parent',panel(15),'Units','normalized','Position',position_pic);  
    initialpath=pwd;                           %紀錄程式初始位置
    picpath=[initialpath,'\Wind_LOGO\NTU.jpg'];%程式初始位置在加\NTU.jpg=圖片所在位置
    imshow(char(picpath),'parent',pic);        %顯示該圖片

%程式LOGO文字製作------------------------------------------------------------------------------------------------------------  

    %設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、字靠左對齊
    lab_logo=uicontrol('Style','text','String',...
                       'Department of Mechanical Engineering / Reliability Engineering Laboratory',...
                       'Units','normalized','FontSize',13,...
                       'Position',position_lab_logo,'horizontalalignment','center');    
    
%載入按鈕製作----------------------------------------------------------------------------------------------------------------
    
    %製作ConMySQL，設定種類(pushbutton)、名稱、字體大小、有等比例放大縮小功能、放置位置、函數關聯 
    conMySQL = uicontrol('Style','pushbutton', 'String','連接MySQL','FontSize',11,'Units','normalized',...
                         'backgroundcolor',button_color,'Position',position_conMySQL,'Callback',fun_name(8));
          
    %製作loading，設定種類(pushbutton)、名稱、字體大小、有等比例放大縮小功能、放置位置、函數關聯 
    loading = uicontrol('Style','pushbutton', 'String','載入檔案','FontSize',11,'Units','normalized',...
                        'backgroundcolor',button_color,'Position',position_loading,'Callback',fun_name(9));
                    
%暫存圖片製作----------------------------------------------------------------------------------------------------------------
                    
    %製作panel_temp，設定名稱、字體大小、背景顏色、放置位置、只放在tab(1)上   
    panel_temp = uipanel('Title','結果圖','FontSize',11,'BackgroundColor','white',...
                         'Position',position_paneltemp,'Parent',tab(1)); 
    
    %製作h0作圖軸(axes)，放在panel(1)上、有等比例放大縮小功能、設定放置位置，沒有這行程式會出錯
    h0 = axes('Parent',panel(1),'Units','normalized','Position',position_plot);

%字體設定--------------------------------------------------------------------------------------------------------------------
                   
    set( lab_logo,'fontname','script mt bold');%'Times New Roman');
    set( conMySQL,'fontname','微軟正黑體');
    set( loading,'fontname','微軟正黑體'); 
    set( message,'fontname','微軟正黑體');
    set( panel,'fontname','微軟正黑體');
    set( plot_botton,'fontname','微軟正黑體'); 
    set( plot_botton,'Visible','off');%先讓作圖按鈕看不到
     
%取得txt檔資料庫-------------------------------------------------------------------------------------------------------------

function loading_Callback(src,evt)%載入檔案
    
initialpath=pwd;                                 %紀錄matlab初始路徑，載入檔案之後要用
[FileName,PathName]=uigetfile({'*.txt';'*.dat'});%取得載入檔案之名稱、所在路徑
cd(PathName);                                    %前往該檔案之目錄底下

%以下是在製作一個新的(標準規格)dat檔
A=importdata(FileName);%讀取dat檔並存入cell A中

if strcmp(char(A.textdata(4,1)),'""')==1%如果一樣，為非標準檔案，執行以下程式

   [m_B,n]=size(A.textdata); %取得A.textdata的行&列
   B=A.textdata(2,1);        %將A.textdata(2,1)內容存入B，此為數據資料中名稱部分
   C=char(B);                %以字串的方式存入C中
   fid=fopen('temp.dat','w');% 創建一個名叫temp.dat的文字檔，將其代碼設為fid，'w'代表要寫入
   fprintf(fid,'%s\r\n',C);  %將數據資料中名稱部分存入temp.dat

  %以下將把測得的風速資料一個一個存入temp.dat中
  for k=1:m_B-4
      for p=1:n
         if (p<n-10)
             fprintf(fid,'%s,',char(A.textdata(k+4,p)));
         else
             fprintf(fid,'%f,',A.data(k,p-(n-10)+1));
         end
      end
             fprintf(fid,'\r\n');
  end
  
  fclose(fid);%關閉檔案  

  %將檔案(FileName)中的資料存入wind<dataset>裡，以逗號分開每筆數據
  wind_int=dataset('file','temp.dat','delimiter',',', 'format',[...
                   '%s' repmat('%f',1,5) '%s' repmat('%f',1,6) '%s' repmat('%f',1,6)... 
                   '%s' repmat('%f',1,6) '%s' repmat('%f',1,6) '%s' repmat('%f',1,11)]); 
else
    
  %將檔案(FileName)中的資料存入wind<dataset>裡，以逗號分開每筆數據
  wind_int=dataset('file',FileName,'delimiter',',', 'format',[...
                   '%s' repmat('%f',1,5) '%s' repmat('%f',1,6) '%s' repmat('%f',1,6)... 
                   '%s' repmat('%f',1,6) '%s' repmat('%f',1,6) '%s' repmat('%f',1,11)]);    
end

cd(initialpath);     %回到matlab初始路徑，這樣才能執行該路徑裡的函數
[m,n]=size(wind_int);%取得wind_int數據的n(行)、m(列)

pop_name=char(wind_int.TIMESTAMP{1,1}(1:10));%取得wind_int數據裡的第一個日期，存入pop_name裡
daycheck=wind_int.TIMESTAMP{1,1}(1:10);      %取得wind_int數據裡的第一個日期，之後用來判斷日期變換

for q=2:m%讀取wind_int的日期項，之後要放入下拉式選單(開始時間)
    
     if wind_int.TIMESTAMP{q,1}(1:10)==daycheck%如果和第一個日期一樣，不做任何事
    
     else%如果和第一個日期不一樣，把它存入pop_name的下一列，此為之後的日期
         pop_name=[pop_name;char(wind_int.TIMESTAMP{q,1}(1:10))];
         %把之後的日期存到daycheck裡，之後用來判斷日期變換
         daycheck=wind_int.TIMESTAMP{q,1}(1:10);
     end
     
end

%製作靜態文字，設定種類(text)、名稱、字體大小、有等比例放大縮小功能、放置位置、字靠左對齊
uicontrol('Style','text','String','開始時間：','FontSize',11,'Units','normalized','fontname' ,'微軟正黑體',...
          'Position',[.011,.21,.098,.15],'horizontalalignment','left');
      
%製作day_pop_int，設定種類(popupmenu)、選項名稱(pop_name)、字體大小、有等比例放大縮小功能、放置位置、關聯函數        
day_pop_int = uicontrol('Style','popupmenu', 'String',pop_name,'FontSize',11,'Units','normalized',...
                        'Position',position_day_pop_int,'Callback',fun_name(12));
delete(message);
for q=1:7
   %製作message，設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在panel(q+7)的上面、字靠左對齊                 
   message(q)= uicontrol('Style','text','String','請點選觀測開始時間','Units','normalized','FontSize',11,...
                         'Position',position_message_h,'Parent',panel(q+7),'horizontalalignment','center');              
   set(message(q),'fontname','微軟正黑體');
end                    
                    
end

function day_pop_int_Callback(src,evt)%開始時間下拉式選單

val_int= get(src,'Value');%得到點選的選單項目值(項目值=1,2,3,4...)
Str_int= get(src,'String');%得到選單項目的所有內容

  for j=1:m%讀取所有wind_int的日期項
    
       if wind_int.TIMESTAMP{j,1}(1:10)==char(Str_int(val_int,1:10))%如果和使用者點到的日期一樣
          choose_int=j;%把當下讀到的列存入choose_int裡，此為使用者點到的日期的第一筆數據
          break;%跳出迴圈
       end

  end

%製作靜態文字，設定種類(text)、名稱、字體大小、有等比例放大縮小功能、放置位置、字靠左對齊
uicontrol('Style','text','String','結束時間：','FontSize',11,'Units','normalized','fontname' ,'微軟正黑體',...
          'Position',[.011,.12,.098,.15],'horizontalalignment','left');
      
%製作day_pop_fin，設定種類(popupmenu)、選項名稱(pop_name)、字體大小、有等比例放大縮小功能、放置位置、關聯函數 
day_pop_fin=uicontrol('Style','popupmenu', 'String',pop_name,'FontSize',11,'Units','normalized',...
                      'Position',position_day_pop_fin,'Callback',fun_name(13));
delete(message);

for q=1:7
   %製作message，設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在panel(7)的上面、字靠左對齊                   
   message(q)=uicontrol('Style','text','String','請點選觀測結束時間','Units','normalized','FontSize',11,...
                        'Position',position_message_h,'Parent',panel(q+7),'horizontalalignment','center');
   set(message(q), 'fontname' ,'微軟正黑體');
end

if time_num==2
delete(ht);
end

if power_num==2
delete(hp);
end   
%以下是之後判斷式要用的東西，先在這裡設置好
plot_num=1;
pre_num=1;
time_num=1;
power_num=1;
end       

function day_pop_fin_Callback(src,evt)%結束時間下拉式選單

val_fin= get(src,'Value');%得到點選的選單項目值(項目值=1,2,3,4...)
Str_fin= get(src,'String');%得到選單項目的所有內容

if (val_fin<val_int)%如果使用者點選的日期小於開始時間

t0='結束時間不可以小於開始時間';
h=dialog('name','錯誤','position',[520 300 250 100],'Units','normalized');  
uicontrol('parent',h,'style','text','string',t0,'position',[25 30 240 50],'fontsize',12,'horizontalalignment','left');  
uicontrol('parent',h,'style','pushbutton','position',[100 10 50 25],'string','OK','callback','delete(gcbf)'); 

else%其他情況
    
  for d=1:m%讀取所有wind_int的日期項
    
     if (wind_int.TIMESTAMP{d,1}(1:10)==char(Str_fin(val_fin,1:10)))%如果和使用者點到的日期一樣
        daycheck_2=wind_int.TIMESTAMP{d,1}(1:10);%把該日期存入daycheck_2，並進入第二個迴圈

        for pp=d:m%接續剛才的日期項讀取
                 %如果讀到和使用者點到的日期一樣，且不為最後一筆數據，不做任何事
                 if (wind_int.TIMESTAMP{pp,1}(1:10)==daycheck_2 & pp~=m)
                     
                 %如果讀到和使用者點到的日期一樣，且為最後一筆數據，將pp存入choose_fin裡，並跳出迴圈
                 elseif (wind_int.TIMESTAMP{pp,1}(1:10)==daycheck_2 & pp==m)
                      choose_fin=pp;
                      break;
                      
                 %如果讀到和使用者點到的日期不一樣，代表前一個數據，為使用者點到的日期的最後一筆資料，
                 %將它存入choose_fin裡，並跳出迴圈
                 else
                      choose_fin=pp-1;                   
                      break;
                 end  %if (wind_int.TIMESTAMP{pp,1}(1:10)==daycheck_2 & pp~=m)
 
         end  %for pp=d:m

     end  %if (wind_int.TIMESTAMP{d,1}(1:10)==char(Str_fin(val_fin,1:10)))

  end  %for d=1:m

wind_new=wind_int(choose_int:choose_fin,:);%將使用者想要看的數據區間(開始~結束)存入wind_new裡

%沒點選下拉式選單(30m、50m、70mE、70mW)就按作圖會出現錯誤
%以下為載入檔案後，預先存入資料的預設值(70mE的風速資料)，
%這樣子，就算沒點選下拉式選單就按作圖也會直接顯示70mE的資料
current_data_S=wind_new.WSavg_70mE;
current_data_D=wind_new.WDavg_70mE;
current_data_Std=wind_new.WS_70mE_Std;
%設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在有panel(7)的上面、字體靠左對齊 
%將原本"作圖請先載入檔案"改為"初始設定高度為70mE"
delete(message);

for p=1:7
   message(p)=uicontrol('Style','text','String','初始設定高度為70mE','Units','normalized','FontSize',11,...
                        'Position',position_message_h,'Parent',panel(p+7),'horizontalalignment','center');
   set( message(p), 'fontname' ,'微軟正黑體');
end   

if plot_num==1%第一次使用會進行以下指令，之後就不會再執行了

%製作靜態文字，設定種類(text)、名稱、字體大小、有等比例放大縮小功能、放置位置、字靠左對齊
uicontrol('Style','text','String','觀測高度：','FontSize',11,'Units','normalized','fontname','微軟正黑體',...
          'Position',[.011,.4,.098,.05],'horizontalalignment','left');
    
%製作height_pop，設定種類(popupmenu)、名稱、字體大小、有等比例放大縮小功能、放置位置、函數關聯    
height_pop=uicontrol('Style','popupmenu', 'String','70mE|70mW|50m|30m','FontSize',11,'Units','normalized',...
                     'Position',position_height_pop,'Callback',fun_name(10));

set(plot_botton,'Visible','on');%作圖按鈕可以看到了
plot_num=2;                     %讓plot_num=2這樣程式就不會再執行第二次了

end  %if plot_num==1

end  %if (val_fin<val_int)

end

function height_pop_Callback(src,evt)%觀測高度下拉式選單

val = get(src,'Value');%得到點選的選單項目值
clr = {'70mE', '70mW' ,'50m' ,'30m'};%有四種

switch clr{val}%看選到哪種，將該項目資料存入current_data_S、D、Std，之後作圖要用
case '70mE'
     current_data_S=wind_new.WSavg_70mE;
     current_data_D=wind_new.WDavg_70mE;
     current_data_Std=wind_new.WS_70mE_Std;
     for g=1:7
     %設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在有panel(7)的上面、字體靠左對齊
     uicontrol('Style','text','String','現在設定高度為70mE','Units','normalized','FontSize',11,'fontname','微軟正黑體',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
     
case '70mW'
     current_data_S=wind_new.WSavg_70mW;
     current_data_D=wind_new.WDavg_70mW;
     current_data_Std=wind_new.WS_70mW_Std;
     for g=1:7
     %設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在有panel(7)的上面、字體靠左對齊
     uicontrol('Style','text','String','現在設定高度為70mW','Units','normalized','FontSize',11,'fontname' ,'微軟正黑體',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
     
case '50m'
     current_data_S=wind_new.WSavg_50m;
     current_data_D=wind_new.WDavg_50m;
     current_data_Std=wind_new.WS_50m_Std;
     for g=1:7
     %設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在有panel(7)的上面、字體靠左對齊
     uicontrol('Style','text','String','現在設定高度為50m','Units','normalized','FontSize',11,'fontname' ,'微軟正黑體',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
     
case '30m'
     current_data_S=wind_new.WSavg_30m;
     current_data_D=wind_new.WDavg_30m;
     current_data_Std=wind_new.WS_30m_Std;
     for g=1:7
     %設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在有panel(7)的上面、字體靠左對齊
     uicontrol('Style','text','String','現在設定高度為30m','Units','normalized','FontSize',11,'fontname' ,'微軟正黑體',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
end

end

%取得MySQL資料庫-------------------------------------------------------------------------------------------------------------

function conMySQL_Callback(src,evt)%連接MySQL
    
  initialpath=pwd;                %紀錄matlab初始路徑，驅動載入要用
  driver1=[initialpath,'\JDBC\issas-mysql-connector-java-5.1.39-bin.jar'];
  driver2=[initialpath,'\JDBC\sqljdbc4-2.0.jar'];
  javaaddpath (driver1);          %一開始要把驅動載入
  javaaddpath (driver2);          %一開始要把驅動載入
      
  Options.Resize = 'on';
  Options.WindowStyle ='normal';
  default = {'','root',''};
  linenumber = 1;
  userdata=inputdlg({'資料庫名稱','使用者名稱','使用者密碼'},'MySQL連結',linenumber,default, Options);  

  conn = database(char(userdata(1)),char(userdata(2)),char(userdata(3)),'Vendor','MySQL','Server','localhost');%登入MySQL
  
  curs_start_30 = exec(conn,'SELECT dt FROM l30 limit 1'); %獲得l30的資訊
  curs_start_30 = fetch(curs_start_30);%提取mysql裡cmdev.l30的資料
  curs_end_30   = exec(conn,'SELECT dt FROM l30 order by dt desc limit 1'); %獲得l30的資訊
  curs_end_30   = fetch(curs_end_30);  %提取mysql裡cmdev.l30的資料
  
  curs_Matmo = exec(conn,['SELECT dt,WXT520_P,RMYoung_WS'...
    ' FROM l70'...
    ' WHERE dt>=' '''2014-07-22'''...
    ' AND   dt<=' '''2014-07-24''']);
  curs_Matmo = fetch(curs_Matmo);%提取170的壓力資料
  
  curs_FW = exec(conn,['SELECT dt,WXT520_P,RMYoung_WS'...
    ' FROM l70'...
    ' WHERE dt>=' '''2014-09-20'''...
    ' AND   dt<=' '''2014-09-22''']);
  curs_FW = fetch(curs_FW);%提取170的壓力資料
  
  %記得關掉
  close(curs_start_30);%記得要關掉
  close(curs_end_30);  %記得要關掉
  close(curs_Matmo);%記得要關掉
  close(curs_FW);%記得要關掉
  
  s_year=str2double(curs_start_30.Data{1,1}(1:4));%將2014字串轉為2014變數
  e_year=str2double(curs_end_30.Data{1,1}(1:4));  %將2015字串轉為2015變數
  
  cla reset;%清除前一張axes圖
  tab(8) = uitab('Parent',tab_group,'Title',char(tab_name(8)));
  %製作panel，設定名稱、字體大小、背景顏色、放置位置、有等比例放大縮小功能(normalized)
  panel(16)= uipanel('Title','結果圖','FontSize',11,'BackgroundColor','white',...
                     'Position',position_panelplot_pressure,'Parent',tab(8),'Units','normalized');
  %製作h8作圖軸(axes)，只放在panel(16)上、有等比例放大縮小功能、設定放置位置
  h8 = axes('Parent',panel(16),'Units','normalized','Position',position_plot);
  axes(h8);%讓程式知道圖要放在h8上
  title_typhoon1='麥德姆颱風 (2014/07/22~2014/07/24) 氣壓、風速對時間序列圖';
  Wind_Typhoon_sql(curs_Matmo.Data,12,title_typhoon1);
 
  tab(9) = uitab('Parent',tab_group,'Title',char(tab_name(9)));
  %製作panel，設定名稱、字體大小、背景顏色、放置位置、有等比例放大縮小功能(normalized)
  panel(17)= uipanel('Title','結果圖','FontSize',11,'BackgroundColor','white',...
                     'Position',position_panelplot_pressure,'Parent',tab(9),'Units','normalized');
  %製作h8作圖軸(axes)，只放在panel(17)上、有等比例放大縮小功能、設定放置位置
  h9 = axes('Parent',panel(17),'Units','normalized','Position',position_plot);
  axes(h9);%讓程式知道圖要放在h9上
  title_typhoon2='鳳凰颱風 (2014/09/20~2014/09/22) 氣壓、風速對時間序列圖';
  Wind_Typhoon_sql(curs_FW.Data,12,title_typhoon2);
  %------------------------------------------------------------------------------------------------
  tab(10) = uitab('Parent',tab_group,'Title',char(tab_name(10)));
  %製作panel，設定名稱、字體大小、背景顏色、放置位置、有等比例放大縮小功能(normalized)
  panel(18)= uipanel('Title','結果圖','FontSize',11,'BackgroundColor','white',...
                     'Position',position_panelplot_pressure,'Parent',tab(10),'Units','normalized');
  %製作h8作圖軸(axes)，只放在panel(18)上、有等比例放大縮小功能、設定放置位置
  h10 = axes('Parent',panel(18),'Units','normalized','Position',position_plot);
  axes(h10);%讓程式知道圖要放在h10上
  title_typhoonPDF1='麥德姆颱風 (PDF of fluctuations)';
  title_typhoonPDF2='鳳凰颱風 (PDF of fluctuations)';
  Wind_TyphoonPDF_sql(curs_Matmo.Data,curs_FW.Data,title_typhoonPDF1,title_typhoonPDF2);
  
  %------------------------------------------------------------------------------------------------
  h_temp = axes('Parent',panel_temp,'Units','normalized','Position',position_temp);
   
  pop_yname=s_year;
  
 for yd=s_year+1:e_year
     pop_yname={pop_yname;yd};
 end
 
     pop_mname={};
 for md=1:12
     if md<10
     pop_mname=[ pop_mname,num2str(md,'%02.0f')];
     else
     pop_mname=[ pop_mname,num2str(md)];
     end
 end
 
     pop_dname={};
 for dd=1:31
     if dd<10
     pop_dname=[ pop_dname,num2str(dd,'%02.0f')];
     else
     pop_dname=[ pop_dname,num2str(dd)];
     end
 end
 
delete(message);
for q=1:7
%製作message，設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在panel(7)的上面、字靠左對齊                 
message(q)= uicontrol('Style','text','String',char({'選擇觀測時間並按日期確認';'(預設值為2014/1/1~2014/1/2)'}),'Units','normalized','FontSize',10,...
                      'Position',position_message,'Parent',panel(q+7),'horizontalalignment','left');              
end
                
%製作靜態文字，設定種類(text)、名稱、字體大小、有等比例放大縮小功能、放置位置、字靠左對齊
uicontrol('Style','text','String','開始時間：','FontSize',11,'Units','normalized','fontname' ,'微軟正黑體',...
          'Position',[.011,.21,.098,.15],'horizontalalignment','left');

%製作靜態文字，設定種類(text)、名稱、字體大小、有等比例放大縮小功能、放置位置、字靠左對齊
uicontrol('Style','text','String','結束時間：','FontSize',11,'Units','normalized','fontname' ,'微軟正黑體',...
          'Position',[.011,.12,.098,.15],'horizontalalignment','left');

%製作yearsql_pop_int，設定種類(popupmenu)、選項名稱(pop_name)、字體大小、有等比例放大縮小功能、放置位置、關聯函數        
yearsql_pop_int = uicontrol('Style','popupmenu', 'String',pop_yname,'FontSize',11,'Units','normalized',...
                            'Position',position_yearsql_pop_int,'Callback',fun_name(14));
                    
%製作yearsql_pop_fin，設定種類(popupmenu)、選項名稱(pop_name)、字體大小、有等比例放大縮小功能、放置位置、關聯函數        
yearsql_pop_fin = uicontrol('Style','popupmenu', 'String',pop_yname,'FontSize',11,'Units','normalized',...
                            'Position',position_yearsql_pop_fin,'Callback',fun_name(15));

%製作monthsql_pop_int，設定種類(popupmenu)、選項名稱(pop_name)、字體大小、有等比例放大縮小功能、放置位置、關聯函數        
monthsql_pop_int = uicontrol('Style','popupmenu', 'String',pop_mname,'FontSize',11,'Units','normalized',...
                             'Position',position_monthsql_pop_int,'Callback',fun_name(16));
                    
%製作monthsql_pop_fin，設定種類(popupmenu)、選項名稱(pop_name)、字體大小、有等比例放大縮小功能、放置位置、關聯函數        
monthsql_pop_fin = uicontrol('Style','popupmenu', 'String',pop_mname,'FontSize',11,'Units','normalized',...
                             'Position',position_monthsql_pop_fin,'Callback',fun_name(17));
                    
%製作daysql_pop_int，設定種類(popupmenu)、選項名稱(pop_name)、字體大小、有等比例放大縮小功能、放置位置、關聯函數        
daysql_pop_int = uicontrol('Style','popupmenu', 'String',pop_dname,'FontSize',11,'Units','normalized',...
                           'Position',position_daysql_pop_int,'Callback',fun_name(18));
                    
%製作daysql_pop_fin，設定種類(popupmenu)、選項名稱(pop_name)、字體大小、有等比例放大縮小功能、放置位置、關聯函數        
daysql_pop_fin = uicontrol('Style','popupmenu', 'String',pop_dname,'FontSize',11,'Units','normalized',...
                           'Position',position_daysql_pop_fin,'Callback',fun_name(19));
                     
%製作datesql_check，設定種類(pushbutton)、名稱、字體大小、有等比例放大縮小功能、放置位置、6個分頁都放、函數關聯
datesql_check = uicontrol('Style','pushbutton', 'String','日期確認','FontSize',11,'Units','normalized',...
                          'backgroundcolor',button_color,'Position',position_datesql_check,'Callback',fun_name(20));
                      
set( datesql_check, 'fontname' ,'微軟正黑體'); 
set( message, 'fontname' ,'微軟正黑體');                  
                    
year_int='2014';
month_int='01';
day_int='01';
year_fin='2014';
month_fin='01';
day_fin='02';
 
end

function yearsql_pop_int_Callback(src,evt)%開始年下拉式選單
val= get(src,'Value');%得到點選的選單項目值(項目值=1,2,3,4...)
Str= get(src,'String');%得到選單項目的所有內容
year_int=Str(val);
end

function yearsql_pop_fin_Callback(src,evt)%結束年下拉式選單
val= get(src,'Value');%得到點選的選單項目值(項目值=1,2,3,4...)
Str= get(src,'String');%得到選單項目的所有內容
year_fin=Str(val);
end

function monthsql_pop_int_Callback(src,evt)%開始月下拉式選單
val= get(src,'Value');%得到點選的選單項目值(項目值=1,2,3,4...)
Str= get(src,'String');%得到選單項目的所有內容
month_int=Str(val);
end

function monthsql_pop_fin_Callback(src,evt)%結束月下拉式選單
val= get(src,'Value');%得到點選的選單項目值(項目值=1,2,3,4...)
Str= get(src,'String');%得到選單項目的所有內容
month_fin=Str(val);
end

function daysql_pop_int_Callback(src,evt)%開始日下拉式選單
val= get(src,'Value');%得到點選的選單項目值(項目值=1,2,3,4...)
Str= get(src,'String');%得到選單項目的所有內容
day_int=Str(val);
end

function daysql_pop_fin_Callback(src,evt)%結束日下拉式選單
val= get(src,'Value');%得到點選的選單項目值(項目值=1,2,3,4...)
Str= get(src,'String');%得到選單項目的所有內容
day_fin=Str(val);
end

function datesql_check_Callback(src,evt)%日期確認按鈕
%提取風速名稱
curs_name_30 = exec(conn,'DESC l30'); %獲得l30的資訊
curs_name_30 = fetch(curs_name_30);%提取mysql裡cmdev.l30的資料
curs_name_50 = exec(conn,'DESC l50'); %獲得l50的資訊
curs_name_50 = fetch(curs_name_50);%提取mysql裡cmdev.l50的資料
curs_name_70 = exec(conn,'DESC l70'); %獲得l70的資訊
curs_name_70 = fetch(curs_name_70);%提取mysql裡cmdev.l70的資料

name30=[curs_name_30.Data(1,1),curs_name_30.Data(10,1),curs_name_30.Data(11,1)];
name50=[curs_name_50.Data(1,1),curs_name_50.Data(10,1),curs_name_50.Data(11,1)];
name70=[curs_name_70.Data(1,1),curs_name_70.Data(10,1),curs_name_70.Data(11,1)];
name = [name30,name50,name70];
%風速名稱(不會有'')，要用這個才能用cell2dataset
%a={curs_name_30.Data(1,1),curs_name_30.Data(10,1),curs_name_30.Data(11,1)};%風速名稱(會有'')，這個cell2dataset會出錯
    
%提取選擇的資料
initial=['''',char(year_int),'-',char(month_int),'-',char(day_int),''''];
  final=['''',char(year_fin),'-',char(month_fin),'-',char(day_fin),''''];

curs_cho30 = exec(conn,['SELECT dt,RMYoung_WS,RMYoung_WD'...
    ' FROM l30'...%1分鐘                        %注意，第一個單引號要先空一格再打FROM
    ' WHERE dt>=' initial...                    %時間那裡第一個單引號也要先空一格再打'''2014...
    ' AND   dt<=' final]);                      %2014-01-01~2014-01-02，代表到2014-01-01的23:59:03
curs_cho30 = fetch(curs_cho30);%提取風速資料

curs_cho50 = exec(conn,['SELECT dt,RMYoung_WS,RMYoung_WD'...
    ' FROM l50'...%1分鐘                        %注意，第一個單引號要先空一格再打FROM
    ' WHERE dt>=' initial...                    %時間那裡第一個單引號也要先空一格再打'''2014...
    ' AND   dt<=' final]); 
curs_cho50 = fetch(curs_cho50);%提取風速資料

curs_cho70 = exec(conn,['SELECT dt,RMYoung_WS,RMYoung_WD'...
    ' FROM l70'...%1分鐘                        %注意，第一個單引號要先空一格再打FROM
    ' WHERE dt>=' initial...                    %時間那裡第一個單引號也要先空一格再打'''2014...
    ' AND   dt<=' final]);
curs_cho70 = fetch(curs_cho70);%提取風速資料

cho30=[curs_cho30.Data];%風速資料
cho50=[curs_cho50.Data];%風速資料
cho70=[curs_cho70.Data];%風速資料

[a30,b30]=size(cho30);
[a50,b50]=size(cho50);
[a70,b70]=size(cho70);

if     a30>a50  & a30>a70  %a30最大
       cho=[cho30,[cho50;num2cell(zeros(a30-a50,3))],[cho70;num2cell(zeros(a30-a70,3))]];       
elseif a50>a30  & a50>a70  %a50最大
       cho=[cho50,[cho30;num2cell(zeros(a50-a30,3))],[cho70;num2cell(zeros(a50-a70,3))]]; 
elseif a70>a30  & a70>a50  %a70最大
       cho=[cho70,[cho30;num2cell(zeros(a70-a30,3))],[cho50;num2cell(zeros(a70-a50,3))]]; 
elseif a30==a50 & a30==a70 %一樣大
       cho=[cho30,cho50,cho70];
elseif a70==a50 & a30>a50  %a30最大，a70=a50 
       cho=[cho30,[cho50;num2cell(zeros(a30-a50,3))],[cho70;num2cell(zeros(a30-a70,3))]]; 
elseif a30==a70 & a50>a30  %a50最大，a30=a70
       cho=[cho50,[cho30;num2cell(zeros(a50-a30,3))],[cho70;num2cell(zeros(a50-a70,3))]]; 
elseif a30==a50 & a70>a50  %a70最大，a30=a50
       cho=[cho70,[cho30;num2cell(zeros(a70-a30,3))],[cho50;num2cell(zeros(a70-a50,3))]]; 
elseif a70==a50 & a30<a50  %a30最小，a70=a50 
       cho=[cho50,cho70,[cho30;num2cell(zeros(a70-a30,3))]]; 
elseif a30==a70 & a50<a30  %a50最小，a30=a70
       cho=[cho30,cho70,[cho50;num2cell(zeros(a30-a50,3))]]; 
elseif a30==a50 & a70<a50  %a70最小，a30=a50
       cho=[cho30,cho50,[cho70;num2cell(zeros(30,3))]]; 
else
    
end

wind_cell30=[name30;cho30];%風速名稱&資料的cell
wind_cell50=[name50;cho50];%風速名稱&資料的cell
wind_cell70=[name70;cho70];%風速名稱&資料的cell
wind_cell=[name;cho];%風速名稱&資料的cell

wind_mysql30=cell2dataset(wind_cell30);%風速名稱&資料，要拿來用的
wind_mysql50=cell2dataset(wind_cell50);%風速名稱&資料，要拿來用的
wind_mysql70=cell2dataset(wind_cell70);%風速名稱&資料，要拿來用的
wind_new=cell2dataset(wind_cell);%風速名稱&資料，要拿來用的

%----------------------------------------------------------------------------

S_70=find(isnan(wind_mysql70.RMYoung_WS));%找出wind_mysql70.RMYoung_WS中的NaN
wind_mysql70.RMYoung_WS(S_70)=0;
D_70=find(isnan(wind_mysql70.RMYoung_WD));%找出wind_mysql70.RMYoung_WD中的NaN
wind_mysql70.RMYoung_WD(D_70)=0;
S_50=find(isnan(wind_mysql50.RMYoung_WS));%找出wind_mysql50.RMYoung_WS中的NaN
wind_mysql50.RMYoung_WS(S_50)=0;
D_50=find(isnan(wind_mysql50.RMYoung_WD));%找出wind_mysql50.RMYoung_WD中的NaN
wind_mysql50.RMYoung_WD(D_50)=0;
S_30=find(isnan(wind_mysql30.RMYoung_WS));%找出wind_mysql30.RMYoung_WS中的NaN
wind_mysql30.RMYoung_WS(S_30)=0;
D_30=find(isnan(wind_mysql30.RMYoung_WD));%找出wind_mysql30.RMYoung_WD中的NaN
wind_mysql70.RMYoung_WD(D_30)=0;

%----------------------------------------------------------------------------

wind_mysql30_std(1)=std(wind_mysql30.RMYoung_WS(1:10+rem(a30,10)));
wind_mysql30_ms(1)=mean(wind_mysql30.RMYoung_WS(1:10+rem(a30,10)));
wind_mysql30_md(1)=mean(wind_mysql30.RMYoung_WD(1:10+rem(a30,10)));

for ii=2:fix(a30/10)
wind_mysql30_std(ii)=std(wind_mysql30.RMYoung_WS(10*(ii-1)+rem(a30,10)+1:10*ii+rem(a30,10)));
wind_mysql30_ms(ii)=mean(wind_mysql30.RMYoung_WS(10*(ii-1)+rem(a30,10)+1:10*ii+rem(a30,10)));
wind_mysql30_md(ii)=mean(wind_mysql30.RMYoung_WD(10*(ii-1)+rem(a30,10)+1:10*ii+rem(a30,10)));
end

wind_mysql50_std(1)=std(wind_mysql50.RMYoung_WS(1:10+rem(a50,10)));
wind_mysql50_ms(1)=mean(wind_mysql50.RMYoung_WS(1:10+rem(a50,10)));
wind_mysql50_md(1)=mean(wind_mysql50.RMYoung_WD(1:10+rem(a50,10)));

for ii=2:fix(a50/10)
wind_mysql50_std(ii)=std(wind_mysql50.RMYoung_WS(10*(ii-1)+rem(a50,10)+1:10*ii+rem(a50,10)));
wind_mysql50_ms(ii)=mean(wind_mysql50.RMYoung_WS(10*(ii-1)+rem(a50,10)+1:10*ii+rem(a50,10)));
wind_mysql50_md(ii)=mean(wind_mysql50.RMYoung_WD(10*(ii-1)+rem(a50,10)+1:10*ii+rem(a50,10)));
end

wind_mysql70_std(1)=std(wind_mysql70.RMYoung_WS(1:10+rem(a70,10)));
wind_mysql70_ms(1)=mean(wind_mysql70.RMYoung_WS(1:10+rem(a70,10)));
wind_mysql70_md(1)=mean(wind_mysql70.RMYoung_WD(1:10+rem(a70,10)));

for ii=2:fix(a70/10)
wind_mysql70_std(ii)=std(wind_mysql70.RMYoung_WS(10*(ii-1)+rem(a70,10)+1:10*ii+rem(a70,10)));
wind_mysql70_ms(ii)=mean(wind_mysql70.RMYoung_WS(10*(ii-1)+rem(a70,10)+1:10*ii+rem(a70,10)));
wind_mysql70_md(ii)=mean(wind_mysql70.RMYoung_WD(10*(ii-1)+rem(a70,10)+1:10*ii+rem(a70,10)));
end

close(curs_name_30);%記得要關掉
close(curs_name_50);%記得要關掉
close(curs_name_70);%記得要關掉
close(curs_cho30);%記得要關掉
close(conn);%記得要關掉

current_data_D=wind_mysql70_md';
current_data_S=wind_mysql70_ms';
current_data_Std=wind_mysql70_std';

%製作靜態文字，設定種類(text)、名稱、字體大小、有等比例放大縮小功能、放置位置、字靠左對齊
uicontrol('Style','text','String','觀測高度：','FontSize',11,'Units','normalized','fontname' ,'微軟正黑體',...
              'Position',[.011,.4,.098,.05],'horizontalalignment','left');
%製作heightsql_pop，設定種類(popupmenu)、名稱、字體大小、有等比例放大縮小功能、放置位置、函數關聯    
heightsql_pop=uicontrol('Style','popupmenu', 'String','70m|50m|30m','FontSize',11,'Units','normalized',...
                      'Position',position_heightsql_pop,'Callback',fun_name(21));
delete(message);
for p=1:7
message=uicontrol('Style','text','String','初始設定高度為70m','Units','normalized','FontSize',11,...
                  'Position',position_message_h,'Parent',panel(p+7),'horizontalalignment','center');
set( message, 'fontname' ,'微軟正黑體');
end   

set(plot_botton,'Visible','on');%作圖按鈕可以看到了

if time_num==2
delete(ht);
end

if power_num==2
delete(hp);
end    
%以下是之後判斷式要用的東西，先在這裡設置好
plot_num=1;
pre_num=1;
time_num=1;
power_num=1;
end

function heightsql_pop_Callback(src,evt)%觀測高度下拉式選單

val = get(src,'Value');%得到點選的選單項目值
clr = {'70m', '50m' ,'30m'};%有三種

switch clr{val}%看選到哪種，將該項目資料存入current_data_S、D、Std，之後作圖要用
case '70m'

     current_data_D=wind_mysql70_md';
     current_data_S=wind_mysql70_ms';
     current_data_Std=wind_mysql70_std';
     for g=1:7
     %設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在有panel(7)的上面、字體靠左對齊
     uicontrol('Style','text','String','現在設定高度為70m','Units','normalized','FontSize',11,'fontname' ,'微軟正黑體',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
case '50m'
      
     current_data_D=wind_mysql50_md';
     current_data_S=wind_mysql50_ms';
     current_data_Std=wind_mysql50_std';
     for g=1:7
     %設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在有panel(7)的上面、字體靠左對齊
     uicontrol('Style','text','String','現在設定高度為50m','Units','normalized','FontSize',11,'fontname' ,'微軟正黑體',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
case '30m'
     
     current_data_D=wind_mysql30_md';
     current_data_S=wind_mysql30_ms';
     current_data_Std=wind_mysql30_std';
     for g=1:7
     %設定種類(text)、名稱、有等比例放大縮小功能、字體大小、放置位置、放在有panel(7)的上面、字體靠左對齊
     uicontrol('Style','text','String','現在設定高度為30m','Units','normalized','FontSize',11,'fontname' ,'微軟正黑體',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
end

end

%繪圖函數--------------------------------------------------------------------------------------------------------------------

function wind_speed_dist_Callback(src,evt)%風速分布圖
%以下作圖
cla reset;%清除前一張axes圖
%製作h1作圖軸(axes)，只放在panel(1)上、有等比例放大縮小功能、設定放置位置
h1 = axes('Parent',panel(1),'Units','normalized','Position',position_plot);
axes(h1);%讓程式知道圖要放在h1上

[mm,n]=size(current_data_S);%得到current_data_S的行列

[p1,p2]=Wind_Speed_Dist(current_data_S,mm);

%製作h_temp作圖軸(axes)，只放在panel_temp上、有等比例放大縮小功能、設定放置位置
%這樣子有用到cla reset的時候，只會清除這張，不會清掉已經畫好的圖
h_temp = axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%製作風況資訊
uicontrol('Style','pushbutton', 'String','風況資訊','FontSize',11,'fontname' ,'微軟正黑體','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(1),'Callback',@wind_speed_dist_information);

%風況資訊函數
function wind_speed_dist_information(src,evt)%風況資訊函數
%標出韋伯參數   
t1=['尺度參數：' num2str(p1)];
t2=['形狀參數：' num2str(p2)];
t3={t1;t2};
h=dialog('name','韋伯參數','position',[520 300 250 100],'Units','normalized');  
uicontrol('parent',h,'style','text','string',t3,'position',[60 35 240 50],'fontsize',12,'horizontalalignment','left');  
uicontrol('parent',h,'style','pushbutton','position',[100 10 50 25],'string','OK','callback','delete(gcbf)','backgroundcolor',button_color);  
end

end

function wind_rose_Callback(src,evt)%風花圖
%以下作圖
cla reset;%清除前一張axes圖
%製作h2作圖軸(axes)，只放在panel(2)上、有等比例放大縮小功能、設定放置位置
h2 = axes('Parent',panel(2),'Units','normalized','Position',position_plot);
axes(h2);%讓程式知道圖要放在h2上

subplot(1,1,1);
%0:22.5:360代表要分360/22.5=16個區塊，2.5:5:42.5代表風速的區間，[15 25 35 45]代表%數的區間
Wind_Rose(gca,current_data_D,current_data_S,0:22.5:360, 2.5:5:42.5, [15 25 35 45], '彰濱地區風花圖');   

%製作h_temp作圖軸(axes)，只放在panel_temp上、有等比例放大縮小功能、設定放置位置
%這樣子有用到cla reset的時候，只會清除這張，不會清掉已經畫好的圖
h_temp=  axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%製作風況資訊
uicontrol('Style','pushbutton', 'String','風況資訊','FontSize',11,'fontname' ,'微軟正黑體','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(2),'Callback',@wind_rose_information);
      
function wind_rose_information(src,evt)%風況資訊函數
end

end

function ti_Callback(src,evt)%T.I圖
%以下作圖
cla reset;%清除前一張axes圖
%製作h3作圖軸(axes)，只放在panel(3)上、有等比例放大縮小功能、設定放置位置
h3= axes('Parent',panel(3),'Units','normalized','Position',position_plot);
axes(h3);%讓程式知道圖要放在h3上

Wind_TI(current_data_S,current_data_Std);

%製作h_temp作圖軸(axes)，只放在panel_temp上、有等比例放大縮小功能、設定放置位置
%這樣子有用到cla reset的時候，只會清除這張，不會清掉已經畫好的圖
h_temp=  axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%製作風況資訊
uicontrol('Style','pushbutton', 'String','風況資訊','FontSize',11,'fontname' ,'微軟正黑體','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(3),'Callback',@ti_information);

function ti_information(src,evt)%風況資訊函數
end

end

function time_series_Callback(src,evt)%時間序列圖power_series_Callbac

if time_num==1
%製作h4作圖軸(axes)，只放在panel(4)上、有等比例放大縮小功能、設定放置位置
h4 = axes('Parent',panel(4),'Units','normalized','Position',position_plot);
axes(h4);%讓程式知道圖要放在h4上

[mm,nn]=size(wind_new);

if nn==9%MySQL的資料

if      mm<1440 | mm==1440 
        cut=12;
        ht=Wind_Time_Series_sql(wind_mysql30,wind_mysql50,wind_mysql70,wind_new,cut); 
elseif  1440<mm | mm==10080 | mm<10080
        cut=7;
        ht=Wind_Time_Series_sql(wind_mysql30,wind_mysql50,wind_mysql70,wind_new,cut); 
elseif  10080<mm | mm==44640 | mm<44640
        cut=5;
        ht=Wind_Time_Series_sql(wind_mysql30,wind_mysql50,wind_mysql70,wind_new,cut);
else  
        cut=4;
        ht=Wind_Time_Series_sql(wind_mysql30,wind_mysql50,wind_mysql70,wind_new,cut);
end     %if mm<144 & mm==144 
 
else    %txt的資料

if      mm<144 | mm==144   
        cut=12;
        ht=Wind_Time_Series(wind_new,mm,cut);   
elseif  144<mm | mm==1008 | mm<1008
        cut=7;
        ht=Wind_Time_Series(wind_new,mm,cut);  
elseif  1008<mm | mm==4464 | mm<4464
        cut=5;
        ht=Wind_Time_Series(wind_new,mm,cut);  
else  
        cut=4;
        ht=Wind_Time_Series(wind_new,mm,cut);
    
end     %if mm<144 | mm==144 
end     %if nn==9
end     %if time_num==1

%製作h_temp作圖軸(axes)，只放在panel_temp上、有等比例放大縮小功能、設定放置位置
%這樣子有用到cla reset的時候，只會清除這張，不會清掉已經畫好的圖
h_temp = axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%製作風況資訊
uicontrol('Style','pushbutton', 'String','風況資訊','FontSize',11,'fontname' ,'微軟正黑體','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(4),'Callback',@time_series_information);
time_num=2;

function time_series_information(src,evt)%風況資訊函數
  if nn==9 %MySQL的資料
  
  else %txt的資料  
  txt='2015/06/12~2015/06/26沒有資料';
  h=dialog('name','缺失日期','position',[520 300 250 100],'Units','normalized');  
  uicontrol('parent',h,'style','text','string',txt,'position',[7 20 240 55],'fontsize',12,'horizontalalignment','center');  
  uicontrol('parent',h,'style','pushbutton','position',[100 8 50 25],'string','OK','callback','delete(gcbf)','backgroundcolor',button_color);  
  
  end
  
  end

end

function wind_shear_Callback(src,evt)%風切指數圖
%以下計算作圖
%製作h5作圖軸(axes)，只放在panel(5)上、有等比例放大縮小功能、設定放置位置
h5 = axes('Parent',panel(5),'Units','normalized','Position',position_plot);
axes(h5);%讓程式知道圖要放在h5上

alpha_shear=Wind_Shear(wind_new);

%製作h_temp作圖軸(axes)，只放在panel_temp上、有等比例放大縮小功能、設定放置位置
%這樣子有用到cla reset的時候，只會清除這張，不會清掉已經畫好的圖
h_temp=  axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%製作風況資訊
uicontrol('Style','pushbutton', 'String','風況資訊','FontSize',11,'fontname' ,'微軟正黑體','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(5),'Callback',@wind_shear_information);

function wind_shear_information(src,evt)%風況資訊函數
%顯示風況資料
alpha_new=['風切指數 (Alpha) = ',num2str(alpha_shear)];
h=dialog('name','風切指數','position',[520 300 250 100],'Units','normalized');  
uicontrol('parent',h,'style','text','string',alpha_new,'position',[35 30 240 50],'fontsize',12,'horizontalalignment','left');  
uicontrol('parent',h,'style','pushbutton','position',[100 10 50 25],'string','OK','callback','delete(gcbf)','backgroundcolor',button_color);  
end 

end

function wind_max_predict_Callback(src,evt)%最大風速預測圖
%以下計算作圖
%製作h5作圖軸(axes)，只放在panel(5)上、有等比例放大縮小功能、設定放置位置
h6 = axes('Parent',panel(6),'Units','normalized','Position',position_plot);
axes(h6);%讓程式知道圖要放在h6上

[mm,nn]=size(wind_new);
if nn==9%mysql
 datanum=mm;
 daynum_int=[char(month_int),'/',char(day_int),'/',char(year_int)];
 daynum_fin=[char(month_fin),'/',char(day_fin),'/',char(year_fin)];
 daynum=daysact(daynum_int,daynum_fin);
else
daynum=val_fin-val_int+1;
datanum=choose_fin-choose_int+1;
end
[p,v_int,alpha]=Wind_Max_Predict(wind_new,daynum,datanum);

if pre_num==1%第一次使用會進行以下指令，之後就不會再執行了

        %製作panel(17)，設定名稱、字體大小、放置位置、有等比例放大縮小功能、只放在tab(6)上     
        panel(19) = uipanel('Title','未來最大風速預測','FontSize',11,...
              'Position',position_pre_panel,'Units','normalized','Parent',tab(6));   
        %製作pre_edit，設定種類(edit)、名稱、字體大小、有等比例放大縮小功能、背景顏色、放置位置、放在有panel(9)的上面    
        pre_edit = uicontrol('Style','edit','String','','FontSize',11,'Units','normalized','BackgroundColor','white',...
              'Position',position_pre_edit,'Parent',panel(19));
        %製作pre_edit，設定種類(pushbutton)、名稱、字體大小、有等比例放大縮小功能、放置位置、放在有panel(9)的上面、函數關聯
        pre_botton  = uicontrol('Style','pushbutton', 'String','點我預測','FontSize',11,'Units','normalized',...
        'backgroundcolor',button_color,'Position',position_pre_botton,'Parent',panel(19), 'Callback',fun_name(11));
        %製作pre_edit，設定種類(text)、名稱、字體大小、有等比例放大縮小功能、放置位置、放在有panel(9)的上面、字體靠左對齊 
        pre_message = uicontrol('Style','text','String','請在空白處輸入年份(阿拉伯數字)','FontSize',11,'Units','normalized',...
              'Position',position_pre_message,'Parent',panel(19),'horizontalalignment','left');
        set( panel(19), 'fontname' ,'微軟正黑體');        
        set( pre_botton, 'fontname' ,'微軟正黑體');        
        set( pre_message, 'fontname' ,'微軟正黑體'); 
        pre_num=2;%讓pre_num=2這樣程式就不會再執行第二次了

end

%製作h_temp作圖軸(axes)，只放在panel_temp上、有等比例放大縮小功能、設定放置位置
%這樣子有用到cla reset的時候，只會清除這張，不會清掉已經畫好的圖
h_temp=  axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%製作風況資訊
uicontrol('Style','pushbutton', 'String','風況資訊','FontSize',11,'fontname' ,'微軟正黑體','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(6),'Callback',@wind_max_predict_information);

function wind_max_predict_information(src,evt)%風況資訊函數
%顯示風況資料
txt1='Gumbel straight line：';
txt2=['y=',num2str(p(1)),'*x+',num2str(p(2))];
txt={txt1;'';txt2};
h=dialog('name','預測方程式','position',[520 300 250 100],'Units','normalized');  
uicontrol('parent',h,'style','text','string',txt,'position',[10 40 240 55],'fontsize',12,'horizontalalignment','center');  
uicontrol('parent',h,'style','pushbutton','position',[100 8 50 25],'string','OK','callback','delete(gcbf)','backgroundcolor',button_color);  
end  
      
end

function pre_botton_Callback(src,evt)%最大風速預測按鈕
    
%preday =get(pre_edit,'String');%得到編輯區的值(輸入的天數)
preyear =get(pre_edit,'String');%得到編輯區的值(輸入的年份)

if isempty(str2num(preyear))~=0% or isempty(str2num(preday))==1，當輸入值不為數字時
   h=errordlg('空白處只允許阿拉伯數字','錯誤');  
   ha=get(h,'children');  
   set(h,'Units','normalized','position',[.365 .5 .27 .15])
   hu=findall(allchild(h),'style','pushbutton');  
   set(hu,'string','OK','Units','normalized','position',[.38 .08 .25 .25],'backgroundcolor',button_color);  
   htype=findall(ha,'type','text');  
   set(htype,'fontsize',12.5,'Units','normalized');
   set(pre_message, 'String','');

else
preyear=str2double(preyear);
%prespeed=v_int+alpha*log(preday/210);天
prespeed=v_int+alpha*log(preyear/210*365);
prespeed=['預測第',num2str(preyear),'年的最大風速為',num2str(prespeed),'(m/s)'];
set(pre_message, 'String',num2str(prespeed));   
end 

end

function power_series_Callback(src,evt)%發電量預測圖

if power_num==1
%製作h7作圖軸(axes)，只放在panel(7)上、有等比例放大縮小功能、設定放置位置
h7 = axes('Parent',panel(7),'Units','normalized','Position',position_plot);
axes(h7);%讓程式知道圖要放在h7上

initialpath=pwd;                                 %紀錄matlab初始路徑，載入檔案之後要用
[FileName,PathName]=uigetfile({'*.txt';'*.dat'});%取得載入檔案之名稱、所在路徑
cd(PathName); 
%以下是在讀取power_curve檔
%將檔案(FileName)中的資料存入power_curve<dataset>裡，以逗號分開每筆數據
power_curve=dataset('file',FileName,'delimiter',',', 'format',repmat('%f',1,2)); 
cd(initialpath);                                 %回去matlab初始路徑

%建立表格、只在panel(7)上、可等比例放大縮小、放置位置、列的名稱、資料
uitable('Parent',panel(7),'units','Normalized','position',[.05,.72,.4,.22],'RowName',{'Wind speed (m/s)', 'Power (kW)'},...
        'data',[power_curve.Wind_speed_m_s(:)';power_curve.Power_kW(:)']);
    
[mm,nn]=size(wind_new);

if nn==9%MySQL的資料

if      mm<1440 | mm==1440 
        cut=12;
        [hp,total_energy]=Wind_Power_Series_sql(wind_new,wind_mysql70_ms,cut,power_curve); 
elseif  1440<mm | mm==10080 | mm<10080
        cut=7;
        [hp,total_energy]=Wind_Power_Series_sql(wind_new,wind_mysql70_ms,cut,power_curve); 
elseif  10080<mm | mm==44640 | mm<44640
        cut=5;
        [hp,total_energy]=Wind_Power_Series_sql(wind_new,wind_mysql70_ms,cut,power_curve);
else  
        cut=4;
        [hp,total_energy]=Wind_Power_Series_sql(wind_new,wind_mysql70_ms,cut,power_curve);
end     %if mm<144 & mm==144 
 
else    %txt的資料

if      mm<144 | mm==144   
        cut=12;
        [hp,total_energy]=Wind_Power_Series(wind_new,mm,cut,power_curve);   
elseif  144<mm | mm==1008 | mm<1008
        cut=7;
        [hp,total_energy]=Wind_Power_Series(wind_new,mm,cut,power_curve);  
elseif  1008<mm | mm==4464 | mm<4464
        cut=5;
        [hp,total_energy]=Wind_Power_Series(wind_new,mm,cut,power_curve);  
else  
        cut=4;
        [hp,total_energy]=Wind_Power_Series(wind_new,mm,cut,power_curve);
    
end     %if mm<144 | mm==144 
end     %if nn==9
end     %if power_num==1

%製作h_temp作圖軸(axes)，只放在panel_temp上、有等比例放大縮小功能、設定放置位置
%這樣子有用到cla reset的時候，只會清除這張，不會清掉已經畫好的圖
h_temp = axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%製作風況資訊
uicontrol('Style','pushbutton', 'String','風況資訊','FontSize',11,'fontname' ,'微軟正黑體','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(7),'Callback',@power_series_information);
power_num=2;

function power_series_information(src,evt)%風況資訊函數

%顯示總發電量   
t1=['總發電量為' num2str(total_energy/10^6),'(MJ)'];
t2=['相當於有' num2str(total_energy/(3.6*10^6)),'度電'];
t3={t1;t2};
h=dialog('name','期間總發電量','position',[470 300 350 100],'Units','normalized');  
uicontrol('parent',h,'style','text','string',t3,'position',[80 35 240 50],'fontsize',12,'horizontalalignment','left');  
uicontrol('parent',h,'style','pushbutton','position',[150 10 50 25],'string','OK','callback','delete(gcbf)','backgroundcolor',button_color);  
end

end
end
