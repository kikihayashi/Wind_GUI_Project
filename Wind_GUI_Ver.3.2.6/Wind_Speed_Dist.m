function [p1,p2] = Wind_Speed_Dist(current_data_S,mm)

subplot(1,2,1)
[x,y]=hist(current_data_S,ceil(max(current_data_S)));
bar(y,x);
title('彰濱平均風速分布圖');
xlabel('風速 (m/s)');
ylabel('次數');
set(gca,'FontWeight','bold','fontsize',15);
set( gca, 'fontname' ,'微軟正黑體');
subplot(1,2,2)
[x,y]=hist(current_data_S,ceil(max(current_data_S)));
%fid = fopen('D:\check.txt', 'a'); 
current_data_S=sort(current_data_S);

% for i=1:mm
% if isnan(current_data_S(i))==1
% current_data_S(i)=0;
% %disp('NAN');
% end
% %fprintf(fid, '%f \r\n',current_data_S(i)); 
% end
% %fclose(fid); 
% i=find(isnan(current_data_S));%找出current_data_S中的NaN
% current_data_S(i)=0;%改成0
    
p=wblfit(current_data_S+0.0001);
p1=p(1);p2=p(2);
z=0:1:ceil(max(y));%橫軸風速從小到最大
modelFun=(p2/p1)*(z/p1).^(p2-1).*exp(-(z/p1).^p2);%韋伯分布公式
bar(y,x./mm);
hold on
wb=plot(z,modelFun,'r');
title('彰濱平均風速分布圖');
xlabel('風速 (m/s)');
ylabel('百分比');

sigma=std(z);
modelFun2=(z/sigma^2).*exp((-z.^2)/(2*sigma^2));%雷利分布公式
re=plot(z,modelFun2,'Color',[0 0.5 0]);
legend([wb,re],'韋伯分布','雷利分布');
set(gca,'FontWeight','bold','fontsize',15);
set( gca, 'fontname' ,'微軟正黑體');
hold off

end

