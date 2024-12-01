n=5;
x1=1:1:5;
x2=1:1:5;
y = zeros(n,n);
s = 0;
Input = zeros(2,25);
Target = zeros(1,25);
for j=1:n
    for i=1:n
        y(i,j) = (x1(j)-3)^2 + (x2(i)-3)^2;
        s=s+1;
        Input(1,s) = x1(j) - 3;
        Input(2,s) = x2(i) - 3;
        Target(1,s) = (x1(j)-3)^2 + (x2(i)-3)^2;
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
outputs = net.Network(Input);
s1 = 0;
s2 = 0;
for(i=1:25)
    s1=s1+((Target(i)-outputs(i))^2);
    s2=s2+(Target(i)^2);
end;
s1 = s1 ^ (1/2);
d = s1/(s2^(1/2));
ans = d