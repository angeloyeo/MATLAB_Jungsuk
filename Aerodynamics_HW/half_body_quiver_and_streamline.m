clear;

syms PSI x y u v Uinf Lambda

diff(Uinf*y + Lambda / (2 * pi) * atan(y/x), y) % u
diff(Uinf*y + Lambda / (2 * pi) * atan(y/x), x) % -v

%% plot the results with quiver and streamline

clear; close all;
Uinf = 1;
lambda = 2  ;

[x,y] = meshgrid(linspace(-1, 1, 50), linspace(-1, 1, 50));

u = Uinf + lambda ./ (2.*x.*pi.*(y.^2./x.^2 + 1));
v = (lambda .* y) ./ (2.* x.^2.* pi.* (y.^2./x.^2 + 1));

quiver(x, y, u, v)

[verts,averts] = streamslice(x,y,u,v);
sl = streamline([verts averts]);

xlim([-1 1])
ylim([-1 1])
title('Flow Over a Half Body');