% Определение диапазона значений цен автомобилей
x_A = [5, 6, 7, 8, 9];
mu_A_values = [0.4, 0.7, 1, 0.8, 0.6];

% Конус для A
CON_A_values = mu_A_values .^ 2;

% Дилатация для A
DIL_A_values = sqrt(mu_A_values);

% Определение диапазона значений для B
x_B = [1, 3, 4];
mu_B_values = [0.8, 0.8, 0.5];

% Конус для B
CON_B_values = mu_B_values .^ 2;

% Дилатация для B
DIL_B_values = sqrt(mu_B_values);

% Построение графиков для A
figure;
hold on;
plot(x_A, mu_A_values, 'b-o', 'LineWidth', 2, 'DisplayName', '\mu_A(x)');
plot(x_A, CON_A_values, 'g-o', 'LineWidth', 2, 'DisplayName', 'CON(A)');
plot(x_A, DIL_A_values, 'r-o', 'LineWidth', 2, 'DisplayName', 'DIL(A)');
hold off;

xlabel('Цена автомобиля');
ylabel('Степень принадлежности');
title('Функции принадлежности для множества A');
legend show;
grid on;

% Построение графиков для B
figure;
hold on;
plot(x_B, mu_B_values, 'b-o', 'LineWidth', 2, 'DisplayName', '\mu_B(x)');
plot(x_B, CON_B_values, 'g-o', 'LineWidth', 2, 'DisplayName', 'CON(B)');
plot(x_B, DIL_B_values, 'r-o', 'LineWidth', 2, 'DisplayName', 'DIL(B)');
hold off;

xlabel('Цена автомобиля');
ylabel('Степень принадлежности');
title('Функции принадлежности для множества B');
legend show;
grid on;