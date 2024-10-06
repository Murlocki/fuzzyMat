function ranks = calculateRanks(values)
    % Проверка на пустой вектор
    if isempty(values)
        ranks = [];
        return;
    end
    n = length(values);
    ranks = zeros(size(values));
    [sortedValues, sortedIndices] = sort(values,"descend");
    
    % Присвоение рангов с учетом одинаковых значений
    currentRank = 1;
    i = 1; 
    
    while i <= n
        % Найти количество одинаковых значений
        count = length(sortedValues(sortedValues==sortedValues(i)));
        if count > 1
            su = sum(find(sortedValues == sortedValues(i)));
            % Если есть одинаковые значения, присваиваем средний ранг
            averageRank = su/count; % Средний ранг для одинаковых значений
            
            % Присвоение среднего ранга всем одинаковым элементам
            for j = 0:(count - 1)
                ranks(sortedIndices(i + j)) = averageRank;
            end
            
            % Увеличиваем текущий ранг до ближайшего целого числа в большую сторону после среднего
            currentRank = ceil(averageRank);
        else
            % Если уникальное значение, просто присваиваем текущий ранг
            ranks(sortedIndices(i)) = currentRank;
            currentRank = currentRank + 1; % Переход к следующему рангу
        end
        
        % Перейти к следующему уникальному элементу
        i = i + count;
        
        % Если есть одинаковые значения, следующий ранг устанавливаем на ближайшее целое число в большую сторону.
        if count > 1
            currentRank = ceil(currentRank); 
        end
    end

end

function t = calcT(ranks)
    uniqueRanks = unique(ranks);
    t = 0;
    for j=1:length(uniqueRanks)
        countOfEqRanks = length(find(uniqueRanks(j)==ranks));
        t = t + countOfEqRanks^3 - countOfEqRanks;
    end;
end;

function w = calcW(dArray,tAr,exCount,ObCount) 
    w = 0;
    dSq = dArray .^2;
    w = 12 * sum(dSq)/(exCount^2*(ObCount^3 - ObCount) - exCount * sum(tAr));
end;
rangMatrix = transpose([
    calculateRanks([0.25,0.25,0.1,0.4]),
    calculateRanks([0.2,0.3,0.4,0.1]),
    calculateRanks([0.1,0.4,0.25,0.2]),
    calculateRanks([0.3,0.4,0.2,0.2])
    ])
rangsSum = sum(rangMatrix,2)
meanRang = sum(rangsSum)/length(rangsSum)
dArray = rangsSum - meanRang

tAr = [calcT(rangMatrix(1:end,1)),
       calcT(rangMatrix(1:end,2)),
       calcT(rangMatrix(1:end,3)),
       calcT(rangMatrix(1:end,4))]
w = calcW(dArray,tAr,4,4)

rangsInvSum = rangsSum .^-1
rangsInvSumSum = sum(rangsInvSum)
degrees = rangsInvSum ./ rangsInvSumSum