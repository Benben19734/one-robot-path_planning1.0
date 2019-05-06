%clc;
%clear;
%close all;
function bfs(handles,map2,start_node,dest_node)
%  uicontrol('Style','pushbutton','String','again', 'FontSize',12, ...
%        'Position', [1 1 60 40], 'Callback','bfs');
%% set up color map for display 
cmap = [1 1 1; ...%  1 - white - �յ�
        0 0 0; ...% 2 - black - �ϰ� 
        1 0 0; ...% 3 - red - ���������ĵط�
        0 0 1; ...% 4 - blue - �´�������ѡ���� 
        0 1 0; ...% 5 - green - ��ʼ��
        1 1 0;...% 6 - yellow -  ��Ŀ����·�� 
       1 0 1];% 7 - -  Ŀ��� 
colormap(cmap); 
map1 = map2;
%wallpercent=0.4;
% % �������ϰ� 
%map1(ceil(10^2.*rand(floor(10*10*wallpercent),1))) =2;
%  map(ceil(10.*rand),ceil(10.*rand)) = 5; % ��ʼ��
%map(ceil(10.*rand),ceil(10.*rand)) = 6; % Ŀ���
% %% ������ͼ
nrows = 11; 
ncols = 11;  
% % ����ÿ����Ԫ��������鱣���丸�ڵ�������� 
parent = zeros(nrows,ncols);
array=start_node;
% % ��ѭ��
% tic
axes(handles);%��handles����Ϊ��ǰ���
 while ~isempty(array) 
  % ������״ͼ
  map1(start_node) = 5;
  map1(dest_node) = 7;
  image(handles,1.5, 1.5, map1); 
  grid on; 
  set(gca,'gridline','-','gridcolor','r','linewidth',2);
  set(gca,'xtick',1:1:12,'ytick',1:1:12);
  axis image; 
  title('����{ \color{red}BFS} �㷨��·���滮 ','fontsize',16)
  drawnow; 
  
   current=array(1);
   array(1)=[];
   if ((current == dest_node) ) %������Ŀ������ȫ�������꣬����ѭ����
         break; 
   end; 
  map1(current) = 3; %����ǰ��ɫ��Ϊ��ɫ��
  
 [i, j] = ind2sub(size(map1), current); %���ص�ǰλ�õ�����
 neighbor = [  
            i,j+1;... 
            i+1,j;... 
            i-1,j;... 
             i,j-1]; %ȷ����ǰλ�õ�������������     
 %neighbor1 = [ 
    %    i-1,j-1;...
     %   i+1,j+1;...
      %  i-1,j+1;...
       %  i+1,j-1]; %ȷ����ǰλ�õĶԽ�����      
 outRangetest = (neighbor(:,1)<1) + (neighbor(:,1)>nrows) +...
                    (neighbor(:,2)<1) + (neighbor(:,2)>ncols ); %�ж���һ�������������Ƿ񳬳����ơ�   
 % outRangetest1 = (neighbor1(:,1)<1) + (neighbor1(:,1)>nrows) +...
     %                (neighbor1(:,2)<1) + (neighbor1(:,2)>ncols ); %�ж���һ�������������Ƿ񳬳����ơ�        
 locate = outRangetest>0; %���س��޵��������
  % locate1 = find(outRangetest1>0); %���س��޵��������
 neighbor(locate,:)=[]; %����һ������������ȥ�����޵㣬ɾ��ĳһ�С�
 neighborIndex = sub2ind(size(map1),neighbor(:,1),neighbor(:,2)); %�����´���������������š�
  % neighbor1(locate1,:)=[]; %����һ������������ȥ�����޵㣬ɾ��ĳһ�С�
   % neighborIndex1 = sub2ind(size(map1),neighbor1(:,1),neighbor1(:,2)); %�����´���������������š�

 for i=1:length(neighborIndex) 
 if (map1(neighborIndex(i))~=2) && (map1(neighborIndex(i))~=3 && map1(neighborIndex(i))~= 5) 
     map1(neighborIndex(i)) = 4; %����´������ĵ㲻���ϰ���������㣬û���������ͱ�Ϊ��ɫ��
     if(isempty(find(array==neighborIndex(i), 1)))
      array=[array;neighborIndex(i)];
      parent(neighborIndex(i)) = current;
     end
  end 
 end 
 end
 

if (current ~= dest_node) 
    route = [];
else
    %��ȡ·������
  route =dest_node ;
  while (parent(route(1)) ~= 0) 
         route = [parent(route(1)), route];     
   end 
%  ��̬��ʾ��·�� 
        for k = 2:length(route) - 1 
              map1(route(k)) = 6; 
               image(1.5, 1.5, map1);
                set(gca,'gridline','-','gridcolor','r','linewidth',2);
                set(gca,'xtick',1:1:12,'ytick',1:1:12);
              grid on; 
              axis image; 
  title('����{ \color{red}BFS} �㷨��·���滮 ','fontsize',16);
  drawnow;
        end  
end        
%title('����{ \color{red}BFS} �㷨��·���滮 ','fontsize',16)
toc
