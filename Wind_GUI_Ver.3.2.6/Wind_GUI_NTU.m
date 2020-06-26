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
   
%�Ы�GUI--------------------------------------------------------------------------------------------------------------------

    f = figure('Name','Wind-Data','Menubar','none');%�إߤ@��figure�A�s�J�ܼ�f
    s = warning('off', 'MATLAB:uitabgroup:OldVersion');
    %�Ыؤ����s�A�N���̩�bf�W
    tab_group = uitabgroup('Parent',f);
    warning(s);
    %�s�@�C�Ӥ������W��
    tab_name={'���t������','�����','T.I��','�ɶ��ǦC��','�������ƹ�','���t�w����','�o�q�q�w��',...
              '�䭷���p���1','�䭷���p���2','�䭷���p���3'};
    
%�s�@��ƪ��W��--------------------------------------------------------------------------------------------------------------

    fun_name={@wind_speed_dist_Callback,...        %(01)���t�����Ϫ����s
              @wind_rose_Callback,...              %(02)���t��Ϫ����s
              @ti_Callback,...                     %(03)T.I�Ϫ����s
              @time_series_Callback,...            %(04)�ɶ��ǦC�Ϫ����s
              @wind_shear_Callback,...             %(05)�������ƹϪ����s
              @wind_max_predict_Callback,...       %(06)���t�w���Ϫ����s
              @power_series_Callback,...           %(07)�\�v�ɶ��ǦC�Ϫ����s
              @conMySQL_Callback,...               %(08)�s��MySQL�����s
              @loading_Callback,...                %(09)���J�ɮת����s
              @height_pop_Callback,...             %(10)�[�����פU�Ԧ����
              @pre_botton_Callback,...             %(11)���ӭ��t�w���Ȫ����s              
              @day_pop_int_Callback,...            %(12)�}�l�ɶ��U�Ԧ����
              @day_pop_fin_Callback,...            %(13)�����ɶ��U�Ԧ����
              @yearsql_pop_int_Callback,...        %(14)�}�l�~�U�Ԧ����
              @yearsql_pop_fin_Callback,...        %(15)�}�l�~�U�Ԧ����
              @monthsql_pop_int_Callback,...       %(16)�}�l��U�Ԧ����
              @monthsql_pop_fin_Callback,...       %(17)�}�l��U�Ԧ����
              @daysql_pop_int_Callback,...         %(18)�}�l��U�Ԧ����
              @daysql_pop_fin_Callback,...         %(19)�}�l��U�Ԧ����
              @datesql_check_Callback,...          %(20)sql����T�{���s
              @heightsql_pop_Callback};            %(21)sql�[�����פU�Ԧ����
              
%�]�wGUI�U�ӥ\�����m�j�p-----------------------------------------------------------------------------------------------------
                       
    position_conMySQL=[.01,.735,.1,.06];           %�s��MySQL���s�j�p��m
    position_loading=[.01,.655,.1,.06];            %���J�ɮ׫��s�j�p��m
    position_plot_botton=[.009,.595,.1005,.06];    %�@�ϫ��s�j�p��m
    position_information=[.009,.515,.1005,.06];    %���p��T���s�j�p��m
    position_height_pop=[.011,.265,.098,.15];      %�U�Ԧ����(�[������)�j�p��m 
    position_day_pop_int=[.011,.17,.098,.15];      %�U�Ԧ����(�}�l�ɶ�)�j�p��m
    position_day_pop_fin=[.011,.08,.098,.15];      %�U�Ԧ����(�����ɶ�)�j�p��m       
    position_panelplot=[.13,.06,.85,.765];         %panel(�@�ϰ�)�j�p��m[.13,.12,.85,.71];
    position_panelplot_power=[.13,.06,.85,.92];    %panel(�@�ϰ�)�j�p��m[.13,.12,.85,.71];
    position_panelplot_pressure=[.13,.06,.85,.92]; %panel(�@�ϰ�)�j�p��m[.13,.12,.85,.71];
    position_plot=[.05,.06,.9,.9];                 %�@�ϹϤ��j�p��m
    position_panelpic=[.0105,.82,.0995,.122];      %panel(logo��)�j�p��m
    %position_panelpic=[.0105,.812,.0995,.122];    %panel(logo��)�j�p��m
    position_pic=[.05,.05,.9,.9];                  %�Ϥ�(logo)�j�p��m  
    position_panelmessage=[.131,.842,.35,.14];     %panel(�T����ܰ�)�j�p��m
    position_message=[.25,.3,.52,.57];             %�T����ܤj�p��m[.25,.4,.5,.5]; 
    position_message_h=[.1,.12,.8,.6];             %�T�����(�{�b����)�j�p��m[.1,.16,.8,.7];  
    position_pre_panel=[.492,.842,.488,.141];      %panel(���ӭ��t�w��)�j�p��m
    position_pre_botton=[.025,.4,.2,.45];          %���ӭ��t�w�����s�j�p��m
    position_pre_message=[.535,.28,.45,.5];        %���ӭ��t�w���T���j�p��m
    position_pre_edit=[.255,.4,.25,.43];           %���ӭ��t�w���s��j�p��m    
    position_paneltemp=[9,.057,.1,.1];             %panel(�Ȧs�@�ϰ�)�j�p��m�A�B�z����cla reset axes�����D
    position_temp=[.05,.06,.9,.9];                 %�Ȧs�Ϥ��j�p��m
    position_lab_logo=[.47,.003,.6,.05];           %��r(lab_logo)�j�p��m
    position_yearsql_pop_int=[.011,.17,.044,.15];  %�U�Ԧ����sql(�}�l�~)�j�p��m
    position_yearsql_pop_fin=[.011,.08,.044,.15];  %�U�Ԧ����sql(�����~)�j�p��m 
    position_monthsql_pop_int=[.061,.17,.03,.15];  %�U�Ԧ����sql(�}�l��)�j�p��m
    position_monthsql_pop_fin=[.061,.08,.03,.15];  %�U�Ԧ����sql(������)�j�p��m 
    position_daysql_pop_int=[.096,.17,.03,.15];    %�U�Ԧ����sql(�}�l��)�j�p��m
    position_daysql_pop_fin=[.096,.08,.03,.15];    %�U�Ԧ����sql(������)�j�p��m 
    position_heightsql_pop=[.011,.265,.098,.15];   %�U�Ԧ����sql(�[������)�j�p��m 
    position_datesql_check=[.011,.12,.09,.05];     %sql����T�{���s�j�p��m 
    
    button_color=[206/255,205/255,214/255];        %�]�w���s�C��

%����{����l�]�w------------------------------------------------------------------------------------------------------------  

for i=1:7 %�]�w('���t������','�����','T.I��','�ɶ��ǦC��','�������ƹ�','���t�w����','�o�q�q�w��')����
    
    %�N������b�����s�W�A�åB�R�W�����W��
    tab(i)  = uitab('Parent',tab_group,'Title',char(tab_name(i)));
    
    %�s�@panel�A�]�w�W�١B�r��j�p�B�I���C��B��m��m�B7�Ӥ�������B������ҩ�j�Y�p�\��(normalized)
    panel(i)= uipanel('Title','���G��','FontSize',11,'BackgroundColor','white',...
                      'Position',position_panelplot,'Parent',tab(i),'Units','normalized'); 
          
    %�s�@plot_botton�A�]�w����(pushbutton)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B7�Ӥ�������B������p
    plot_botton(i)=uicontrol('Style','pushbutton', 'String','�@��','FontSize',11,'Units','normalized',...
                             'backgroundcolor',button_color,'Position',position_plot_botton,...
                             'Parent',tab(i), 'Callback',fun_name(i));

    %�s�@panel(i+6)�A�]�w�W�١B�r��j�p�B��m��m�B������ҩ�j�Y�p�\��B7�Ӥ�������(�S�g'Parent',...�N�O����)
    panel(i+7) = uipanel('Title','�T����ܰ�','FontSize',11,'Parent',tab(i),'Position',position_panelmessage,'Units','normalized');
    
    %�s�@message�A�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��bpanel(7)���W���B�r�a�����
    message(i)= uicontrol('Style','text','String','�Х����J�ɮשγs��MySQL','Units','normalized','FontSize',11,...
                          'Position',position_message_h,'Parent',panel(i+7),'horizontalalignment','center');
