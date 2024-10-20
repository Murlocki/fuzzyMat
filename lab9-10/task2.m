function out = calcSmoothTrap(x)
disp(size(x,1));
    for i=1:size(x,1)
        for j=1:size(x,2)
            if x(i,j)<4
                y(i,j) = smf(x(i,j),[0,4]);
            elseif x(i,j)>=4 && x(i,j)<6
                y(i,j) = 1;
            else
                y(i,j) = zmf(x(i,j),[6,10]);
            end;
        end;
    end;
    out = y;
end;

function out = calcImplication(x1,x2)
[X,Y] = meshgrid(x1,x2);
z1 = trimf(x1,[7,10,13]);
z2 = calcSmoothTrap(x2);
Z = min(trimf(X,[7,10,13]),calcSmoothTrap(Y));
out = Z;

figure
subplot(2,1,1);
plot(x1,z1);
ylim([-0.05 1.05]);
title("График первой функции принадлежности");
xlabel("x");
ylabel("y");

subplot(2,1,2);
plot(x2,z2);
ylim([-0.05 1.05]);
title("График второй функции принадлежности");
xlabel("x");
ylabel("y");

figure
plot3(X,Y,Z);
title("График функции импликации");
end

x1 = linspace(0,15,1000);
x2 = linspace(0,15,1000);
calcImplication(x1,x2);

