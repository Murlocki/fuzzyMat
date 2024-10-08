
function degrees = calcDegrees(pairwiseComparisons,element)
    matr = zeros(length(pairwiseComparisons),length(pairwiseComparisons))
    for i=1:length(pairwiseComparisons)
        for j=1:length(pairwiseComparisons)
            if pairwiseComparisons(i,j)=="="
                matr(i,j) = 1;
            elseif pairwiseComparisons(i,j)==">"
                matr(i,j) = 1+element;
            else
                matr(i,j) = 1 - element;
            end
        end;
    end;
    degrees = ones(length(pairwiseComparisons),1);
    for k=1:length(pairwiseComparisons)
        degrees = matr * degrees;
    end;
    degrees = degrees/sum(degrees)
end;

function outputString = displayNewFuzzySet(degrees,names,setName)
    outputStr = strcat(setName,' =');
    % Форматируем строки для каждого элемента и конкатенируем их
    for i = 1:length(degrees)-1
        outputStr = strcat(outputStr,sprintf(" %s/M(%.2f)+", names(i), degrees(i)));
    end;
    outputString = strcat(outputStr,sprintf(" %s/M(%.2f)", names(length(degrees)), degrees(length(degrees))));
end;

function degreesUnzip = unzipDegrees(degrees)
    degreesUnzip = [];
    for i= 1:8
        degreesUnzip = [degreesUnzip,repmat(degrees(i),1,15)];
    end;
end;

%А - молодой
%Создаем пустую матрицу сравнений
%Сделаем не для всех значений, а для участков по 15 лет
names = ["1-15","16-30","31-45","46-60","61-75","76-90","91-105","106-120"];
%disp(names);
pairwiseComparisonsA = [
    ["=",">",">",">",">",">",">",">"],
    ["<","=",">",">",">",">",">",">"],
    ["<","<","=",">",">",">",">",">"],
    ["<","<","<","=",">",">",">",">"],
    ["<","<",">",">","=",">",">",">"],
    ["<","<","<","<","<","=",">",">"],
    ["<","<","<","<","<","<","=",">"],
    ["<","<","<","<","<","<","<","="]
];
degreesA = calcDegrees(pairwiseComparisonsA,1);
disp(displayNewFuzzySet(degreesA,names,"A"));

%B - старый
pairwiseComparisonsB = [
    ["=","<","<","<","<","<","<","<"],
    [">","=","<","<","<","<","<","<"],
    [">",">","=","<","<","<","<","<"],
    [">",">",">","=","<","<","<","<"],
    [">",">",">",">","=","<","<","<"],
    [">",">",">",">",">","=","<","<"],
    [">",">",">",">",">",">","=","<"],
    [">",">",">",">",">",">",">","="]
];
degreesB = calcDegrees(pairwiseComparisonsB,1);
disp(displayNewFuzzySet(degreesB,names,"B"));


%С - очень молодой
pairwiseComparisonsC = [
    ["=",">",">",">",">",">",">",">"],
    ["<","=",">",">",">",">",">",">"],
    ["<","<","=",">",">",">",">",">"],
    ["<","<","<","=",">",">",">",">"],
    ["<","<","<","<","=",">",">",">"],
    ["<","<","<","<","<","=",">",">"],
    ["<","<","<","<","<","<","=",">"],
    ["<","<","<","<","<","<","<","="]
];
degreesC = calcDegrees(pairwiseComparisonsC,1);
disp(displayNewFuzzySet(degreesC,names,"C"));


%D - не старый
pairwiseComparisonsD = [
    ["=",">",">",">",">",">",">",">"],
    ["<","=",">",">",">",">",">",">"],
    ["<","<","=",">",">",">",">",">"],
    ["<","<","<","=",">",">",">",">"],
    ["<","<","<","<","=",">",">",">"],
    ["<","<","<","<","<","=",">",">"],
    ["<","<","<","<","<","<","=",">"],
    ["<","<","<","<","<","<","<","="]
];
degreesD = calcDegrees(pairwiseComparisonsD,1);
disp(displayNewFuzzySet(degreesD,names,"D"));



figure(Name="Множества возраста")
plot(1:120,unzipDegrees(degreesA),'r','DisplayName','Молодой');
hold on
plot(1:120,unzipDegrees(degreesB),'b','DisplayName','Старый');
plot(1:120,unzipDegrees(degreesC),'g','DisplayName','Очень молодой');
plot(1:120,unzipDegrees(degreesD),'y','DisplayName','Не старый');

hold off
legend show
title('Множества возрастов');
xlabel('Промежутки возрастов');
ylabel('Степени принадлежности');