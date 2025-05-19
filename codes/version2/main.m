%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function main()
    % Funcion principal en su version 2.
    
    x0 = 0; x1 = 1; % Si se modifican estos parametros hay que asegurarse 
                    % de que las condiciones Dirichlet sean consistentes
                    % con la funcion f.
    t0 = 0; t1 = 1;
    
    disp('Elija una opción.')
    disp('Para un único m y n:')
    disp('    1. Resolver otro problema (contraste con Fourier).')
    disp('    2. Resolver el problema por defecto con las soluciones exactas.')
    disp('Para una lista de m y n.')
    disp('    3. Resolver.')
    disp('4. Salir.')
    disp('')
    opc = input('Opción: ');

    if opc == 1
        [c, f, g] = menu_seleccion();

        m = input('Valor de m (partición espacial): '); % Dentro de la malla quiero m puntos
        n = input('Valor de n: ');
        N = 100; % Iteraciones de Fourier
    
        x = linspace(x0, x1, m+2); % m+2, pues x0 en matlab es x1
        t = linspace(t0, t1, n+1);

        U = fourier(m, n, x, t, x1, N, c, f, g);
    
        u = U(:, :, 1);
        du = U(:, :, 2);
    elseif opc == 2
        m = input('Valor de m (partición espacial): '); % Dentro de la malla quiero m puntos
        n = input('Valor de n: ');

        x = linspace(x0, x1, m+2); % m+2, pues x0 en matlab es x1
        t = linspace(t0, t1, n+1);

        u = solucionExacta(x, t);
        du = derivadaExacta(x, t);

        % Valores por defecto
        c = 1/4;
        f = @(x) 2*sin(4*pi*x);
        g = @(x) 0*x;
    elseif opc == 3
        [c, f, g] = menu_seleccion();
        integracionVariando_m_n(c, f, g)
        return
    else
        disp('Salir.')
        return
    end

    tau = 1/n;
    x_inner = x(2:m+1); % solo integro los que no conozco
   
    W0 = [f(x0); f(x_inner)'; f(x1)];
    W = NaN(m+2, n+1, 2); % Tenemos dos capas, capa 1 la función, 
                                             % capa 2 la derivada.

    % Escribimos los valores conocidos.
    W(:, 1, 1) = W0;
    W(1, :, 1) = 0.*t;
    W(end, :, 1) = 0.*t;
    
    dW0 = [g(x0); g(x_inner)'; g(x1)];
    W(:, 1, 2) = dW0;
    W(1, :, 2) = 0.*t;
    W(end, :, 2) = 0.*t;

    % Aplicamos el metodo RKN
    W = metodoRKN(c, m, n, tau, W);
    W(:, :, 1);
    W(:, :, 2);
    
    % Errores maximos
    error_max = max(max(abs(u(2:m+1, :)-W(2:m+1, :, 1))));
    fprintf('Error máximo: %e\n', error_max);
    error_max = max(max(abs(du(2:m+1, :)-W(2:m+1, :, 2))));
    fprintf('Error máximo (der): %e\n', error_max);
    
    disp('¿Desea graficar?')
    disp('1. Sí')
    disp('2. No')
    opc = input('Respuesta: ');
    
    if opc == 1
        graficar(x, t, n, u, du, W)
    end

end

