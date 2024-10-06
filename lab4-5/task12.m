% Определение значений и степеней принадлежности для A
U_A = [4, 5, 6]; % Значения для A
mu_A = [1.0, 0.5, 0.2]; % Степени принадлежности для A

% Определение значений и степеней принадлежности для B
U_B = [1, 2, 3, 4, 5]; % Значения для B
mu_B = [0.3, 0.8, 1.0, 0.8, 0.3]; % Степени принадлежности для B

% Сложение C(A + B)
C_values = [];
mu_C = [];
for i = 1:length(U_A)
    for j = 1:length(U_B)
        sum_value = U_A(i) + U_B(j);
        degree = min(mu_A(i), mu_B(j)); % Используем минимум
        idx = find(C_values == sum_value); % Ищем индекс существующего значения
        if isempty(idx)
            C_values(end+1) = sum_value; 
            mu_C(end+1) = degree;
        else
            mu_C(idx) = max(mu_C(idx), degree); % Обновляем степень принадлежности
        end
    end
end

% Вычитание E(A - B)
E_values = [];
mu_E = [];
for i = 1:length(U_A)
    for j = 1:length(U_B)
        if U_A(i) >= U_B(j) % Убедимся в неотрицательности
            diff_value = U_A(i) - U_B(j);
            degree = min(mu_A(i), mu_B(j)); % Используем минимум
            idx = find(E_values == diff_value); % Ищем индекс существующего значения
            if isempty(idx)
                E_values(end+1) = diff_value; 
                mu_E(end+1) = degree;
            else
                mu_E(idx) = max(mu_E(idx), degree); % Обновляем степень принадлежности
            end
        end
    end
end

% Умножение D(A * B)
D_values = [];
mu_D = [];
for i = 1:length(U_A)
    for j = 1:length(U_B)
        prod_value = U_A(i) * U_B(j);
        degree = min(mu_A(i), mu_B(j)); % Используем минимум
        idx = find(D_values == prod_value); % Ищем индекс существующего значения
        if isempty(idx)
            D_values(end+1) = prod_value; 
            mu_D(end+1) = degree;
        else
            mu_D(idx) = max(mu_D(idx), degree); % Обновляем степень принадлежности
        end
    end
end

% Деление F(A / B)
F_values = [];
mu_F = [];
for i = 1:length(U_A)
    for j = 1:length(U_B)
        if U_B(j) ~= 0 % Проверяем деление на ноль
            div_value = U_A(i) / U_B(j);
            degree = min(mu_A(i), mu_B(j)); % Используем минимум
            idx = find(F_values == div_value); % Ищем индекс существующего значения
            if isempty(idx)
                F_values(end+1) = div_value; 
                mu_F(end+1) = degree;
            else
                mu_F(idx) = max(mu_F(idx), degree); % Обновляем степень принадлежности
            end
        end
    end
end

% Максимум G(max(A,B))
function [G_values, mu_G] = calcMax(U_A,U_B,mu_A,mu_B)
G_values = [];
mu_G = [];
for i = 1:length(U_A)
    for j = 1:length(U_B)
        max_value = max(U_A(i), U_B(j));
        degree = min(mu_A(i), mu_B(j)); % Используем максимум
        idx = find(G_values == max_value); % Ищем индекс существующего значения
        if isempty(idx)
            G_values(end+1) = max_value; 
            mu_G(end+1) = degree;
        else
            mu_G(idx) = max(mu_G(idx), degree); % Обновляем степень принадлежности
        end
    end
end
end;
[G_values,mu_G] = calcMax(U_A,U_B,mu_A,mu_B);
% Минимум H(min(A,B))
function [H_values, mu_H] = calcMin(U_A,U_B,mu_A,mu_B)
H_values = [];
mu_H = [];
for i = 1:length(U_A)
    for j = 1:length(U_B)
        min_value = min(U_A(i), U_B(j));
        degree = min(mu_A(i), mu_B(j)); % Используем минимум
        idx = find(H_values == min_value); % Ищем индекс существующего значения
        if isempty(idx)
            H_values(end+1) = min_value; 
            mu_H(end+1) = degree;
        else
            mu_H(idx) = max(mu_H(idx), degree); % Обновляем степень принадлежности
        end
    end
end
end;
[H_values,mu_H] = calcMin(U_A,U_B,mu_A,mu_B);
% Сортировка результатов по величине элемента и удаление дубликатов для всех операций

function [sortedValues, sortedDegrees] = sortAndRemoveDuplicates(values, degrees)
    [sortedValues, uniqueIdx] = unique(values);
    sortedDegrees= zeros(size(sortedValues));
    
    for i=1:length(uniqueIdx)
        sortedDegrees(i)=max(degrees(values==sortedValues(i)));
    end
    
end

[C_sorted, mu_C_sorted]  	= sortAndRemoveDuplicates(C_values, mu_C);
[E_sorted, mu_E_sorted]  	= sortAndRemoveDuplicates(E_values, mu_E);
[D_sorted, mu_D_sorted]  	= sortAndRemoveDuplicates(D_values, mu_D);
[F_sorted, mu_F_sorted]  	= sortAndRemoveDuplicates(F_values, mu_F);
[G_sorted, mu_G_sorted]  	= sortAndRemoveDuplicates(G_values, mu_G);
[H_sorted, mu_H_sorted]  	= sortAndRemoveDuplicates(H_values, mu_H);

% Построение графиков функций принадлежности с отсортированными результатами

figure;
hold on;

% Графики для A и B
plot(U_A, mu_A, '-o', 'DisplayName', 'A (немного больше 3)', 'LineWidth', 1.5);
plot(U_B, mu_B, '-s', 'DisplayName', 'B (примерно 3)', 'LineWidth', 1.5);


% Графики для операций с отсортированными значениями и степенями принадлежности 
plot(C_sorted, mu_C_sorted, '-d', 'DisplayName', 'C (A + B)', 'LineWidth', 1.5);
%plot(E_sorted, mu_E_sorted, '-x', 'DisplayName', 'E (A - B)', 'LineWidth', 1.5);
%plot(D_sorted, mu_D_sorted, '-^', 'DisplayName', 'D (A * B)', 'LineWidth', 1.5);
%plot(F_sorted, mu_F_sorted, '-v', 'DisplayName', 'F (A / B)', 'LineWidth', 1.5);
%plot(G_sorted, mu_G_sorted, '--', 'DisplayName', 'G (max(A,B))', 'LineWidth', 1.5);
%plot(H_sorted, mu_H_sorted, '--', 'DisplayName', 'H (min(A,B))', 'LineWidth', 1.5);


xlabel('Значения');
ylabel('Степень принадлежности');
title('Графики функций принадлежности для A и B с операциями');
legend show;
grid on;
hold off;

[v,m] = calcMax(U_A,C_values,mu_A,mu_C)