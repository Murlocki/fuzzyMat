fis = mamfis('Name','Task1');

%Задали переменные
fis = addInput(fis,[-1,1],'Name','InputX');
fis = addOutput(fis,[0,1],'Name','OutPutY');

%Функции принадлежности для лингвистической входной переменной
fis = addMF(fis,'InputX','gaussmf',[0.01 -1],'Name','vl');
fis = addMF(fis,'InputX','gaussmf',[0.07 -0.6],'Name','l');
fis = addMF(fis,'InputX','gaussmf',[0.07 0],'Name','m');
fis = addMF(fis,'InputX','gaussmf',[0.02 0.3],'Name','mdh');
fis = addMF(fis,'InputX','gaussmf',[0.06 0.7],'Name','h');
fis = addMF(fis,'InputX','gaussmf',[0.01 1 ],'Name','vh');


fis = addMF(fis,'OutPutY','gaussmf',[0.01 0],'Name','l');
fis = addMF(fis,'OutPutY','gaussmf',[0.1 0.4],'Name','mdh');
fis = addMF(fis,'OutPutY','gaussmf',[0.04 0.8],'Name','md');
fis = addMF(fis,'OutPutY','gaussmf',[0.009 0.95],'Name','h');
fis = addMF(fis,'OutPutY','gaussmf',[0.007 1],'Name','vh');

ruleList = [
    1 1 1 1;
    2 3 1 1;
    3 5 1 1;
    5 4 1 1
    6 1 1 1;
];
fis = addRule(fis,ruleList);

%Тыкнем случайно для оценки
x_test = [-1, -0.6, 0, 0.3, 1];
outputValue = evalfis(fis,x_test);
disp(x_test);
disp(outputValue);

figure
subplot(2,1,1);
plotmf(fis,'input',1);
title('MemberShip funcs of InputX');

subplot(2,1,2);
plotmf(fis,'output',1);
title('MemberShip funcs of OutPutY');

figure
gensurf(fis);
xlabel('Input X');
ylabel('OutPut Y');
title('Зависимость y от x');