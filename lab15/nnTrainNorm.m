X = [-2 1; 0 1; 2 -1; -2 -1;];
target = [ 0; 0; 1; 0;];
w = [1 -0.8];
b = [1];
max_error = 0.01;
learning_rate = 0.1;
num_epochs = 10;


net = newp([-3 3; -3 3],1);
net.b{1} = b;
net.IW{1,1} = w;

for epoch = 1:num_epochs
    total_error = 0;
    for i = 1:size(X,1)
        a = sim(net,X(i,:)');
        e = target(i) - a;
        disp(['Вектор: ' num2str(X(i,1)) ' ' num2str(X(i,2)) ' Выходное значение:' num2str(a) ' ошибка:' num2str(e)]);
        dw = learnp(w,X(i,:),[],[],[],[],e,[],[],[],[],[]);
        w = w + learning_rate * dw';
        net.b{1} = net.b{1} + learning_rate * e;
        net.IW{1,1} = w; 
        total_error = total_error+abs(e);
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
