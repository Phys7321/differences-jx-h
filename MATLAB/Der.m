function [dy,xc] = Der(F,x,varargin)
% D calculates the derivative of the function F(x) using one of three
% methods: forward difference, central difference, and expolated difference
% D(F,x,method) returns the x and y coordinate of the derivative function.
% Specify which method in the optional third argument as 'fd', 'cd', or
% 'ed'. If F is a numeric vector, it is treated as data and a simple
% derivative is calculated

if isempty(varargin)
   % Default method
    varargin{1} = 'cd'; 
end
if ~isnumeric(x)
    error('Second input must be numeric vector')
end
if ~isa(F,'function_handle')
    if isnumeric(F)
      xc = chop(x); % method for data depends on how you assign dy to xc
      dy = diff(F)./diff(x); 
      varargin{1} = 'data';
    else
      error('First input must be a function handle or a numeric array')
    end
end

n=length(x);
dx = diff(x);



coefficient_matrix = [0, -1/2, 0, 1/2, 0; 0, 1, -2, 1, 0; ...
                    -1/2, 2/2, 0/2, -2/2, 1/2; 1, -4, 6, -4, 1];
        
switch varargin{1}
    case 'fd' 
        dy = (F(x(2:n)) - F(x(1:n-1)))./dx;
        xc = x(1:n-1);
    case 'bd'
        dy = (F(x(2:n)) - F(x(1:n-1)))./dx;
        xc = x(2:n);
    case 'cd'
        dy = (F(x(1:n-1)+0.5*dx) - F(x(1:n-1)-0.5*dx))./dx;
        xc = chop(x);
    case 'ed'
        half = (F(x(1:n-1)+0.25*dx) - F(x(1:n-1)-0.25*dx))./(0.5*dx); 
        full = (F(x(1:n-1)+0.5*dx) - F(x(1:n-1)-0.5*dx))./dx;
        dy = (4/3).*half - (1/3).*full;
        xc = chop(x);
    case 'cd3'
        h = mean(dx);
        xc = chop(x);
        dy = zeros(size(xc));
        for i_x = 1:numel(xc)
           xx = xc(i_x);
           x_list = xx - 2*h : h : xx + 2*h;
           f_list = F(x_list);
           dy(i_x) = sum([-1/2, 2/2, 0/2, -2/2, 1/2] .* f_list)/h^3;
        end
     case 'cd4'
        h = mean(dx);
        xc = chop(x);
        dy = zeros(size(xc));
        for i_x = 1:numel(xc)
           xx = xc(i_x);
           x_list = xx - 2*h : h : xx + 2*h;
           f_list = F(x_list);
           dy(i_x) = sum([1, -4, 6, -4, 1] .* f_list)/h^4;
        end
    case 'data'
        return;
    otherwise
        error('method not recognized');
end
end
