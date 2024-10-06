% Определение диапазона значений
x = linspace(0, 15, 400); % От 0 до 15 для функций a и b, и немного больше для d

% Функция принадлежности μa(x)
mu_a = zeros(size(x));
mu_a(x >= 0 & x <= 5) = 1; % μa(x) = 1, если 0 ≤ x ≤ 5
% μa(x) остается равной нулю для остальных значений

% Функция принадлежности μb(x)
mu_b = zeros(size(x));
mu_b(x >= 5 & x <= 10) = exp(-(x(x >= 5 & x <= 10)-5)/5); % μb(x)

% Функция принадлежности μc(x)
a1 = 5;
a2 = 10;
mu_c = zeros(size(x));
mu_c(x > a2) = 1; % μc(x) = 1, если x > a2
mu_c(x >= a1 & x <= a2) = (x(x >= a1 & x <= a2)-a1)/(a2-a1); % μc

% Функция принадлежности μd(x)
mu_d = zeros(size(x));
mu_d(x > 0) = 1 ./ (1 + 2 * (x(x > 0).^2)); % μd

% Построение графиков
figure;
hold on;
plot(x, mu_a, 'b', 'LineWidth', 2, 'DisplayName', '\mu_a(x)');
plot(x, mu_b, 'r', 'LineWidth', 2, 'DisplayName', '\mu_b(x)');
plot(x, mu_c, 'g', 'LineWidth', 2, 'DisplayName', '\mu_c(x)');
plot(x, mu_d, 'm', 'LineWidth', 2, 'DisplayName', '\mu_d(x)');
hold off;

xlabel('x');
ylabel('Степень принадлежности');
title('Функции принадлежности');
legend show;
grid on;

% Разложение по уровням
disp('Разложение по уровням для μa:');
disp('Уровень: a -> x ∈ [0,5]');
disp('Уровень: 0 -> все');

disp('Разложение по уровням для μb:');
disp('Уровень: a -> x ∈ [5,5*ln(a)+5]');
disp('Уровень: 0 -> все');

disp('Разложение по уровням для μc:');
disp('Уровень: a -> x ∈ [a*(a2-a1)+a1,+беск]');
disp('Уровень: 0 -> все');
disp('Уровень: 1 -> x > a2');

disp('Разложение по уровням для μd:');
disp('Уровень: a -> x ∈ [0,sqrt((1-a)/2a)');




% Определение уровней
levels = [0, 0.2, 0.4, 0.6, 0.8, 1];

% Разложение по уровням для каждой функции
disp('Разложение по уровням:');

% Для каждой функции
for func_idx = {'μa', 'μb', 'μc', 'μd'}
    fprintf('Разложение для %s:\n', func_idx{1});
    
    % Разложение по уровням
    decomposition = ''; % Инициализация строки для разложения
    
    for level = levels
        % Находим значения x для каждого уровня
        if strcmp(func_idx{1}, 'μa')
            values = find(mu_a >= level);
        elseif strcmp(func_idx{1}, 'μb')
            values = find(mu_b >= level);
        elseif strcmp(func_idx{1}, 'μc')
            values = find(mu_c >= level);
        elseif strcmp(func_idx{1}, 'μd')
            values = find(mu_d >= level);
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