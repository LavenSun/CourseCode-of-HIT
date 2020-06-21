year = [2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011, 2012];
data = [4, 6, 5, 8, 9, 5, 4, 3, 7, 8];
T = 3;
n = 5;
%%简单平均法
figure(1);
plot(year, data, 'r');
hold on;
for i = 1:(length(data)-n+1)
    data(i+7) = sum(data(i:i+n-1))/n;
end
plot([year 2013 2014 2015], data, 'g--');
grid on;
legend('原始数据', '简单平均法的数据');
xlabel('年度');
ylabel('销售量');
%%一次指数平滑法
data1 = [4, 6, 5, 8, 9, 5, 4, 3, 7, 8];
s0 = data1(1);
alpha = 0.1;
s(1) = alpha*data1(1)+(1-alpha)*s0;
for i = 2:length(data1)
    s(i) = alpha*data1(i)+(1-alpha)*s(i-1);
end
datanewexpo = [data1(1:T) s];
figure(2);
plot(year, data1,'r');
hold on;
plot([year 2013 2014 2015], datanewexpo, 'g--');
grid on;
xlabel('年度');
ylabel('销售量');
ss0 = data1(1);
alpha = 0.3;
ss(1) = alpha*data1(1)+(1-alpha)*ss0;
for i = 2:length(data1)
    ss(i) = alpha*data1(i)+(1-alpha)*ss(i-1);
end
datanewexpo1 = [data1(1:T) ss];
%%绘图
figure(3);
plot(year, data1, 'r');
hold on;
plot([year 2013 2014 2015], data, 'g--');
grid on;
plot([year 2013 2014 2015], datanewexpo1, 'b-');
legend('原始数据', '一次移动平滑后的数据', '一次指数平滑');
