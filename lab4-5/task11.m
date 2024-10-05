% Определение универсального множества U
U = {'a', 'b', 'c', 'd', 'e'};

% Функция принадлежности для A
A_values = [0.8, 0, 0.6, 0.9, 1]; % Значения для A

% Концентрация B: CON(A)
B_values = A_values .^ 2;

% Дилатация C: DIL(A), например с k=1.5
k = 1.5;
C_values = k * A_values;

% Построение графиков функций принадлежности
figure;
hold on;

% Графики для множеств A, B и C
plot(1:5, A_values, '-o', 'DisplayName', 'A', 'LineWidth', 1.5);
plot(1:5, B_values, '-s', 'DisplayName', 'B (CON(A))', 'LineWidth', 1.5);
plot(1:5, C_values, '-d', 'DisplayName', 'C (DIL(A))', 'LineWidth', 1.5);

xlabel('Молодые люди');
ylabel('Степень принадлежности');
title('Графики функций принадлежности множеств A, B и C');

xticks(1:5);
xticklabels(U);
legend show;
grid on;
hold off;