end

%�o�q�q�@�ϫ��s�s�@----------------------------------------------------------------------------------------------------------

    delete(plot_botton(7));%�R���o�q�q�@�ϫ��s�W�١A�令���JPower curve���s
    delete(panel(7));      %�R���o�q�q���G�ϡA���@�ӷs�����G��(���j)
    %�s�@plot_botton�A�]�w����(pushbutton)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B��b�o�q�q�����B������p
    plot_botton(7)=uicontrol('Style','pushbutton', 'String','���JPower curve','FontSize',11,'Units','normalized',...
                             'backgroundcolor',button_color,'Position',position_plot_botton,...
                             'Parent',tab(7), 'Callback',fun_name(7));
    %�s�@panel�A�]�w�W�١B�r��j�p�B�I���C��B��m��m�B7�Ӥ�������B������ҩ�j�Y�p�\��(normalized)
    panel(7)= uipanel('Title','���G��','FontSize',11,'BackgroundColor','white',...
                      'Position',position_panelplot_power,'Parent',tab(7),'Units','normalized');                     
                         
%�{��LOGO�Ϥ��s�@------------------------------------------------------------------------------------------------------------
       
    %�s�@panel(15)�A�]�w�W�١B��m��m�B�I���C��B������ҩ�j�Y�p�\��B7�Ӥ�������      
    panel(15) = uipanel('Title','','Position',position_panelpic,'BackgroundColor','white','Units','normalized');        
    %�s�@pic(NTU logo)�A��bpanel(15)���W���B������ҩ�j�Y�p�\��B�]�w��m��m
    pic = axes('Parent',panel(15),'Units','normalized','Position',position_pic);  
    initialpath=pwd;                           %�����{����l��m
    picpath=[initialpath,'\Wind_LOGO\NTU.jpg'];%�{����l��m�b�[\NTU.jpg=�Ϥ��Ҧb��m
    imshow(char(picpath),'parent',pic);        %��ܸӹϤ�

%�{��LOGO��r�s�@------------------------------------------------------------------------------------------------------------  

    %�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B�r�a�����
    lab_logo=uicontrol('Style','text','String',...
                       'Department of Mechanical Engineering / Reliability Engineering Laboratory',...
                       'Units','normalized','FontSize',13,...
                       'Position',position_lab_logo,'horizontalalignment','center');    
    
%���J���s�s�@----------------------------------------------------------------------------------------------------------------
    
    %�s�@ConMySQL�A�]�w����(pushbutton)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B������p 
    conMySQL = uicontrol('Style','pushbutton', 'String','�s��MySQL','FontSize',11,'Units','normalized',...
                         'backgroundcolor',button_color,'Position',position_conMySQL,'Callback',fun_name(8));
          
    %�s�@loading�A�]�w����(pushbutton)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B������p 
    loading = uicontrol('Style','pushbutton', 'String','���J�ɮ�','FontSize',11,'Units','normalized',...
                        'backgroundcolor',button_color,'Position',position_loading,'Callback',fun_name(9));
                    
%�Ȧs�Ϥ��s�@----------------------------------------------------------------------------------------------------------------
                    
    %�s�@panel_temp�A�]�w�W�١B�r��j�p�B�I���C��B��m��m�B�u��btab(1)�W   
    panel_temp = uipanel('Title','���G��','FontSize',11,'BackgroundColor','white',...
                         'Position',position_paneltemp,'Parent',tab(1)); 
    
    %�s�@h0�@�϶b(axes)�A��bpanel(1)�W�B������ҩ�j�Y�p�\��B�]�w��m��m�A�S���o��{���|�X��
    h0 = axes('Parent',panel(1),'Units','normalized','Position',position_plot);

%�r��]�w--------------------------------------------------------------------------------------------------------------------
                   
    set( lab_logo,'fontname','script mt bold');%'Times New Roman');
    set( conMySQL,'fontname','�L�n������');
    set( loading,'fontname','�L�n������'); 
    set( message,'fontname','�L�n������');
    set( panel,'fontname','�L�n������');
    set( plot_botton,'fontname','�L�n������'); 
    set( plot_botton,'Visible','off');%�����@�ϫ��s�ݤ���
     
%���otxt�ɸ�Ʈw-------------------------------------------------------------------------------------------------------------

function loading_Callback(src,evt)%���J�ɮ�
    
initialpath=pwd;                                 %����matlab��l���|�A���J�ɮפ���n��
[FileName,PathName]=uigetfile({'*.txt';'*.dat'});%���o���J�ɮפ��W�١B�Ҧb���|
cd(PathName);                                    %�e�����ɮפ��ؿ����U

%�H�U�O�b�s�@�@�ӷs��(�зǳW��)dat��
A=importdata(FileName);%Ū��dat�ɨæs�Jcell A��

if strcmp(char(A.textdata(4,1)),'""')==1%�p�G�@�ˡA���D�з��ɮסA����H�U�{��

   [m_B,n]=size(A.textdata); %���oA.textdata����&�C
   B=A.textdata(2,1);        %�NA.textdata(2,1)���e�s�JB�A�����ƾڸ�Ƥ��W�ٳ���
   C=char(B);                %�H�r�ꪺ�覡�s�JC��
   fid=fopen('temp.dat','w');% �Ыؤ@�ӦW�stemp.dat����r�ɡA�N��N�X�]��fid�A'w'�N��n�g�J
   fprintf(fid,'%s\r\n',C);  %�N�ƾڸ�Ƥ��W�ٳ����s�Jtemp.dat

  %�H�U�N����o�����t��Ƥ@�Ӥ@�Ӧs�Jtemp.dat��
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
  
  fclose(fid);%�����ɮ�  

  %�N�ɮ�(FileName)������Ʀs�Jwind<dataset>�̡A�H�r�����}�C���ƾ�
  wind_int=dataset('file','temp.dat','delimiter',',', 'format',[...
                   '%s' repmat('%f',1,5) '%s' repmat('%f',1,6) '%s' repmat('%f',1,6)... 
                   '%s' repmat('%f',1,6) '%s' repmat('%f',1,6) '%s' repmat('%f',1,11)]); 
else
    
  %�N�ɮ�(FileName)������Ʀs�Jwind<dataset>�̡A�H�r�����}�C���ƾ�
  wind_int=dataset('file',FileName,'delimiter',',', 'format',[...
                   '%s' repmat('%f',1,5) '%s' repmat('%f',1,6) '%s' repmat('%f',1,6)... 
                   '%s' repmat('%f',1,6) '%s' repmat('%f',1,6) '%s' repmat('%f',1,11)]);    
end

cd(initialpath);     %�^��matlab��l���|�A�o�ˤ~�����Ӹ��|�̪����
[m,n]=size(wind_int);%���owind_int�ƾڪ�n(��)�Bm(�C)

pop_name=char(wind_int.TIMESTAMP{1,1}(1:10));%���owind_int�ƾڸ̪��Ĥ@�Ӥ���A�s�Jpop_name��
daycheck=wind_int.TIMESTAMP{1,1}(1:10);      %���owind_int�ƾڸ̪��Ĥ@�Ӥ���A����ΨӧP�_����ܴ�

