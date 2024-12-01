w = [1 -0.8];
b = 1;

X = [-2 1; 0 1; 2 -1; -2 -1;];
target = [ 0; 0; 1; 0;];

epochs = 100;
learning_rate = 0.1;
max_error = 0.01;
for epoch = 1:epochs
    total_error = 0;
    for i =1:size(X,1)
        output = hardlim(w*X(i,:)'+b);
        error = target(i) - output;
        total_error = total_error+abs(error)
        w = w+ learning_rate * error * X(i,:);
        b = b + learning_rate * error;
    end;
    average_error = total_error/size(X,1);
    disp(['Эпоха ' num2str(epoch) ', Средняя ошибка: ' num2str(average_error)]);
    if average_error < max_error
        disp(['Обучение завершено на эпохе ' num2str(epoch)]);
        break;
    end;
end;

disp('Веса:');
disp(w);

disp('Смещение:');
disp(b);