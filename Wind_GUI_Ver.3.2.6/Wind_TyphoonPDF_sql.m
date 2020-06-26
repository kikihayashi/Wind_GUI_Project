function Wind_TyphoonPDF_sql(Data1,Data2,title1,title2)
%將颱風風速資料存入X1、X2向量
X1=cell2mat(Data1(:,3));
X2=cell2mat(Data2(:,3));

%得到X1、X2向量的列、行值
[m1,n1]=size(X1);
[m2,n2]=size(X2);

%得到風速變動量
Fluc_X1=(X1-mean(X1));
Fluc_X2=(X2-mean(X2));

%以下是得到風速變動量的增量=(後一個時間風速變動量)-(當下風速變動量)
for q=1:m1-1
Fluc_Incr_X1(q)=Fluc_X1(q+1)-Fluc_X1(q);
end
Fluc_Incr_Normal_X1=Fluc_Incr_X1/std(Fluc_Incr_X1);
for q=1:m2-1
Fluc_Incr_X2(q)=Fluc_X2(q+1)-Fluc_X2(q);
end
Fluc_Incr_Normal_X2=Fluc_Incr_X2/std(Fluc_Incr_X2);

%設定增量大小，之後決定區間範圍要用
range1=0.005;
range2=0.005;

%------------------------------------------------------------------------------------------------------------------=
%以下作法是將風速變動量的增量，以range1為一個間隔，取出數值，看該間隔佔全部的多少比例
%首先從距離平均數最遠的數值開始找，理論上所有的數據都小於它，所以K值應該會接近零。
%而第一次find(abs(Fluc_Incr_Normal_X1)<range1*i)出來的D應該是1,2,3...m1，會讓PDF_1(1:m1)=K=0
%然後逐漸縮小最遠的數值(range1*i，i是遞減值)，這樣K值會上升，而PDF_1會將舊的數值換新。
%迴圈結束後即可得到要的結果
for i=ceil(max(Fluc_Incr_Normal_X1)/range1):-1:1
    D=find(abs(Fluc_Incr_Normal_X1)<range1*i);
    K=sum(abs(Fluc_Incr_Normal_X1)>range1*i);
    PDF_1(D)=K/(m1-1);  
end

for j=ceil(max(Fluc_Incr_Normal_X2)/range2):-1:1
    D=find(abs(Fluc_Incr_Normal_X2)<range2*j);
    K=sum(abs(Fluc_Incr_Normal_X2)>range2*j);
    PDF_2(D)=K/(m2-1);  
end

%以下作出高斯分布的PDF
Gauss_X1=-6:0.05:6;
Gauss_PDF_1=normpdf(Gauss_X1,0,1);
Gauss_X2=-6:0.05:6;
Gauss_PDF_2=normpdf(Gauss_X2,0,1);

%------------------------------------------------------------------------------------------------------------------
subplot(1,2,1)
h1=semilogy(Gauss_X1, Gauss_PDF_1, 'k');
set(h1,'linewidth',1.5);
grid on
hold on  
t1=semilogy(Fluc_Incr_Normal_X1,PDF_1,'o','markersize',7,'Color',[0 0.4 0]);
axis([-7 7 10^-4 10^0.5]);
title(title1);
xlabel('Normalized increments of the fluctuation (u''/sigma)');
ylabel('Probability');
set(gca,'FontWeight','bold','fontsize',12);%設定字體大小
legend([h1,t1],'Gaussian','Typhoon');
hold off

subplot(1,2,2)
h2=semilogy(Gauss_X2, Gauss_PDF_2, 'k');
set(h2,'linewidth',1.5);
grid on
hold on
t2=semilogy(Fluc_Incr_Normal_X2,PDF_2,'o','markersize',7,'Color',[0 0.4 0]);
axis([-7 7 10^-4 10^0.5]);
title(title2);
xlabel('Normalized increments of the fluctuation (u''/sigma)');
ylabel('Probability');
set(gca,'FontWeight','bold','fontsize',12);%設定字體大小
legend([h2,t2],'Gaussian','Typhoon');
hold off

end

