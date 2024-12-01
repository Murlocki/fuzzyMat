% Определение количества обучающих примеров
numSamples = 1000;

% Генерация обучающих данных
x1 = rand(numSamples, 1) * 10; % Случайные значения x1 от 0 до 10
x2 = rand(numSamples, 1) * 10; % Случайные значения x2 от 0 до 10
x3 = rand(numSamples, 1) * 10; % Случайные значения x3 от 0 до 10

% Вычисление целевых значений y
y = x1 ./ (x2 + x3); % Целевая функция

% Объединение входных данных в матрицу
inputs = [x1, x2, x3]';

% Определение структуры нейронной сети
hiddenLayerSize = 10; % Количество нейронов в скрытом слое
net = feedforwardnet(hiddenLayerSize); % Создание сети с одним скрытым слоем

% Настройка параметров обучения
net.trainParam.epochs = 1000; % Количество эпох обучения
net.trainParam.lr = 0.01; % Скорость обучения

% Обучение нейронной сети
net = train(net, inputs, y');

% Тестирование сети на новых данных
testSamples = 10;
x1_test = rand(testSamples, 1) * 10;
x2_test = rand(testSamples, 1) * 10;
x3_test = rand(testSamples, 1) * 10;
inputs_test = [x1_test, x2_test, x3_test]';
y_test = x1_test ./ (x2_test + x3_test); % Целевые значения для теста

% Получение предсказаний от обученной сети
y_pred = net(inputs_test);

% Визуализация результатов
figure;
plot(y_test, 'bo-', 'LineWidth', 2); % Целевые значения
hold on;
plot(y_pred', 'r*-', 'LineWidth', 2); % Предсказанные значения
title('Сравнение целевых и предсказанных значений');
xlabel('Примеры');
ylabel('Значения');
legend('Целевые значения', 'Предсказанные значения');
grid on;