for q=2:m%Ū��wind_int��������A����n��J�U�Ԧ����(�}�l�ɶ�)
    
     if wind_int.TIMESTAMP{q,1}(1:10)==daycheck%�p�G�M�Ĥ@�Ӥ���@�ˡA���������
    
     else%�p�G�M�Ĥ@�Ӥ�����@�ˡA�⥦�s�Jpop_name���U�@�C�A�������᪺���
         pop_name=[pop_name;char(wind_int.TIMESTAMP{q,1}(1:10))];
         %�⤧�᪺����s��daycheck�̡A����ΨӧP�_����ܴ�
         daycheck=wind_int.TIMESTAMP{q,1}(1:10);
     end
     
end

%�s�@�R�A��r�A�]�w����(text)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B�r�a�����
uicontrol('Style','text','String','�}�l�ɶ��G','FontSize',11,'Units','normalized','fontname' ,'�L�n������',...
          'Position',[.011,.21,.098,.15],'horizontalalignment','left');
      
%�s�@day_pop_int�A�]�w����(popupmenu)�B�ﶵ�W��(pop_name)�B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B���p���        
day_pop_int = uicontrol('Style','popupmenu', 'String',pop_name,'FontSize',11,'Units','normalized',...
                        'Position',position_day_pop_int,'Callback',fun_name(12));
delete(message);
for q=1:7
   %�s�@message�A�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��bpanel(q+7)���W���B�r�a�����                 
   message(q)= uicontrol('Style','text','String','���I���[���}�l�ɶ�','Units','normalized','FontSize',11,...
                         'Position',position_message_h,'Parent',panel(q+7),'horizontalalignment','center');              
   set(message(q),'fontname','�L�n������');
end                    
                    
end

function day_pop_int_Callback(src,evt)%�}�l�ɶ��U�Ԧ����

val_int= get(src,'Value');%�o���I�諸��涵�ح�(���ح�=1,2,3,4...)
Str_int= get(src,'String');%�o���涵�ت��Ҧ����e

  for j=1:m%Ū���Ҧ�wind_int�������
    
       if wind_int.TIMESTAMP{j,1}(1:10)==char(Str_int(val_int,1:10))%�p�G�M�ϥΪ��I�쪺����@��
          choose_int=j;%���UŪ�쪺�C�s�Jchoose_int�̡A�����ϥΪ��I�쪺������Ĥ@���ƾ�
          break;%���X�j��
       end

  end

%�s�@�R�A��r�A�]�w����(text)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B�r�a�����
uicontrol('Style','text','String','�����ɶ��G','FontSize',11,'Units','normalized','fontname' ,'�L�n������',...
          'Position',[.011,.12,.098,.15],'horizontalalignment','left');
      
%�s�@day_pop_fin�A�]�w����(popupmenu)�B�ﶵ�W��(pop_name)�B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B���p��� 
day_pop_fin=uicontrol('Style','popupmenu', 'String',pop_name,'FontSize',11,'Units','normalized',...
                      'Position',position_day_pop_fin,'Callback',fun_name(13));
delete(message);

for q=1:7
   %�s�@message�A�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��bpanel(7)���W���B�r�a�����                   
   message(q)=uicontrol('Style','text','String','���I���[�������ɶ�','Units','normalized','FontSize',11,...
                        'Position',position_message_h,'Parent',panel(q+7),'horizontalalignment','center');
   set(message(q), 'fontname' ,'�L�n������');
end

if time_num==2
delete(ht);
end

if power_num==2
delete(hp);
end   
%�H�U�O����P�_���n�Ϊ��F��A���b�o�̳]�m�n
plot_num=1;
pre_num=1;
time_num=1;
power_num=1;
end       

function day_pop_fin_Callback(src,evt)%�����ɶ��U�Ԧ����

val_fin= get(src,'Value');%�o���I�諸��涵�ح�(���ح�=1,2,3,4...)
Str_fin= get(src,'String');%�o���涵�ت��Ҧ����e

if (val_fin<val_int)%�p�G�ϥΪ��I�諸����p��}�l�ɶ�

t0='�����ɶ����i�H�p��}�l�ɶ�';
h=dialog('name','���~','position',[520 300 250 100],'Units','normalized');  
uicontrol('parent',h,'style','text','string',t0,'position',[25 30 240 50],'fontsize',12,'horizontalalignment','left');  
uicontrol('parent',h,'style','pushbutton','position',[100 10 50 25],'string','OK','callback','delete(gcbf)'); 

else%��L���p
    
  for d=1:m%Ū���Ҧ�wind_int�������
    
     if (wind_int.TIMESTAMP{d,1}(1:10)==char(Str_fin(val_fin,1:10)))%�p�G�M�ϥΪ��I�쪺����@��
        daycheck_2=wind_int.TIMESTAMP{d,1}(1:10);%��Ӥ���s�Jdaycheck_2�A�öi�J�ĤG�Ӱj��

        for pp=d:m%�����~�������Ū��
                 %�p�GŪ��M�ϥΪ��I�쪺����@�ˡA�B�����̫�@���ƾڡA���������
                 if (wind_int.TIMESTAMP{pp,1}(1:10)==daycheck_2 & pp~=m)
                     
                 %�p�GŪ��M�ϥΪ��I�쪺����@�ˡA�B���̫�@���ƾڡA�Npp�s�Jchoose_fin�̡A�ø��X�j��
                 elseif (wind_int.TIMESTAMP{pp,1}(1:10)==daycheck_2 & pp==m)
                      choose_fin=pp;
                      break;
                      
                 %�p�GŪ��M�ϥΪ��I�쪺������@�ˡA�N��e�@�ӼƾڡA���ϥΪ��I�쪺������̫�@����ơA
                 %�N���s�Jchoose_fin�̡A�ø��X�j��
                 else
                      choose_fin=pp-1;                   
                      break;
                 end  %if (wind_int.TIMESTAMP{pp,1}(1:10)==daycheck_2 & pp~=m)
 
         end  %for pp=d:m

     end  %if (wind_int.TIMESTAMP{d,1}(1:10)==char(Str_fin(val_fin,1:10)))

  end  %for d=1:m

wind_new=wind_int(choose_int:choose_fin,:);%�N�ϥΪ̷Q�n�ݪ��ƾڰ϶�(�}�l~����)�s�Jwind_new��

%�S�I��U�Ԧ����(30m�B50m�B70mE�B70mW)�N���@�Ϸ|�X�{���~
%�H�U�����J�ɮ׫�A�w���s�J��ƪ��w�]��(70mE�����t���)�A
%�o�ˤl�A�N��S�I��U�Ԧ����N���@�Ϥ]�|�������70mE�����
current_data_S=wind_new.WSavg_70mE;
current_data_D=wind_new.WDavg_70mE;
current_data_Std=wind_new.WS_70mE_Std;
%�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��b��panel(7)���W���B�r��a����� 
%�N�쥻"�@�ϽХ����J�ɮ�"�אּ"��l�]�w���׬�70mE"
delete(message);

for p=1:7
   message(p)=uicontrol('Style','text','String','��l�]�w���׬�70mE','Units','normalized','FontSize',11,...
                        'Position',position_message_h,'Parent',panel(p+7),'horizontalalignment','center');
   set( message(p), 'fontname' ,'�L�n������');
end   

if plot_num==1%�Ĥ@���ϥη|�i��H�U���O�A����N���|�A����F

