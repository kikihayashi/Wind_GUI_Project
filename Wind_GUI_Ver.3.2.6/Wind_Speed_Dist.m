function [p1,p2] = Wind_Speed_Dist(current_data_S,mm)

subplot(1,2,1)
[x,y]=hist(current_data_S,ceil(max(current_data_S)));
bar(y,x);
title('���إ������t������');
xlabel('���t (m/s)');
ylabel('����');
set(gca,'FontWeight','bold','fontsize',15);
set( gca, 'fontname' ,'�L�n������');
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
% i=find(isnan(current_data_S));%��Xcurrent_data_S����NaN
% current_data_S(i)=0;%�令0
    
p=wblfit(current_data_S+0.0001);
p1=p(1);p2=p(2);
z=0:1:ceil(max(y));%��b���t�q�p��̤j
modelFun=(p2/p1)*(z/p1).^(p2-1).*exp(-(z/p1).^p2);%���B��������
bar(y,x./mm);
hold on
wb=plot(z,modelFun,'r');
title('���إ������t������');
xlabel('���t (m/s)');
ylabel('�ʤ���');

sigma=std(z);
modelFun2=(z/sigma^2).*exp((-z.^2)/(2*sigma^2));%�p�Q��������
re=plot(z,modelFun2,'Color',[0 0.5 0]);
legend([wb,re],'���B����','�p�Q����');
set(gca,'FontWeight','bold','fontsize',15);
set( gca, 'fontname' ,'�L�n������');
hold off

end

