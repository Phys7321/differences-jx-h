close all
load derdata.mat

figure
plot(X, Y, '.')
hold on
poly_parameters = polyfit(X, Y, ceil(sqrt(numel(X))));
plot(X, polyval(poly_parameters, X), 'r')

replace_x = linspace(X(1), X(end), 1e3);

figure
data_slope = diff(polyval(poly_parameters, replace_x))./diff(replace_x);
plot(replace_x(1:end-1), data_slope, '.')

figure
data_second_slope = diff(data_slope)./diff(replace_x(1:end-1));
plot(replace_x(2:end-1), data_second_slope, '.')