%�s�@�R�A��r�A�]�w����(text)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B�r�a�����
uicontrol('Style','text','String','�[�����סG','FontSize',11,'Units','normalized','fontname','�L�n������',...
          'Position',[.011,.4,.098,.05],'horizontalalignment','left');
    
%�s�@height_pop�A�]�w����(popupmenu)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B������p    
height_pop=uicontrol('Style','popupmenu', 'String','70mE|70mW|50m|30m','FontSize',11,'Units','normalized',...
                     'Position',position_height_pop,'Callback',fun_name(10));

set(plot_botton,'Visible','on');%�@�ϫ��s�i�H�ݨ�F
plot_num=2;                     %��plot_num=2�o�˵{���N���|�A����ĤG���F

end  %if plot_num==1

end  %if (val_fin<val_int)

end

function height_pop_Callback(src,evt)%�[�����פU�Ԧ����

val = get(src,'Value');%�o���I�諸��涵�ح�
clr = {'70mE', '70mW' ,'50m' ,'30m'};%���|��

switch clr{val}%�ݿ����ءA�N�Ӷ��ظ�Ʀs�Jcurrent_data_S�BD�BStd�A����@�ϭn��
case '70mE'
     current_data_S=wind_new.WSavg_70mE;
     current_data_D=wind_new.WDavg_70mE;
     current_data_Std=wind_new.WS_70mE_Std;
     for g=1:7
     %�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��b��panel(7)���W���B�r��a�����
     uicontrol('Style','text','String','�{�b�]�w���׬�70mE','Units','normalized','FontSize',11,'fontname','�L�n������',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
     
case '70mW'
     current_data_S=wind_new.WSavg_70mW;
     current_data_D=wind_new.WDavg_70mW;
     current_data_Std=wind_new.WS_70mW_Std;
     for g=1:7
     %�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��b��panel(7)���W���B�r��a�����
     uicontrol('Style','text','String','�{�b�]�w���׬�70mW','Units','normalized','FontSize',11,'fontname' ,'�L�n������',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
     
case '50m'
     current_data_S=wind_new.WSavg_50m;
     current_data_D=wind_new.WDavg_50m;
     current_data_Std=wind_new.WS_50m_Std;
     for g=1:7
     %�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��b��panel(7)���W���B�r��a�����
     uicontrol('Style','text','String','�{�b�]�w���׬�50m','Units','normalized','FontSize',11,'fontname' ,'�L�n������',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
     
case '30m'
     current_data_S=wind_new.WSavg_30m;
     current_data_D=wind_new.WDavg_30m;
     current_data_Std=wind_new.WS_30m_Std;
     for g=1:7
     %�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��b��panel(7)���W���B�r��a�����
     uicontrol('Style','text','String','�{�b�]�w���׬�30m','Units','normalized','FontSize',11,'fontname' ,'�L�n������',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
end

end

%���oMySQL��Ʈw-------------------------------------------------------------------------------------------------------------

function conMySQL_Callback(src,evt)%�s��MySQL
    
  initialpath=pwd;                %����matlab��l���|�A�X�ʸ��J�n��
  driver1=[initialpath,'\JDBC\issas-mysql-connector-java-5.1.39-bin.jar'];
  driver2=[initialpath,'\JDBC\sqljdbc4-2.0.jar'];
  javaaddpath (driver1);          %�@�}�l�n���X�ʸ��J
  javaaddpath (driver2);          %�@�}�l�n���X�ʸ��J
      
  Options.Resize = 'on';
  Options.WindowStyle ='normal';
  default = {'','root',''};
  linenumber = 1;
  userdata=inputdlg({'��Ʈw�W��','�ϥΪ̦W��','�ϥΪ̱K�X'},'MySQL�s��',linenumber,default, Options);  

  conn = database(char(userdata(1)),char(userdata(2)),char(userdata(3)),'Vendor','MySQL','Server','localhost');%�n�JMySQL
  
  curs_start_30 = exec(conn,'SELECT dt FROM l30 limit 1'); %��ol30����T
  curs_start_30 = fetch(curs_start_30);%����mysql��cmdev.l30�����
  curs_end_30   = exec(conn,'SELECT dt FROM l30 order by dt desc limit 1'); %��ol30����T
  curs_end_30   = fetch(curs_end_30);  %����mysql��cmdev.l30�����
  
  curs_Matmo = exec(conn,['SELECT dt,WXT520_P,RMYoung_WS'...
    ' FROM l70'...
    ' WHERE dt>=' '''2014-07-22'''...
    ' AND   dt<=' '''2014-07-24''']);
  curs_Matmo = fetch(curs_Matmo);%����170�����O���
  
  curs_FW = exec(conn,['SELECT dt,WXT520_P,RMYoung_WS'...
    ' FROM l70'...
    ' WHERE dt>=' '''2014-09-20'''...
    ' AND   dt<=' '''2014-09-22''']);
  curs_FW = fetch(curs_FW);%����170�����O���
  
  %�O�o����
  close(curs_start_30);%�O�o�n����
  close(curs_end_30);  %�O�o�n����
  close(curs_Matmo);%�O�o�n����
  close(curs_FW);%�O�o�n����
  
  s_year=str2double(curs_start_30.Data{1,1}(1:4));%�N2014�r���ର2014�ܼ�
  e_year=str2double(curs_end_30.Data{1,1}(1:4));  %�N2015�r���ର2015�ܼ�
  
  cla reset;%�M���e�@�iaxes��
  tab(8) = uitab('Parent',tab_group,'Title',char(tab_name(8)));
  %�s�@panel�A�]�w�W�١B�r��j�p�B�I���C��B��m��m�B������ҩ�j�Y�p�\��(normalized)
  panel(16)= uipanel('Title','���G��','FontSize',11,'BackgroundColor','white',...
                     'Position',position_panelplot_pressure,'Parent',tab(8),'Units','normalized');
  %�s�@h8�@�϶b(axes)�A�u��bpanel(16)�W�B������ҩ�j�Y�p�\��B�]�w��m��m
  h8 = axes('Parent',panel(16),'Units','normalized','Position',position_plot);
  axes(h8);%���{�����D�ϭn��bh8�W
  title_typhoon1='���w�i�䭷 (2014/07/22~2014/07/24) �����B���t��ɶ��ǦC��';
  Wind_Typhoon_sql(curs_Matmo.Data,12,title_typhoon1);
 
  tab(9) = uitab('Parent',tab_group,'Title',char(tab_name(9)));
  %�s�@panel�A�]�w�W�١B�r��j�p�B�I���C��B��m��m�B������ҩ�j�Y�p�\��(normalized)
  panel(17)= uipanel('Title','���G��','FontSize',11,'BackgroundColor','white',...
                     'Position',position_panelplot_pressure,'Parent',tab(9),'Units','normalized');
  %�s�@h8�@�϶b(axes)�A�u��bpanel(17)�W�B������ҩ�j�Y�p�\��B�]�w��m��m
  h9 = axes('Parent',panel(17),'Units','normalized','Position',position_plot);
  axes(h9);%���{�����D�ϭn��bh9�W
  title_typhoon2='��Ļ䭷 (2014/09/20~2014/09/22) �����B���t��ɶ��ǦC��';
  Wind_Typhoon_sql(curs_FW.Data,12,title_typhoon2);
  %------------------------------------------------------------------------------------------------
  tab(10) = uitab('Parent',tab_group,'Title',char(tab_name(10)));
  %�s�@panel�A�]�w�W�١B�r��j�p�B�I���C��B��m��m�B������ҩ�j�Y�p�\��(normalized)
  panel(18)= uipanel('Title','���G��','FontSize',11,'BackgroundColor','white',...
                     'Position',position_panelplot_pressure,'Parent',tab(10),'Units','normalized');
  %�s�@h8�@�϶b(axes)�A�u��bpanel(18)�W�B������ҩ�j�Y�p�\��B�]�w��m��m
  h10 = axes('Parent',panel(18),'Units','normalized','Position',position_plot);
  axes(h10);%���{�����D�ϭn��bh10�W
  title_typhoonPDF1='���w�i�䭷 (PDF of fluctuations)';
  title_typhoonPDF2='��Ļ䭷 (PDF of fluctuations)';
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
%�s�@message�A�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��bpanel(7)���W���B�r�a�����                 
message(q)= uicontrol('Style','text','String',char({'����[���ɶ��ë�����T�{';'(�w�]�Ȭ�2014/1/1~2014/1/2)'}),'Units','normalized','FontSize',10,...
                      'Position',position_message,'Parent',panel(q+7),'horizontalalignment','left');              
end
                
%�s�@�R�A��r�A�]�w����(text)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B�r�a�����
uicontrol('Style','text','String','�}�l�ɶ��G','FontSize',11,'Units','normalized','fontname' ,'�L�n������',...
          'Position',[.011,.21,.098,.15],'horizontalalignment','left');

