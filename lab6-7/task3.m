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
    outputString = sprintf("%s\n",setName);
    % Форматируем строки для каждого элемента и конкатенируем их
    for i = 1:length(degrees)
        outputString = strcat(outputString,sprintf(" %d | %.2f\n", names(i), degrees(i)));
    end;
end;

function outputString = displayNewFuzzySetStr(degrees,names,setName)
    outputString = sprintf("%s\n",setName);
    % Форматируем строки для каждого элемента и конкатенируем их
    for i = 1:length(degrees)
        outputString = strcat(outputString,sprintf(" %s | %.2f\n", names(i), degrees(i)));
    end;
end;

% По мощности
names = 1:6;
pairwiseComparisonsPower = [
    [1,   3,   1/2, 2, 4, 1/4],
    [1/3, 1,   1/3, 1/2, 3, 1/4],
    [2,   3,   1,   2, 4, 1/3],
    [1/2, 2,   1/2, 1, 3, 1/3],
    [1/4, 1/3, 1/4, 1/3,  1, 1/5],
    [4,   4,   3,   3,    5, 1],
];
disp(checkCon(pairwiseComparisonsPower,1.24));
degreesPower = calcDegrees(pairwiseComparisonsPower);
disp(displayNewFuzzySet(degreesPower,names,"Power"))

% По крутящему моменту
names = 1:6;
pairwiseComparisonsWeight = [
    [1,   3,   6,   4,   1,   5],
    [1/3, 1,   5,   3,   1/2, 4],
    [1/6, 1/5, 1,   1/4, 1/6, 1/3],
    [1/4, 1/3, 4,   1,   1/4, 1/2],
    [1,   2,   6,   4,   1,   5],
    [1/5, 1/4, 3,   2,   1/5, 1],
];
disp(checkCon(pairwiseComparisonsWeight,1.24));
degreesWeight = calcDegrees(pairwiseComparisonsWeight);
disp(displayNewFuzzySet(degreesWeight,names,"Weight"));

% По крутящему моменту
names = 1:6;
pairwiseComparisonsMoment = [
    [1,   3,   1/3, 2,   5,   2],
    [1/3, 1,   1/4, 1/3, 3,   1/4],
    [3,   4,   1,   3,   6,   3],
    [1/2, 3,   1/3, 1,   4,   1],
    [1/5, 1/3, 1/6, 1/4, 1,   1/5],
    [1/2, 4,   1/3, 1,   5,   1],
];
disp(checkCon(pairwiseComparisonsMoment,1.24));
degreesMoment = calcDegrees(pairwiseComparisonsMoment);
disp(displayNewFuzzySet(degreesMoment,names,"Moment"))


% Сравнение самих критериев
% По весу
names = ["Мощность","Момент","Масса"];
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
disp(displayNewFuzzySet(result,names,"Engine"));
