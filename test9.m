close all
syms x
y_fun = sin(1./(x.*(2-x))).^2;
y_handle = @(x) sin(1./(x.*(2-x))).^2;
deri_fun = diff(y_fun);
second_deri_fun = diff(deri_fun);

x_array = 1e-2:1e-4:0.11;
deri_array = zeros(size(x_array));
second_deri_array = zeros(size(x_array));
for ii = 1:numel(x_array)
    i_x = x_array(ii);
    deri_array(ii) = vpa(subs(deri_fun, x, i_x));
    second_deri_array(ii) = vpa(subs(second_deri_fun, x, i_x));
end

figure
plot(x_array, y_handle(x_array), 'b-')
xlabel('x')
ylabel('f(x)')
title('original function')

figure
plot(x_array, deri_array, 'b-')
xlabel('x')
ylabel('f''(x)')
title('first derivative')

figure
plot(x_array, second_deri_array, 'b-')
xlabel('x')
ylabel('f''''(x)')
title('second derivative')
