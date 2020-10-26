clear; clc; close all;

syms Vinf x y k

diff(Vinf * y - k/(2*pi)* y/(x^2+y^2), y) % u
diff(Vinf * y - k/(2*pi)* y/(x^2+y^2), x) % -v


%%
clear; close all; 
Vinf = 0.1; % velocity of uniform flow
lambda = 1; % strength
L = 1/10; % distance from source to sink 
k = L * lambda;

[x, y] = meshgrid(linspace(-1, 1, 50), linspace(-1, 1, 50));
u = Vinf - k ./ (2.*pi.*(x.^2 + y.^2)) + (k.*y.^2)./(pi.*(x.^2 + y.^2).^2);
v = -1 * (k.*x.*y)./(pi .* (x.^2 + y.^2).^2);

quiver(x, y, u, v);

[verts,averts] = streamslice(x,y,u,v);
sl = streamline([verts averts]);


xlim([-1 1])
ylim([-1 1])
title('Flow Over a Cylinder');