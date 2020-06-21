%%避圈法求解最小支撑树
m = [0, 1, 1, inf, inf, inf;
     1, 0, 3, 3, inf, inf; 
     1, 3, 0, inf, 2, inf; 
     inf, 3, inf, 0, 2, 2;
     inf, inf, 2, 2, 0, 5;
     inf, inf, inf, 2, 5, 0];
n=6;   %设置矩阵大小
temp=1;  %设置起始点
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
pb(1:length(m))=0;pb(temp)=1;%求出最短路径的点为1，未求出的为0
d(1:length(m))=0;%存放各点的最短距离
path(1:length(m))=0;%存放各点最短路径的上一点标号
while sum(pb)<n %判断每一点是否都已找到最短路径
 tb=find(pb==0);%找到还未找到最短路径的点
 fb=find(pb);%找出已找到最短路径的点
 min=inf;
 for i=1:length(fb)
     for j=1:length(tb)
         plus=d(fb(i))+m(fb(i),tb(j));  %比较已确定的点与其相邻未确定点的距离
         if((d(fb(i))+m(fb(i),tb(j)))<min)
             min=d(fb(i))+m(fb(i),tb(j));
             lastpoint=fb(i);
             newpoint=tb(j);
         end
     end
 end
 d(newpoint)=min;
 pb(newpoint)=1;
 path(newpoint)=lastpoint; %最小值时的与之连接点
end
d %%到各个点的最短距离
path
disp('最短距离是');
disp(d(6));
%%W = [1 1 3 3 2 2 2 5 0];
%%DG = sparse([1 1 2 2 3 4 5 5 6], [2 3 3 4 5 6 4 6 1], W);
%%h = view(biograph(DG, [], 'ShowWeights', 'on'));
%%[dist, path, pred] = graphshortestpath(DG, 1);