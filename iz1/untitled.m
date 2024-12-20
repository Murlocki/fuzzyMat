function output = calcCreditSize(x,number)
    if(number==1) output = trapmf(x,[100000 100000 300000 500000]);
    elseif (number==2) output = trapmf(x,[400000,700000,900000,1200000]);
    else output = trapmf(x,[1100000,1700000,1800000,1800000]);
    end;
end;
function output = calcPercent(x,number)
    if(number==1) output = trapmf(x,[1 3 5 10]);
    elseif (number==2) output = trapmf(x,[5,7,10,13]);
    else output = trapmf(x,[11,14,20,30]);
    end;
end;
function output = calcBankReputation(x,number)
    if(number==1) output = trapmf(x,[1 1 10 20]);
    elseif (number==2) output = trapmf(x,[18,25,40,65]);
    else output = trapmf(x,[50,70,100,100]);
    end;
end;
function output = calcBankScore(x,number)
    if(number==1) output = trapmf(x,[1 1 3 5]);
    elseif (number==2) output = trapmf(x,[3,4,6,8]);
    else output = trapmf(x,[6,8,10,10]);
    end;
end;

rules = [[1,	1,	1,	2],
[1,	1,	2,	3],
[1,	1,	3,	3],
[1,	2,	1,	1],
[1,	2,	2,	2],
[1,	2,	3,	2],
[1,	3,	1,	1],
[1,	3,	2,	1],
[1,	3,	3,	2],
[2,	1,	1,	1],
[2,	1,	2,	2],
[2,	1,	3,	3],
[2,	2,	1,	1],
[2,	2,	2,	1],
[2,	2,	3,	2],
[2,	3,	1,	1],
[2,	3,	2,	1],
[2,	3,	3,	1],
[3,	1,	1,	2],
[3,	1,	2,	2],
[3,	1,	3,	3],
[3,	2,	1,	1],
[3,	2,	2,	1],
[3,	2,	3,	2],
[3,	3,	1,	1],
[3,	3,	2,	1],
[3,	3,	3,	1]
]

function output = calcAgregattionMaxMin(vals,row)
    output = min(calcCreditSize(vals(1),row(1)),min(calcPercent(vals(2),row(2)),calcBankReputation(vals(3),row(3))));
end;
calcAgregattionMaxMin([100000 4 8],[1 1 1]);

function output = calcAgregattionAlg(vals,row)
    output = calcCreditSize(vals(1),row(1)) * calcPercent(vals(2),row(2)) * calcBankReputation(vals(3),row(3));
end;
calcAgregattionMaxMin([100000 4 8],[1 1 1]);
calcAgregattionAlg([100000 4 8],[1 1 1]);

%x = linspace(0,1,1000);
%y = linspace(0,1,1000);
%[X,Y] = meshgrid(x,y);
%figure;
%hold on;
%plot3(X,Y,min(X,Y),'r','DisplayName','maxMin');
%plot3(X,Y,X.*Y,'b','DisplayName','Alg');
%plot(x,min(x,x),'r','DisplayName','maxMin');
%plot(x,x.*x,'b','DisplayName','Alg');
%xlabel('Степень принадлежности входная')
%ylabel('Результат вычисление условия правила')
%legend;

function output = calcMinImplic(vals,row,outputVal)
    output = min(calcAgregattionMaxMin(vals,row),calcBankScore(outputVal,row(4)));
end;
function output = calcProdImplic(vals,row,outputVal)
    output = calcBankScore(outputVal,row(4)) .* calcAgregattionMaxMin(vals,row);
end;

calcMinImplic([100000 4 8],[1 1 1 1],[4,5,6]);
calcProdImplic([100000 4 8],[1 1 1 1],[4,5,6]);



%x = linspace(0,1,1000);
%y = linspace(0,1,1000);
%figure;
%hold on;
%plot(x,min(x,x),'r','DisplayName','Min');
%plot(x,x.*x,'b','DisplayName','Prod');
%xlabel('Степень принадлежности входная')
%ylabel('Результат вычисление импликации')
%legend;

function output = calcMaxAcc(x,vals,rows)
    xOut = x;
    output = 0;
    for i=1:length(rows)
        row = rows(i,:);
        output = max(calcMinImplic(vals,row,xOut),output);
    end;
end;
function output = calcSumAcc(x,vals,rows)
    xOut = x;
    output = 0;
    for i=1:length(rows)
        row = rows(i,:);
        output = calcMinImplic(vals,row,xOut) + output;
    end;
    output = min(1,output)
end;

x = linspace(1,10,1000000);
input = [100000,8,8];

%figure;
%hold on;
%plot(x,calcMaxAcc(x,input,rules),'Color','r','DisplayName','MaxAcc');
%plot(x,calcSumAcc(x,input,rules),'Color','g','DisplayName','SumAcc');
%xlabel('Оценка')
%ylabel('Степень принадлежности')
%legend;


function output = calcCentroid(x,input,rules)
    mf = calcMaxAcc(x,input,rules);
    numerator = trapz(x, x .* mf);
    denominator = trapz(x, mf);
    output = numerator/denominator;
end;
function output = calcBissect(x,input,rules)
    mf = calcMaxAcc(x,input,rules);
    totalArea = trapz(x, mf);
    halfArea = totalArea/2;
    currentArea = 0;
    output = NaN;

    for i=1:length(x)
        currentArea = currentArea + trapz(x(i:i+1),mf(i:i+1));
        if currentArea >= halfArea
            output = x(i);
            break;
        end;
    end;
end;
bis = calcBissect(x,input,rules);
centr = calcCentroid(x,input,rules);

figure;
hold on;
plot(x,calcMaxAcc(x,input,rules),'Color','r');
plot([bis,bis],[0,1],'Color','b','DisplayName','Bissector');
plot([centr,centr],[0,1],'Color','g','DisplayName','Centroid');
xlabel('Оценка')
ylabel('Степень принадлежности')
legend;