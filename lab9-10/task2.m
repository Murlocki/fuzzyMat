function out = calcSmoothTrap(x)
    for i=1:length(x)
        if x(i)<4
            y(i) = smf(x(i),[0,4]);
        elseif x(i)>=4 && x(i)<6
            y(i) = 1;
        else
            y(i) = zmf(x(i),[6,10]);
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
x2 = linspace(0,10,1000);
calcImplication(x1,x2);