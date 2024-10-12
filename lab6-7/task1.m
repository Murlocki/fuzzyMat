%Функция проверки согласованности
function con = checkCon(pairwiseComparisons,os)
    pairGeomean = geomean(pairwiseComparisons,2);
    %disp(pairGeomean);
    pairGeomeanNorm = pairGeomean/sum(pairGeomean);

    pairColumnSum = sum(pairwiseComparisons);
    %disp(pairColumnSum);

    labmdaMax = dot(pairGeomeanNorm,pairColumnSum);
    is = (labmdaMax - length(pairwiseComparisons))/(length(pairwiseComparisons)-1);
    con = is/os < 0.1;
end

function degrees = calcDegrees(pairwiseComparisons)
    pairGeomean = geomean(pairwiseComparisons,2);
    %disp(pairGeomean);
    pairGeomeanNorm = pairGeomean/sum(pairGeomean);
    degrees = pairGeomeanNorm;
end;
function outputString = displayNewFuzzySet(degrees,names,setName)
    outputStr = strcat(setName,' =');
    % Форматируем строки для каждого элемента и конкатенируем их
    for i = 1:length(degrees)-1
        outputStr = strcat(outputStr,sprintf(" %d/M(%.2f)+", names(i), degrees(i)));
    end;
    outputString = strcat(outputStr,sprintf(" %d/M(%.2f)", names(length(degrees)), degrees(length(degrees))));
end;

function outputString = displayNewFuzzySetStr(degrees,names,setName)
    outputStr = strcat(setName,' =');
    % Форматируем строки для каждого элемента и конкатенируем их
    for i = 1:length(degrees)-1
        outputStr = strcat(outputStr,sprintf(" %s/M(%.2f)+", names(i), degrees(i)));
    end;
    outputString = strcat(outputStr,sprintf(" %s/M(%.2f)", names(length(degrees)), degrees(length(degrees))));
end;

% По мощности
names = 1:6;
pairwiseComparisonsPower = [
    [1, 3, 3, 1/2, 2, 1],
    [1/3, 1, 1, 1/3, 1/2, 1/3],
    [1/3, 1, 1, 1/3, 1/2, 1/3],
    [2, 3, 3, 1, 3, 2],
    [1/2, 2, 2, 1/3, 1, 1/3],
    [1, 3, 3, 1/2, 1/3, 1],
];
disp(checkCon(pairwiseComparisonsPower,1.24));
degreesPower = calcDegrees(pairwiseComparisonsPower);
disp(displayNewFuzzySet(degreesPower,names,"EnginePower"))

% По моменту
names = 1:6;
pairwiseComparisonsMoment = [
    [1,   1/3, 1/2, 1,   1/2, 2],
    [3,   1,   2,   3,   2,   4],
    [2,   1/2, 1,   2,   1,   3],
    [1,   1/3, 1/2, 1,   1/2, 2],
    [2,   1/2, 1,   2,   1,   3],
    [1/2, 1/4, 1/3, 1/2, 1/3, 1],
];
disp(checkCon(pairwiseComparisonsMoment,1.24));
degreesMoment = calcDegrees(pairwiseComparisonsMoment);
disp(displayNewFuzzySet(degreesMoment,names,"Moment"))

% По весу
names = 1:6;
pairwiseComparisonsWeight = [
    [1,   3,   2,   1/3, 2,   1/5],
    [1/3, 1,   1/2, 1/4, 1/2, 1/6],
    [1/2, 2,   1,   1/2,   1, 1/4],
    [3,   4,   2,   1,   3,   1/2],
    [1/2, 2,   1,   1/3, 1,   1/4],
    [5,   6,   4,   2,   4,   1],
];
disp(checkCon(pairwiseComparisonsWeight,1.24));
degreesWeight = calcDegrees(pairwiseComparisonsWeight);
disp(displayNewFuzzySet(degreesWeight,names,"Weight"))


% Сравнение самих критериев
% По весу
names = ["Мощность","Момент","Вес"];
pairwiseComparisonsProp = [
    [1,   2,   3],
    [1/2, 1,   2],
    [1/3, 1/2,   1],
];
disp(checkCon(pairwiseComparisonsProp,0.58));
degreesProps = calcDegrees(pairwiseComparisonsProp);
disp(displayNewFuzzySetStr(degreesProps,names,"Props"))
% Финальное вычисление
result = cat(2,degreesPower,degreesMoment,degreesWeight) * degreesProps;
names = 1:6;
disp(displayNewFuzzySet(result,names,"Engines"));