%�s�@�R�A��r�A�]�w����(text)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B�r�a�����
uicontrol('Style','text','String','�����ɶ��G','FontSize',11,'Units','normalized','fontname' ,'�L�n������',...
          'Position',[.011,.12,.098,.15],'horizontalalignment','left');

%�s�@yearsql_pop_int�A�]�w����(popupmenu)�B�ﶵ�W��(pop_name)�B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B���p���        
yearsql_pop_int = uicontrol('Style','popupmenu', 'String',pop_yname,'FontSize',11,'Units','normalized',...
                            'Position',position_yearsql_pop_int,'Callback',fun_name(14));
                    
%�s�@yearsql_pop_fin�A�]�w����(popupmenu)�B�ﶵ�W��(pop_name)�B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B���p���        
yearsql_pop_fin = uicontrol('Style','popupmenu', 'String',pop_yname,'FontSize',11,'Units','normalized',...
                            'Position',position_yearsql_pop_fin,'Callback',fun_name(15));

%�s�@monthsql_pop_int�A�]�w����(popupmenu)�B�ﶵ�W��(pop_name)�B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B���p���        
monthsql_pop_int = uicontrol('Style','popupmenu', 'String',pop_mname,'FontSize',11,'Units','normalized',...
                             'Position',position_monthsql_pop_int,'Callback',fun_name(16));
                    
%�s�@monthsql_pop_fin�A�]�w����(popupmenu)�B�ﶵ�W��(pop_name)�B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B���p���        
monthsql_pop_fin = uicontrol('Style','popupmenu', 'String',pop_mname,'FontSize',11,'Units','normalized',...
                             'Position',position_monthsql_pop_fin,'Callback',fun_name(17));
                    
%�s�@daysql_pop_int�A�]�w����(popupmenu)�B�ﶵ�W��(pop_name)�B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B���p���        
daysql_pop_int = uicontrol('Style','popupmenu', 'String',pop_dname,'FontSize',11,'Units','normalized',...
                           'Position',position_daysql_pop_int,'Callback',fun_name(18));
                    
%�s�@daysql_pop_fin�A�]�w����(popupmenu)�B�ﶵ�W��(pop_name)�B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B���p���        
daysql_pop_fin = uicontrol('Style','popupmenu', 'String',pop_dname,'FontSize',11,'Units','normalized',...
                           'Position',position_daysql_pop_fin,'Callback',fun_name(19));
                     
%�s�@datesql_check�A�]�w����(pushbutton)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B6�Ӥ�������B������p
datesql_check = uicontrol('Style','pushbutton', 'String','����T�{','FontSize',11,'Units','normalized',...
                          'backgroundcolor',button_color,'Position',position_datesql_check,'Callback',fun_name(20));
                      
set( datesql_check, 'fontname' ,'�L�n������'); 
set( message, 'fontname' ,'�L�n������');                  
                    
year_int='2014';
month_int='01';
day_int='01';
year_fin='2014';
month_fin='01';
day_fin='02';
 
end

function yearsql_pop_int_Callback(src,evt)%�}�l�~�U�Ԧ����
val= get(src,'Value');%�o���I�諸��涵�ح�(���ح�=1,2,3,4...)
Str= get(src,'String');%�o���涵�ت��Ҧ����e
year_int=Str(val);
end

function yearsql_pop_fin_Callback(src,evt)%�����~�U�Ԧ����
val= get(src,'Value');%�o���I�諸��涵�ح�(���ح�=1,2,3,4...)
Str= get(src,'String');%�o���涵�ت��Ҧ����e
year_fin=Str(val);
end

function monthsql_pop_int_Callback(src,evt)%�}�l��U�Ԧ����
val= get(src,'Value');%�o���I�諸��涵�ح�(���ح�=1,2,3,4...)
Str= get(src,'String');%�o���涵�ت��Ҧ����e
month_int=Str(val);
end

function monthsql_pop_fin_Callback(src,evt)%������U�Ԧ����
val= get(src,'Value');%�o���I�諸��涵�ح�(���ح�=1,2,3,4...)
Str= get(src,'String');%�o���涵�ت��Ҧ����e
month_fin=Str(val);
end

function daysql_pop_int_Callback(src,evt)%�}�l��U�Ԧ����
val= get(src,'Value');%�o���I�諸��涵�ح�(���ح�=1,2,3,4...)
Str= get(src,'String');%�o���涵�ت��Ҧ����e
day_int=Str(val);
end

function daysql_pop_fin_Callback(src,evt)%������U�Ԧ����
val= get(src,'Value');%�o���I�諸��涵�ح�(���ح�=1,2,3,4...)
Str= get(src,'String');%�o���涵�ت��Ҧ����e
day_fin=Str(val);
end

