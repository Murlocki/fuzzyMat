function outputString = printFuzzySet(setName,universum,degrees)
    outputStr = strcat(setName,' =');
    % Форматируем строки для каждого элемента и конкатенируем их
    for i = 1:length(universum)
        outputStr = strcat(outputStr,sprintf(' %s/M(%.2f)+', universum(i), degrees(i)));
    end
    outputStr = outputStr(1:end-1 );
    outputString = outputStr;
end

u = 1:7 %юниверсуем дней недели
A = [1,0.9,0.7,0.5,0,0,0] %начало недели
B = [0,0.3,0.8,1,0.8,0.3,0.0] %середина недели
C = flip([1,0.9,0.7,0.5,0,0,0]) %конец недели
D = [0,0.4,0.8,1,0.8,0.4,0] %не начало и не конец недели
figure(Name="Множества дней недели")
hold on
plot(u,A,'r')
plot(u,B,'g')
plot(u,C,'b')
plot(u,D,'y')
hold off
legend('Начало недели','Середина недели','Конец недели','Не начало и не конец недели')
title('Множества дней недели');
xlabel('Дни недели');
ylabel('Степени принадлежности');

%Выводим множества
uNames = ["Понедельник","Вторник","Среда","Четверг","Пятница","Суббота","Воскресенье"] 
disp(printFuzzySet('A',uNames,A))
disp(printFuzzySet('B',uNames,B))
disp(printFuzzySet('C',uNames,C))
disp(printFuzzySet('D',uNames,D))