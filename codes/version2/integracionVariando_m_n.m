%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function integracionVariando_m_n(c, f, g)    
    x0 = 0; x1 = 1;
    t0 = 0; t1 = 1;
    disp('Los valores bases se multiplicarán por 2 tantas veces como niveles indique.')
    m_base = input('Valor base para m (espacial): ');
    n_base = input('Valor base para n: ');
    niveles = input('Niveles (recomendado < 11): ');
    m_values = m_base * 2.^(0:niveles-1); % [10, 20, 40, 80, 160]
    n_values = n_base * 2.^(0:niveles-1);
    N=100;
    errores = NaN(niveles, 2);

    for i=1:niveles
        tau = 1/n_values(i);
        m = m_values(i);
        n = n_values(i);

        x=linspace(x0, x1, m+2); % m+2, pues x0 en matlab es x1
        x_inner = x(2:m+1); % solo integro los que no conozco
        
        t = linspace(t0, t1, n+1);
    
        U = fourier(m, n, x, t, x1, N, c, f, g);
        
        u = U(:, :, 1);
        du = U(:, :, 2);
        W0 = [f(x0); f(x_inner)'; f(x1)];
        W = NaN(m+2, n+1, 2); % Tenemos dos capas, capa 1 la función, 
                                                 % capa 2 la derivada.
    
        % Escribimos los valores conocidos (podríamos hacerlo después).
        W(:, 1, 1) = W0;
        W(1, :, 1) = 0.*t;
        W(end, :, 1) = 0.*t;
        
        dW0 = [g(x0); g(x_inner)'; g(x1)];
        W(:, 1, 2) = dW0;
        W(1, :, 2) = 0.*t;
        W(end, :, 2) = 0.*t;
    
        W = metodoRKN(c, m, n, tau, W);
        W(:, :, 1);
        
        errores(i, 1) = max(max(abs(u(2:m+1, :)-W(2:m+1, :, 1))));
        errores(i, 2) = max(max(abs(du(2:m+1, :)-W(2:m+1, :, 2))));
    end

    h_values = 1 ./ (m_values + 1);
    tau_values = 1 ./ (n_values);
     % Mostrar resultados en una tabla
    fprintf('\nResultados:\n');
    fprintf('m\t\tn\t\th\t\ttau\t\tError Sol.\tError Der.\n');
    fprintf('%d\t\t%d\t\t%.6f\t%.6f\t%.6e\t%.6e\n', ...
            m_values(1), n_values(1), h_values(1), tau_values(1), errores(1,1), errores(1, 2));
    
    for i = 2:niveles
        fprintf('%d\t\t%d\t\t%.6f\t%.6f\t%.6e\t%.6e\n', ...
                m_values(i), n_values(i), h_values(i), tau_values(i), ...
                errores(i, 1), errores(i, 2));
    end
   
end