function datesql_check_Callback(src,evt)%����T�{���s
%�������t�W��
curs_name_30 = exec(conn,'DESC l30'); %��ol30����T
curs_name_30 = fetch(curs_name_30);%����mysql��cmdev.l30�����
curs_name_50 = exec(conn,'DESC l50'); %��ol50����T
curs_name_50 = fetch(curs_name_50);%����mysql��cmdev.l50�����
curs_name_70 = exec(conn,'DESC l70'); %��ol70����T
curs_name_70 = fetch(curs_name_70);%����mysql��cmdev.l70�����

name30=[curs_name_30.Data(1,1),curs_name_30.Data(10,1),curs_name_30.Data(11,1)];
name50=[curs_name_50.Data(1,1),curs_name_50.Data(10,1),curs_name_50.Data(11,1)];
name70=[curs_name_70.Data(1,1),curs_name_70.Data(10,1),curs_name_70.Data(11,1)];
name = [name30,name50,name70];
%���t�W��(���|��'')�A�n�γo�Ӥ~���cell2dataset
%a={curs_name_30.Data(1,1),curs_name_30.Data(10,1),curs_name_30.Data(11,1)};%���t�W��(�|��'')�A�o��cell2dataset�|�X��
    
%������ܪ����
initial=['''',char(year_int),'-',char(month_int),'-',char(day_int),''''];
  final=['''',char(year_fin),'-',char(month_fin),'-',char(day_fin),''''];

curs_cho30 = exec(conn,['SELECT dt,RMYoung_WS,RMYoung_WD'...
    ' FROM l30'...%1����                        %�`�N�A�Ĥ@�ӳ�޸��n���Ť@��A��FROM
    ' WHERE dt>=' initial...                    %�ɶ����̲Ĥ@�ӳ�޸��]�n���Ť@��A��'''2014...
    ' AND   dt<=' final]);                      %2014-01-01~2014-01-02�A�N���2014-01-01��23:59:03
curs_cho30 = fetch(curs_cho30);%�������t���

curs_cho50 = exec(conn,['SELECT dt,RMYoung_WS,RMYoung_WD'...
    ' FROM l50'...%1����                        %�`�N�A�Ĥ@�ӳ�޸��n���Ť@��A��FROM
    ' WHERE dt>=' initial...                    %�ɶ����̲Ĥ@�ӳ�޸��]�n���Ť@��A��'''2014...
    ' AND   dt<=' final]); 
curs_cho50 = fetch(curs_cho50);%�������t���

curs_cho70 = exec(conn,['SELECT dt,RMYoung_WS,RMYoung_WD'...
    ' FROM l70'...%1����                        %�`�N�A�Ĥ@�ӳ�޸��n���Ť@��A��FROM
    ' WHERE dt>=' initial...                    %�ɶ����̲Ĥ@�ӳ�޸��]�n���Ť@��A��'''2014...
    ' AND   dt<=' final]);
curs_cho70 = fetch(curs_cho70);%�������t���

cho30=[curs_cho30.Data];%���t���
cho50=[curs_cho50.Data];%���t���
cho70=[curs_cho70.Data];%���t���

[a30,b30]=size(cho30);
[a50,b50]=size(cho50);
[a70,b70]=size(cho70);

if     a30>a50  & a30>a70  %a30�̤j
       cho=[cho30,[cho50;num2cell(zeros(a30-a50,3))],[cho70;num2cell(zeros(a30-a70,3))]];       
elseif a50>a30  & a50>a70  %a50�̤j
       cho=[cho50,[cho30;num2cell(zeros(a50-a30,3))],[cho70;num2cell(zeros(a50-a70,3))]]; 
elseif a70>a30  & a70>a50  %a70�̤j
       cho=[cho70,[cho30;num2cell(zeros(a70-a30,3))],[cho50;num2cell(zeros(a70-a50,3))]]; 
elseif a30==a50 & a30==a70 %�@�ˤj
       cho=[cho30,cho50,cho70];
elseif a70==a50 & a30>a50  %a30�̤j�Aa70=a50 
       cho=[cho30,[cho50;num2cell(zeros(a30-a50,3))],[cho70;num2cell(zeros(a30-a70,3))]]; 
elseif a30==a70 & a50>a30  %a50�̤j�Aa30=a70
       cho=[cho50,[cho30;num2cell(zeros(a50-a30,3))],[cho70;num2cell(zeros(a50-a70,3))]]; 
elseif a30==a50 & a70>a50  %a70�̤j�Aa30=a50
       cho=[cho70,[cho30;num2cell(zeros(a70-a30,3))],[cho50;num2cell(zeros(a70-a50,3))]]; 
elseif a70==a50 & a30<a50  %a30�̤p�Aa70=a50 
       cho=[cho50,cho70,[cho30;num2cell(zeros(a70-a30,3))]]; 
elseif a30==a70 & a50<a30  %a50�̤p�Aa30=a70
       cho=[cho30,cho70,[cho50;num2cell(zeros(a30-a50,3))]]; 
elseif a30==a50 & a70<a50  %a70�̤p�Aa30=a50
       cho=[cho30,cho50,[cho70;num2cell(zeros(30,3))]]; 
else
    
end

wind_cell30=[name30;cho30];%���t�W��&��ƪ�cell
wind_cell50=[name50;cho50];%���t�W��&��ƪ�cell
wind_cell70=[name70;cho70];%���t�W��&��ƪ�cell
wind_cell=[name;cho];%���t�W��&��ƪ�cell

wind_mysql30=cell2dataset(wind_cell30);%���t�W��&��ơA�n���ӥΪ�
wind_mysql50=cell2dataset(wind_cell50);%���t�W��&��ơA�n���ӥΪ�
wind_mysql70=cell2dataset(wind_cell70);%���t�W��&��ơA�n���ӥΪ�
wind_new=cell2dataset(wind_cell);%���t�W��&��ơA�n���ӥΪ�

%----------------------------------------------------------------------------

S_70=find(isnan(wind_mysql70.RMYoung_WS));%��Xwind_mysql70.RMYoung_WS����NaN
wind_mysql70.RMYoung_WS(S_70)=0;
D_70=find(isnan(wind_mysql70.RMYoung_WD));%��Xwind_mysql70.RMYoung_WD����NaN
wind_mysql70.RMYoung_WD(D_70)=0;
S_50=find(isnan(wind_mysql50.RMYoung_WS));%��Xwind_mysql50.RMYoung_WS����NaN
wind_mysql50.RMYoung_WS(S_50)=0;
D_50=find(isnan(wind_mysql50.RMYoung_WD));%��Xwind_mysql50.RMYoung_WD����NaN
wind_mysql50.RMYoung_WD(D_50)=0;
S_30=find(isnan(wind_mysql30.RMYoung_WS));%��Xwind_mysql30.RMYoung_WS����NaN
wind_mysql30.RMYoung_WS(S_30)=0;
D_30=find(isnan(wind_mysql30.RMYoung_WD));%��Xwind_mysql30.RMYoung_WD����NaN
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

close(curs_name_30);%�O�o�n����
close(curs_name_50);%�O�o�n����
close(curs_name_70);%�O�o�n����
close(curs_cho30);%�O�o�n����
close(conn);%�O�o�n����

current_data_D=wind_mysql70_md';
current_data_S=wind_mysql70_ms';
current_data_Std=wind_mysql70_std';

%�s�@�R�A��r�A�]�w����(text)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B�r�a�����
uicontrol('Style','text','String','�[�����סG','FontSize',11,'Units','normalized','fontname' ,'�L�n������',...
              'Position',[.011,.4,.098,.05],'horizontalalignment','left');
%�s�@heightsql_pop�A�]�w����(popupmenu)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B������p    
heightsql_pop=uicontrol('Style','popupmenu', 'String','70m|50m|30m','FontSize',11,'Units','normalized',...
                      'Position',position_heightsql_pop,'Callback',fun_name(21));
delete(message);
for p=1:7
message=uicontrol('Style','text','String','��l�]�w���׬�70m','Units','normalized','FontSize',11,...
                  'Position',position_message_h,'Parent',panel(p+7),'horizontalalignment','center');
set( message, 'fontname' ,'�L�n������');
end   

set(plot_botton,'Visible','on');%�@�ϫ��s�i�H�ݨ�F

if time_num==2
delete(ht);
end

if power_num==2
delete(hp);
end    
%�H�U�O����P�_���n�Ϊ��F��A���b�o�̳]�m�n
plot_num=1;
pre_num=1;
time_num=1;
power_num=1;
end

