function [th, rad] = CartToPolar(x,y)

th = atan2(y, x);
rad = sqrt(sum((x-y).^2));