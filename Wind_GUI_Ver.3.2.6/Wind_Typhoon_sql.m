function Wind_Typhoon_sql(wind_typhoon,cut,title_typhoon)  
    [m,n]=size(wind_typhoon);%���o��Ʈw���C�B���
    x=ceil(linspace(1,m,cut)); %�N�C��������cut-1����
    %�H�U�]�w��b��T�A�N�����ܦb�Ϫ���СA�`�@���cut�ӡA�C�椧�����Z���@��
    tt={};
    for j=1:cut
    tt=[tt,wind_typhoon{x(j),1}(7:16)];
    xposi(j)=x(j);%����cut�Ӥ����x�y��
    end
    yposi=(ceil(min(cell2mat(wind_typhoon(:,2))))-5.5)*ones(1,cut);%����cut�Ӥ����y�y��
    
    subplot(2,1,1);
    plot(1:m,cell2mat(wind_typhoon(:,2)),'r');%���X�ɶ��P���O����
    grid on
    set(gca,'XTick',xposi);  %����b�W����׽u����cut�Ӥ����x�y��
    set(gca,'XTickLabel',[]);%����ܾ�b����T(�o�̾�b��T�O�ۤv�]�w��)
    axis([0 m ceil(min(cell2mat(wind_typhoon(:,2))))-5 ceil(max(cell2mat(wind_typhoon(:,2))))]);%�]�w�a��b���
    title(title_typhoon);
    ylabel('���� (�ʩ�)');
    set(gca,'FontWeight','bold','fontsize',15);%�]�w�r��j�p
    %�N��b��T�K��ϤW
    ht=text(xposi,yposi,tt,'HorizontalAlignment', 'right', 'rotation', 90,'FontWeight','bold','fontsize',10);
    
    subplot(2,1,2);
    plot(1:m,cell2mat(wind_typhoon(:,3)),'b');%���X�ɶ��P���t����
    grid on
    set(gca,'XTick',xposi);  %����b�W����׽u����cut�Ӥ����x�y��
    set(gca,'XTickLabel',[]);%����ܾ�b����T(�o�̾�b��T�O�ۤv�]�w��)
    axis([0 m ceil(min(cell2mat(wind_typhoon(:,3))))-5 ceil(max(cell2mat(wind_typhoon(:,3))))]);%�]�w�a��b���
    xlabel('�ɶ�');
    ylabel('���t (m/s)');
    set(gca,'FontWeight','bold','fontsize',15);%�]�w�r��j�p
    
end

