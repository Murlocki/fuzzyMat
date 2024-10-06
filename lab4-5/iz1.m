function outputString = displayNewFuzzySet(degrees,names,setName)
    outputStr = sprintf("%s\n",setName);
    % Форматируем строки для каждого элемента и конкатенируем их
    for i = 1:length(degrees)
        outputStr = strcat(outputStr,sprintf(" %s|%.2f \n", names(i), degrees(i)));
    end;
    outputString = outputStr;
end;



names = ["Качество зерна","Цена зерна","Транспортные расходы","Форма оплаты","Минимальная партия","Надежность поставки"];
rangs = [2,1,6,5,3,4];
matr = zeros(6,6);
for i=1:6
    for j=1:6
        if rangs(i)>=rangs(j)
            matr(i,j) = 1;
        else
            matr(i,j) = 0;
        end;
    end;
end;
disp(matr);

degrees = ones(6,1);
for k=1:3
    degrees = matr * degrees;
end;
degrees = degrees / sum(degrees);
disp(degrees);
disp(displayNewFuzzySet(degrees,names,"Критерии"))