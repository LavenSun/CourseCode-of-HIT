%线性规划1
f1 = [-2,-3];
A1 = [1,2;2,0;0,1];
b1 = [8;8;3];
Aeq1 = [];
beq1 = [];
lb1 = [0,0,0,0,0,0];
ub1 = [inf,inf,inf,inf,inf,inf];
x1  = linprog(f1,A1,b1,Aeq1,beq1,lb1,ub1);
%线性规划2
f2 = [-5,-4,-6];
A2 = [1,-1,1;3,2,4;3,2,0];
b2 = [20;42;30];
Aeq2 = [];
beq2 = [];
lb2 = [0,0,0,0,0,0];
ub2 = [inf,inf,inf,inf,inf,inf];
x2  = linprog(f2,A2,b2,Aeq2,beq2,lb2,ub2);
%分配问题
Aeq3 = ones(1,16);
beq3 = 4;
A3 = [1,1,1,1,zeros(1,12);
     zeros(1,4),1,1,1,1,zeros(1,8);
     zeros(1,8),1,1,1,1,zeros(1,4);
     zeros(1,12),1,1,1,1;
     1,zeros(1,3),1,zeros(1,3),1,zeros(1,3),1,zeros(1,3);
     0,1,zeros(1,2),0,1,zeros(1,2),0,1,zeros(1,2),0,1,zeros(1,2);
     0,0,1,0,0,0,1,0,0,0,1,0,0,0,1,0;
     0,0,0,1,0,0,0,1,0,0,0,1,0,0,0,1];
 b3 = ones(1,8);
 lb3 = zeros(1,16);
 ub3 = ones(1,16);
 f3 = [2,10,9,7,15,4,14,8,13,14,16,11,4,15,13,9];
 [x3,fval] = intlinprog(f3,1:16,A3,b3,Aeq3,beq3,lb3,ub3);
 %非线性规划
 [x4,y4] = fmincon(@FeiXianXingGuiHua,rand(2,1),[1,-1],8,[],[],zeros(1,2),[],@FeiXianXingGuiHuaTiaoJian);