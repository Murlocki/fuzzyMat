% Определение диапазона значений цен
x = linspace(0, 5000, 5000); % От 0 до 5000

% Функция принадлежности μA(x)
mu_A = zeros(size(x));
mu_A(x >= 0 & x < 100) = (x(x >= 0 & x < 100)) / 100;
mu_A(x >= 100 & x < 500) = 1;
mu_A(x >= 500 & x < 600) = (600 - x(x >= 500 & x < 600)) / (600-500);

% Функция принадлежности μB(x)
mu_B = zeros(size(x));
mu_B(x >= 500 & x < 5000) = (x(x >= 500 & x < 5000) - 500) / (5000 - 500);
mu_B(x >= 5000) = 1;

% Функция принадлежности μC(x)
mu_C = zeros(size(x));
mu_C(x < 500) = 1;
mu_C(x >= 500 & x < 2000) = (2000 - x(x >= 500 & x < 2000)) / (2000 - 500);

% Построение графиков
figure;
hold on;
plot(x, mu_A, 'b', 'LineWidth', 2, 'DisplayName', '\mu_A(x)');
plot(x, mu_B, 'r', 'LineWidth', 2, 'DisplayName', '\mu_B(x)');
plot(x, mu_C, 'g', 'LineWidth', 2, 'DisplayName', '\mu_C(x)');
hold off;

xlabel('Цена автомобиля');
ylabel('Степень принадлежности');
title('Функции принадлежности для цен автомобилей');
legend show;
grid on;

% Определение уровней
levels = linspace(0, 1, 10);

% Разложение по уровням для каждой функции
disp('Разложение по уровням:');

% Для каждой функции
for func_idx = {'μa', 'μb', 'μc'}
    fprintf('Разложение для %s:\n', func_idx{1});
    
    % Разложение по уровням
    decomposition = ''; % Инициализация строки для разложения
    
    for level = levels
        % Находим значения x для каждого уровня
        if strcmp(func_idx{1}, 'μa')
            values = find(mu_A >= level);
        elseif strcmp(func_idx{1}, 'μb')
            values = find(mu_B >= level);
        elseif strcmp(func_idx{1}, 'μc')
            values = find(mu_C >= level);
        end
        
        % Записываем минимальные и максимальные значения x для каждого уровня
        if ~isempty(values)
            min_x = min(x(values));
            max_x = max(x(values));
            interval_str = sprintf('%.1f[%.2f, %.2f]', level, min_x, max_x);
            decomposition = [decomposition, interval_str, ' + ']; % Добавляем к строке разложения
        end
    end
    
    % Удаляем последний ' + '
    if ~isempty(decomposition)
        decomposition(end-2:end) = []; % Удаляем последние три символа '+ '
    end
    
    fprintf('%s\n', decomposition);
end