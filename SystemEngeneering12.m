%%��Ȧ�������С֧����
m = [0, 1, 1, inf, inf, inf;
     1, 0, 3, 3, inf, inf; 
     1, 3, 0, inf, 2, inf; 
     inf, 3, inf, 0, 2, 2;
     inf, inf, 2, 2, 0, 5;
     inf, inf, inf, 2, 5, 0];
n=6;   %���þ����С
temp=1;  %������ʼ��
for i=1:n
    for j=1:n
       if(m(i,j)==0)
           m(i,j)=inf;
       end
    end
end
for i=1:n
    m(i,i)=0;
end
pb(1:length(m))=0;pb(temp)=1;%������·���ĵ�Ϊ1��δ�����Ϊ0
d(1:length(m))=0;%��Ÿ������̾���
path(1:length(m))=0;%��Ÿ������·������һ����
while sum(pb)<n %�ж�ÿһ���Ƿ����ҵ����·��
 tb=find(pb==0);%�ҵ���δ�ҵ����·���ĵ�
 fb=find(pb);%�ҳ����ҵ����·���ĵ�
 min=inf;
 for i=1:length(fb)
     for j=1:length(tb)
         plus=d(fb(i))+m(fb(i),tb(j));  %�Ƚ���ȷ���ĵ���������δȷ����ľ���
         if((d(fb(i))+m(fb(i),tb(j)))<min)
             min=d(fb(i))+m(fb(i),tb(j));
             lastpoint=fb(i);
             newpoint=tb(j);
         end
     end
 end
 d(newpoint)=min;
 pb(newpoint)=1;
 path(newpoint)=lastpoint; %��Сֵʱ����֮���ӵ�
end
d %%�����������̾���
path
disp('��̾�����');
disp(d(6));
%%W = [1 1 3 3 2 2 2 5 0];
%%DG = sparse([1 1 2 2 3 4 5 5 6], [2 3 3 4 5 6 4 6 1], W);
%%h = view(biograph(DG, [], 'ShowWeights', 'on'));
%%[dist, path, pred] = graphshortestpath(DG, 1);