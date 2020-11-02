function [xr, yr] = rotation(x0, y0, q)

xr = x0*cosd(q) - y0*sind(q);
yr = x0*sind(q) + y0*cosd(q);
