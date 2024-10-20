function out = trapParams()
    x = linspace(4,8,100);
    y = trapmf(x,[5 5.5 6.5 7]);
    plot(x,y);
    ylim([-0.05 1.05])
    out = y;
end;
trapParams();