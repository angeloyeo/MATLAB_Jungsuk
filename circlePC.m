function circlePC(c, p)

r = sqrt(sum((c-p).^2));

theta = linspace(0, 2*pi, 100);

plot(r * cos(theta) + c(1), r * sin(theta) + c(2));
hold on;
plot(c(1), c(2),'ro','linewidth',2);
plot(p(1), p(2),'rx','linewidth',2);

axis square