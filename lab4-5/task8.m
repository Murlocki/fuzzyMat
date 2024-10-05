% Определение диапазона значений
x = linspace(0, 3, 300); % От 0 до 3 для функции A

% Функция принадлежности μA(x)
mu_A = zeros(size(x));
mu_A(x <= 2) = (1/2) - (1/2) * sin(pi/2 * (x(x <= 2) - 1));

% Конус CON(A)
mu_CON_A = mu_A .^ 2;

% Дилатация DIL(A)
mu_DIL_A = sqrt(mu_A);

% Построение графиков
figure;
hold on;
plot(x, mu_A, 'b', 'LineWidth', 2, 'DisplayName', '\mu_A(x)');
plot(x, mu_CON_A, 'g', 'LineWidth', 2, 'DisplayName', 'CON(A)');
plot(x, mu_DIL_A, 'r', 'LineWidth', 2, 'DisplayName', 'DIL(A)');
hold off;

xlabel('x');
ylabel('Степень принадлежности');
title('Функции принадлежности для множества A');
legend show;
grid on;