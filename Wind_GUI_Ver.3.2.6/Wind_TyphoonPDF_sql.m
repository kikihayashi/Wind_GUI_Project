function Wind_TyphoonPDF_sql(Data1,Data2,title1,title2)
%�N�䭷���t��Ʀs�JX1�BX2�V�q
X1=cell2mat(Data1(:,3));
X2=cell2mat(Data2(:,3));

%�o��X1�BX2�V�q���C�B���
[m1,n1]=size(X1);
[m2,n2]=size(X2);

%�o�쭷�t�ܰʶq
Fluc_X1=(X1-mean(X1));
Fluc_X2=(X2-mean(X2));

%�H�U�O�o�쭷�t�ܰʶq���W�q=(��@�Ӯɶ����t�ܰʶq)-(��U���t�ܰʶq)
for q=1:m1-1
Fluc_Incr_X1(q)=Fluc_X1(q+1)-Fluc_X1(q);
end
Fluc_Incr_Normal_X1=Fluc_Incr_X1/std(Fluc_Incr_X1);
for q=1:m2-1
Fluc_Incr_X2(q)=Fluc_X2(q+1)-Fluc_X2(q);
end
Fluc_Incr_Normal_X2=Fluc_Incr_X2/std(Fluc_Incr_X2);

%�]�w�W�q�j�p�A����M�w�϶��d��n��
range1=0.005;
range2=0.005;

%------------------------------------------------------------------------------------------------------------------=
%�H�U�@�k�O�N���t�ܰʶq���W�q�A�Hrange1���@�Ӷ��j�A���X�ƭȡA�ݸӶ��j���������h�֤��
%�����q�Z�������Ƴ̻����ƭȶ}�l��A�z�פW�Ҧ����ƾڳ��p�󥦡A�ҥHK�����ӷ|����s�C
%�ӲĤ@��find(abs(Fluc_Incr_Normal_X1)<range1*i)�X�Ӫ�D���ӬO1,2,3...m1�A�|��PDF_1(1:m1)=K=0
%�M��v���Y�p�̻����ƭ�(range1*i�Ai�O�����)�A�o��K�ȷ|�W�ɡA��PDF_1�|�N�ª��ƭȴ��s�C
%�j�鵲����Y�i�o��n�����G
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

%�H�U�@�X����������PDF
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
set(gca,'FontWeight','bold','fontsize',12);%�]�w�r��j�p
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
set(gca,'FontWeight','bold','fontsize',12);%�]�w�r��j�p
legend([h2,t2],'Gaussian','Typhoon');
hold off

end

