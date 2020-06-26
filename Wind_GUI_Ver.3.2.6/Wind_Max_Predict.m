function [p,v_int,alpha]=Wind_Max_Predict(wind_new,daynum,datanum)

WS70E_max=zeros(daynum,1);
WS70W_max=zeros(daynum,1);
WS70_max=zeros(daynum,1);
WS50_max=zeros(daynum,1);
WS30_max=zeros(daynum,1);
WS_max_temp=zeros(daynum,4);
WS_max=zeros(daynum,1);
yu=rem(datanum,daynum);%14�����/3��=()...2�����
sun=fix(datanum/daynum);%14�����/3��=(4��/��)
de=yu+sun;%2+4=6
[mm,nn]=size(wind_new);
if nn==9%mysql

WS70_max(1)=max(wind_new.RMYoung_WS_2(1:de));%1:6
WS50_max(1)=max(wind_new.RMYoung_WS_1(1:de));
WS30_max(1)=max(wind_new.RMYoung_WS(1:de));

ds=de+1;%7
de=de+sun;%10

for r=2:daynum%2:3
WS70_max(r)=max(wind_new.RMYoung_WS_2(ds:de));%7:10
WS50_max(r)=max(wind_new.RMYoung_WS_1(ds:de));
WS30_max(r)=max(wind_new.RMYoung_WS(ds:de));
ds=de+1;%11
de=de+sun;%14
end 

WS_max_temp(:,1)=WS30_max;  
WS_max_temp(:,2)=WS50_max;
WS_max_temp(:,3)=WS70_max;

else%txt��

WS70E_max(1)=max(wind_new.WSavg_70mE(1:de));%1:6
WS70W_max(1)=max(wind_new.WSavg_70mW(1:de));
WS50_max(1)=max(wind_new.WSavg_50m(1:de));
WS30_max(1)=max(wind_new.WSavg_30m(1:de));

ds=de+1;%7
de=de+sun;%10

for r=2:daynum%2:3
WS70E_max(r)=max(wind_new.WSavg_70mE(ds:de));%7:10
WS70W_max(r)=max(wind_new.WSavg_70mW(ds:de));
WS50_max(r)=max(wind_new.WSavg_50m(ds:de));
WS30_max(r)=max(wind_new.WSavg_30m(ds:de));
ds=de+1;%11
de=de+sun;%14
end

WS_max_temp(:,1)=WS70E_max;
WS_max_temp(:,2)=WS70W_max;
WS_max_temp(:,3)=WS50_max;
WS_max_temp(:,4)=WS30_max;
end


for u=1:daynum%�D�X�̤j���t�ȡA�@210��
    WS_max(u)=max(WS_max_temp(u,:));
end

WS_max_fin=sort(WS_max,1);
T=1:daynum;
t=(-1*log(-log((T./(daynum+1)))));
p=polyfit(t,WS_max_fin',1);%�Ѽƾں�XGumbel straight line���Ѽ�
fun=p(1)*t+p(2);%�g�X�w����Gumbel straight line
alpha=p(1);
beta=p(1)*(p(2)-p(1)*log(daynum/365));
v_int=alpha*max(t)+beta/alpha;
subplot(1,1,1);
scatter(t,WS_max_fin);
hold on
plot(t,fun,'r');
grid on;
txt='T=1/(1-F)�BF=�Ѽ�/(�`�Ѽ�+1)';
text(mean(t)+0.2,min(WS_max_fin),txt);
set(gca,'YMinorTick','on');%�e�p��u
set(gca,'XMinorTick','on');%�e�p��u
set(gca,'Ticklength',[0.015 ,0.015]);
title('���ئa�ϳ̤j���t�w����');
xlabel('x:-1*log(-log(1-1/T))');
ylabel('y:���t (m/s)');
set(gca,'FontWeight','bold','fontsize',15);
hold off

end