function heightsql_pop_Callback(src,evt)%�[�����פU�Ԧ����

val = get(src,'Value');%�o���I�諸��涵�ح�
clr = {'70m', '50m' ,'30m'};%���T��

switch clr{val}%�ݿ����ءA�N�Ӷ��ظ�Ʀs�Jcurrent_data_S�BD�BStd�A����@�ϭn��
case '70m'

     current_data_D=wind_mysql70_md';
     current_data_S=wind_mysql70_ms';
     current_data_Std=wind_mysql70_std';
     for g=1:7
     %�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��b��panel(7)���W���B�r��a�����
     uicontrol('Style','text','String','�{�b�]�w���׬�70m','Units','normalized','FontSize',11,'fontname' ,'�L�n������',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
case '50m'
      
     current_data_D=wind_mysql50_md';
     current_data_S=wind_mysql50_ms';
     current_data_Std=wind_mysql50_std';
     for g=1:7
     %�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��b��panel(7)���W���B�r��a�����
     uicontrol('Style','text','String','�{�b�]�w���׬�50m','Units','normalized','FontSize',11,'fontname' ,'�L�n������',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
case '30m'
     
     current_data_D=wind_mysql30_md';
     current_data_S=wind_mysql30_ms';
     current_data_Std=wind_mysql30_std';
     for g=1:7
     %�]�w����(text)�B�W�١B������ҩ�j�Y�p�\��B�r��j�p�B��m��m�B��b��panel(7)���W���B�r��a�����
     uicontrol('Style','text','String','�{�b�]�w���׬�30m','Units','normalized','FontSize',11,'fontname' ,'�L�n������',...
               'Position',position_message_h,'Parent',panel(g+7),'horizontalalignment','center');
     end
end

end

%ø�Ϩ��--------------------------------------------------------------------------------------------------------------------

function wind_speed_dist_Callback(src,evt)%���t������
%�H�U�@��
cla reset;%�M���e�@�iaxes��
%�s�@h1�@�϶b(axes)�A�u��bpanel(1)�W�B������ҩ�j�Y�p�\��B�]�w��m��m
h1 = axes('Parent',panel(1),'Units','normalized','Position',position_plot);
axes(h1);%���{�����D�ϭn��bh1�W

[mm,n]=size(current_data_S);%�o��current_data_S����C

[p1,p2]=Wind_Speed_Dist(current_data_S,mm);

%�s�@h_temp�@�϶b(axes)�A�u��bpanel_temp�W�B������ҩ�j�Y�p�\��B�]�w��m��m
%�o�ˤl���Ψ�cla reset���ɭԡA�u�|�M���o�i�A���|�M���w�g�e�n����
h_temp = axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%�s�@���p��T
uicontrol('Style','pushbutton', 'String','���p��T','FontSize',11,'fontname' ,'�L�n������','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(1),'Callback',@wind_speed_dist_information);

%���p��T���
function wind_speed_dist_information(src,evt)%���p��T���
%�ХX���B�Ѽ�   
t1=['�ثװѼơG' num2str(p1)];
t2=['�Ϊ��ѼơG' num2str(p2)];
t3={t1;t2};
h=dialog('name','���B�Ѽ�','position',[520 300 250 100],'Units','normalized');  
uicontrol('parent',h,'style','text','string',t3,'position',[60 35 240 50],'fontsize',12,'horizontalalignment','left');  
uicontrol('parent',h,'style','pushbutton','position',[100 10 50 25],'string','OK','callback','delete(gcbf)','backgroundcolor',button_color);  
end

end

function wind_rose_Callback(src,evt)%�����
%�H�U�@��
cla reset;%�M���e�@�iaxes��
%�s�@h2�@�϶b(axes)�A�u��bpanel(2)�W�B������ҩ�j�Y�p�\��B�]�w��m��m
h2 = axes('Parent',panel(2),'Units','normalized','Position',position_plot);
axes(h2);%���{�����D�ϭn��bh2�W

subplot(1,1,1);
%0:22.5:360�N��n��360/22.5=16�Ӱ϶��A2.5:5:42.5�N���t���϶��A[15 25 35 45]�N��%�ƪ��϶�
Wind_Rose(gca,current_data_D,current_data_S,0:22.5:360, 2.5:5:42.5, [15 25 35 45], '���ئa�ϭ����');   

%�s�@h_temp�@�϶b(axes)�A�u��bpanel_temp�W�B������ҩ�j�Y�p�\��B�]�w��m��m
%�o�ˤl���Ψ�cla reset���ɭԡA�u�|�M���o�i�A���|�M���w�g�e�n����
h_temp=  axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%�s�@���p��T
uicontrol('Style','pushbutton', 'String','���p��T','FontSize',11,'fontname' ,'�L�n������','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(2),'Callback',@wind_rose_information);
      
function wind_rose_information(src,evt)%���p��T���
end

end

function ti_Callback(src,evt)%T.I��
%�H�U�@��
cla reset;%�M���e�@�iaxes��
%�s�@h3�@�϶b(axes)�A�u��bpanel(3)�W�B������ҩ�j�Y�p�\��B�]�w��m��m
h3= axes('Parent',panel(3),'Units','normalized','Position',position_plot);
axes(h3);%���{�����D�ϭn��bh3�W

Wind_TI(current_data_S,current_data_Std);

%�s�@h_temp�@�϶b(axes)�A�u��bpanel_temp�W�B������ҩ�j�Y�p�\��B�]�w��m��m
%�o�ˤl���Ψ�cla reset���ɭԡA�u�|�M���o�i�A���|�M���w�g�e�n����
h_temp=  axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%�s�@���p��T
uicontrol('Style','pushbutton', 'String','���p��T','FontSize',11,'fontname' ,'�L�n������','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(3),'Callback',@ti_information);

function ti_information(src,evt)%���p��T���
end

end

function time_series_Callback(src,evt)%�ɶ��ǦC��power_series_Callbac

if time_num==1
%�s�@h4�@�϶b(axes)�A�u��bpanel(4)�W�B������ҩ�j�Y�p�\��B�]�w��m��m
h4 = axes('Parent',panel(4),'Units','normalized','Position',position_plot);
axes(h4);%���{�����D�ϭn��bh4�W

[mm,nn]=size(wind_new);

if nn==9%MySQL�����

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
 
else    %txt�����

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

%�s�@h_temp�@�϶b(axes)�A�u��bpanel_temp�W�B������ҩ�j�Y�p�\��B�]�w��m��m
%�o�ˤl���Ψ�cla reset���ɭԡA�u�|�M���o�i�A���|�M���w�g�e�n����
h_temp = axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%�s�@���p��T
uicontrol('Style','pushbutton', 'String','���p��T','FontSize',11,'fontname' ,'�L�n������','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(4),'Callback',@time_series_information);
time_num=2;

function time_series_information(src,evt)%���p��T���
  if nn==9 %MySQL�����
  
  else %txt�����  
  txt='2015/06/12~2015/06/26�S�����';
  h=dialog('name','�ʥ����','position',[520 300 250 100],'Units','normalized');  
  uicontrol('parent',h,'style','text','string',txt,'position',[7 20 240 55],'fontsize',12,'horizontalalignment','center');  
  uicontrol('parent',h,'style','pushbutton','position',[100 8 50 25],'string','OK','callback','delete(gcbf)','backgroundcolor',button_color);  
  
  end
  
  end

end

function wind_shear_Callback(src,evt)%�������ƹ�
%�H�U�p��@��
%�s�@h5�@�϶b(axes)�A�u��bpanel(5)�W�B������ҩ�j�Y�p�\��B�]�w��m��m
h5 = axes('Parent',panel(5),'Units','normalized','Position',position_plot);
axes(h5);%���{�����D�ϭn��bh5�W

alpha_shear=Wind_Shear(wind_new);

%�s�@h_temp�@�϶b(axes)�A�u��bpanel_temp�W�B������ҩ�j�Y�p�\��B�]�w��m��m
%�o�ˤl���Ψ�cla reset���ɭԡA�u�|�M���o�i�A���|�M���w�g�e�n����
h_temp=  axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%�s�@���p��T
uicontrol('Style','pushbutton', 'String','���p��T','FontSize',11,'fontname' ,'�L�n������','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(5),'Callback',@wind_shear_information);

function wind_shear_information(src,evt)%���p��T���
%��ܭ��p���
alpha_new=['�������� (Alpha) = ',num2str(alpha_shear)];
h=dialog('name','��������','position',[520 300 250 100],'Units','normalized');  
uicontrol('parent',h,'style','text','string',alpha_new,'position',[35 30 240 50],'fontsize',12,'horizontalalignment','left');  
uicontrol('parent',h,'style','pushbutton','position',[100 10 50 25],'string','OK','callback','delete(gcbf)','backgroundcolor',button_color);  
end 

end

function wind_max_predict_Callback(src,evt)%�̤j���t�w����
%�H�U�p��@��
%�s�@h5�@�϶b(axes)�A�u��bpanel(5)�W�B������ҩ�j�Y�p�\��B�]�w��m��m
h6 = axes('Parent',panel(6),'Units','normalized','Position',position_plot);
axes(h6);%���{�����D�ϭn��bh6�W

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

if pre_num==1%�Ĥ@���ϥη|�i��H�U���O�A����N���|�A����F

        %�s�@panel(17)�A�]�w�W�١B�r��j�p�B��m��m�B������ҩ�j�Y�p�\��B�u��btab(6)�W     
        panel(19) = uipanel('Title','���ӳ̤j���t�w��','FontSize',11,...
              'Position',position_pre_panel,'Units','normalized','Parent',tab(6));   
        %�s�@pre_edit�A�]�w����(edit)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B�I���C��B��m��m�B��b��panel(9)���W��    
        pre_edit = uicontrol('Style','edit','String','','FontSize',11,'Units','normalized','BackgroundColor','white',...
              'Position',position_pre_edit,'Parent',panel(19));
        %�s�@pre_edit�A�]�w����(pushbutton)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B��b��panel(9)���W���B������p
        pre_botton  = uicontrol('Style','pushbutton', 'String','�I�ڹw��','FontSize',11,'Units','normalized',...
        'backgroundcolor',button_color,'Position',position_pre_botton,'Parent',panel(19), 'Callback',fun_name(11));
        %�s�@pre_edit�A�]�w����(text)�B�W�١B�r��j�p�B������ҩ�j�Y�p�\��B��m��m�B��b��panel(9)���W���B�r��a����� 
        pre_message = uicontrol('Style','text','String','�Цb�ťճB��J�~��(���ԧB�Ʀr)','FontSize',11,'Units','normalized',...
              'Position',position_pre_message,'Parent',panel(19),'horizontalalignment','left');
        set( panel(19), 'fontname' ,'�L�n������');        
        set( pre_botton, 'fontname' ,'�L�n������');        
        set( pre_message, 'fontname' ,'�L�n������'); 
        pre_num=2;%��pre_num=2�o�˵{���N���|�A����ĤG���F

end

%�s�@h_temp�@�϶b(axes)�A�u��bpanel_temp�W�B������ҩ�j�Y�p�\��B�]�w��m��m
%�o�ˤl���Ψ�cla reset���ɭԡA�u�|�M���o�i�A���|�M���w�g�e�n����
h_temp=  axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%�s�@���p��T
uicontrol('Style','pushbutton', 'String','���p��T','FontSize',11,'fontname' ,'�L�n������','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(6),'Callback',@wind_max_predict_information);

function wind_max_predict_information(src,evt)%���p��T���
%��ܭ��p���
txt1='Gumbel straight line�G';
txt2=['y=',num2str(p(1)),'*x+',num2str(p(2))];
txt={txt1;'';txt2};
h=dialog('name','�w����{��','position',[520 300 250 100],'Units','normalized');  
uicontrol('parent',h,'style','text','string',txt,'position',[10 40 240 55],'fontsize',12,'horizontalalignment','center');  
uicontrol('parent',h,'style','pushbutton','position',[100 8 50 25],'string','OK','callback','delete(gcbf)','backgroundcolor',button_color);  
end  
      
end

function pre_botton_Callback(src,evt)%�̤j���t�w�����s
    
%preday =get(pre_edit,'String');%�o��s��Ϫ���(��J���Ѽ�)
preyear =get(pre_edit,'String');%�o��s��Ϫ���(��J���~��)

if isempty(str2num(preyear))~=0% or isempty(str2num(preday))==1�A���J�Ȥ����Ʀr��
   h=errordlg('�ťճB�u���\���ԧB�Ʀr','���~');  
   ha=get(h,'children');  
   set(h,'Units','normalized','position',[.365 .5 .27 .15])
   hu=findall(allchild(h),'style','pushbutton');  
   set(hu,'string','OK','Units','normalized','position',[.38 .08 .25 .25],'backgroundcolor',button_color);  
   htype=findall(ha,'type','text');  
   set(htype,'fontsize',12.5,'Units','normalized');
   set(pre_message, 'String','');

else
preyear=str2double(preyear);
%prespeed=v_int+alpha*log(preday/210);��
prespeed=v_int+alpha*log(preyear/210*365);
prespeed=['�w����',num2str(preyear),'�~���̤j���t��',num2str(prespeed),'(m/s)'];
set(pre_message, 'String',num2str(prespeed));   
end 

end

function power_series_Callback(src,evt)%�o�q�q�w����

if power_num==1
%�s�@h7�@�϶b(axes)�A�u��bpanel(7)�W�B������ҩ�j�Y�p�\��B�]�w��m��m
h7 = axes('Parent',panel(7),'Units','normalized','Position',position_plot);
axes(h7);%���{�����D�ϭn��bh7�W

initialpath=pwd;                                 %����matlab��l���|�A���J�ɮפ���n��
[FileName,PathName]=uigetfile({'*.txt';'*.dat'});%���o���J�ɮפ��W�١B�Ҧb���|
cd(PathName); 
%�H�U�O�bŪ��power_curve��
%�N�ɮ�(FileName)������Ʀs�Jpower_curve<dataset>�̡A�H�r�����}�C���ƾ�
power_curve=dataset('file',FileName,'delimiter',',', 'format',repmat('%f',1,2)); 
cd(initialpath);                                 %�^�hmatlab��l���|

