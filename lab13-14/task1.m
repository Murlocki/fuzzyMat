y1 = 0.42;
y2 = 0.54;
x1 = 1;
x2 = 0;
y = y1 * 0.3 + y2 * 0.2
d = 0;

delta = (d-y) * y * (1-y)
w1 = 0.7+0.8*delta*1
w2 = 0.9+0.8*delta*1
delta1 = y1 * (1-y1) * delta * w1
delta2 = y2 * (1-y2) * delta * w2
w11 = 0.7 + 0.8 * delta1 * x1
w12 = 0.9 + 0.8 * delta2 * x1
w21 = 0.5 + 0.8 * delta1 * x2
w22 = 0.2 + 0.8 * delta2 * x2
error = (d-y)^2