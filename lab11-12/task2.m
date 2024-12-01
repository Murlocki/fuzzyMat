step = 0.1;
n = 4/step + 1;
x1=-2:step:2;
x2=-2:step:2;
size(x1)
y = zeros(n,n);
s = 0;
Input = zeros(2,n*n);
Target = zeros(1,n*n);
for j=1:n
    for i=1:n
        y(i,j) = (x1(j))^2 + (x2(i))^2+8*x1(j)*x2(i);
        s=s+1;
        Input(1,s) = x1(j);
        Input(2,s) = x2(i);
        Target(1,s) = (x1(j))^2 + (x2(i))^2+8*x1(j)*x2(i);
    end;
end;
Input
Target
surf(x1,x2,y);
xlabel('x1');
ylabel('x2');
zlabel('y');
title('Target');

%Получаем выходы
outputs = net_2.Network(Input);
s1 = 0;
s2 = 0;
for(i=1:25)
    s1=s1+((Target(i)-outputs(i))^2);
    s2=s2+(Target(i)^2);
end;
s1 = s1 ^ (1/2);
d = s1/(s2^(1/2));
ans = d