%�إߪ��B�u�bpanel(7)�W�B�i����ҩ�j�Y�p�B��m��m�B�C���W�١B���
uitable('Parent',panel(7),'units','Normalized','position',[.05,.72,.4,.22],'RowName',{'Wind speed (m/s)', 'Power (kW)'},...
        'data',[power_curve.Wind_speed_m_s(:)';power_curve.Power_kW(:)']);
    
[mm,nn]=size(wind_new);

if nn==9%MySQL�����

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
 
else    %txt�����

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

%�s�@h_temp�@�϶b(axes)�A�u��bpanel_temp�W�B������ҩ�j�Y�p�\��B�]�w��m��m
%�o�ˤl���Ψ�cla reset���ɭԡA�u�|�M���o�i�A���|�M���w�g�e�n����
h_temp = axes('Parent',panel_temp,'Units','normalized','Position',position_temp);

%�s�@���p��T
uicontrol('Style','pushbutton', 'String','���p��T','FontSize',11,'fontname' ,'�L�n������','Units','normalized',...
          'backgroundcolor',button_color,'Position',position_information,'Parent',tab(7),'Callback',@power_series_information);
power_num=2;

function power_series_information(src,evt)%���p��T���

%����`�o�q�q   
t1=['�`�o�q�q��' num2str(total_energy/10^6),'(MJ)'];
t2=['�۷��' num2str(total_energy/(3.6*10^6)),'�׹q'];
t3={t1;t2};
h=dialog('name','�����`�o�q�q','position',[470 300 350 100],'Units','normalized');  
uicontrol('parent',h,'style','text','string',t3,'position',[80 35 240 50],'fontsize',12,'horizontalalignment','left');  
uicontrol('parent',h,'style','pushbutton','position',[150 10 50 25],'string','OK','callback','delete(gcbf)','backgroundcolor',button_color);  
end

end
end
