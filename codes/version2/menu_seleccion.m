%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [c, f, g]=menu_seleccion()
    
    % Funcion auxiliar que permite seleccionar parametros para el problema.
    % Valores por defecto
    default_c = 1/4;
    default_f = @(x) 2*sin(4*pi*x);
    default_g = @(x) 0*x;
    
    % Seleccion de parametros por parte del usuario
    disp('Elija un valor para c:')
    disp('1. c = 1')
    disp('2. c = 2')
    disp('3. c = 1/2')
    disp('4. Por defecto: c = 1/4')
    c_choice = input('Selección (1-4, por defecto 4): ');
    if isempty(c_choice) || c_choice == 4
        c = default_c;
    elseif c_choice == 1
        c = 1;
    elseif c_choice == 2
        c = 2;
    elseif c_choice == 3
        c = 1/2;
    else
        error('Selección no válida para c.');
    end
    
    disp('Elija u(x, 0) = f(x):')
    disp('1. f(x) = 3*sin(pi*x)')
    disp('2. f(x) = x*(1-x)')
    disp('3. f(x) = 0')
    disp('4. Por defecto: f(x) = 2*sin(4*pi*x)')
    f_choice = input('Selección (1-4, por defecto 4): ');
    if isempty(f_choice) || f_choice == 4
        f = default_f;
    elseif f_choice == 1
        f = @(x) 3*sin(pi*x);
    elseif f_choice == 2
        f = @(x) x.*(1 - x);
    elseif f_choice == 3
        f = @(x) 0*x;
    else
        error('Selección no válida para f(x)');
    end
    
    disp('Elija u_t(x, 0) = g(x):')
    disp('1. g(x) = sin(pi*x)')
    disp('2. g(x) = sin(2*pi*x)')
    disp('3. g(x) = x')
    disp('4. Por defecto: g(x) = 0')
    g_choice = input('Selección (1-4, por defecto 4): ');
    if isempty(g_choice) || g_choice == 4
        g = default_g;
    elseif g_choice == 1
        g = @(x) sin(pi*x);
    elseif g_choice == 2
        g = @(x) sin(2*pi*x);
    elseif g_choice == 3
        g = @(x) x;
    else
        error('Selección no válida para g(x)');
    end

end