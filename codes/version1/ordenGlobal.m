%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ordenGlobal()
    % Definición de los valores de m (espacial) y n (temporal) para el análisis
    m_base = 10;
    n_base = 10;
    niveles = 5;
    m_values = m_base * 2.^(0:niveles-1);
    n_values = n_base * 2.^(0:niveles-1);

    % Dominio espacial y temporal
    x0 = 0; x1 = 1;
    t0 = 0; t1 = 1;
    
    % Almacenar errores
    errores = NaN(niveles, 2);
    h_values = 1 ./ (m_values + 1);
    tau_values = 1 ./ n_values;
    for i = 1:niveles
        m = m_values(i);
        h = h_values(i); % Paso espacial
        
        n = n_values(i);
        tau = tau_values(i);
        
        % Malla espacial
        x = linspace(x0, x1, m+2);
        x_inner = x(2:m+1);
        
        % Malla temporal
        t = linspace(t0, t1, n+1);
        
        % Solución exacta para comparación
        u = solucionExacta(x, t);
        du = derivadaExacta(x, t);
        
        % Valores iniciales
        W0 = [0; Winicial(x_inner); 0];
        
        % Inicializar arreglos
        W = NaN(m+2, n+1, 2); % Tenemos dos capas, capa 1 la función, capa 2 la derivada
        
        % Escribimos los valores conocidos (condiciones iniciales y de frontera)
        W(:, 1, 1) = W0;
        W(1, :, 1) = 0.*t;
        W(end, :, 1) = 0.*t;
        W(:, 1, 2) = 0.*x';
        W(1, :, 2) = 0.*t;
        W(end, :, 2) = 0.*t;
        
        % Aplicar el método numérico
        W = metodoRKN(m, n, tau, W);
        
        % Calcular errores máximos
        errores(i, 1) = max(max(abs(u-W(:, :, 1))));
        errores(i, 2) = max(max(abs(du-W(:, :, 2))));
        
        % Mostrar información de la iteración actual
        fprintf('Iteración %d: m = %d, n = %d, h = %.6f, tau = %.6f\n', ...
                i, m, n, h, tau);
    end
    
   

    % Determinar orden esperado global
    % Si temporal es O(τ⁴) y espacial es O(h²)
    % entonces el orden global esperado es min(4, 2) = 2
    orden_esperado = 2;
    
    % Gráfico para la función
    figure;
    loglog(h_values, errores(:, 1), 'o-', 'LineWidth', 2);
    hold on;
    loglog(h_values, h_values.^orden_esperado, 'r--', 'LineWidth', 1.5);
    title('Error Global vs h');
    xlabel('h (paso espacial)');
    ylabel('Error máximo');
    legend('Error numérico', ['h^' num2str(orden_esperado)], 'Location', 'northwest');
    grid on;
    
    % Gráfico para la derivada
    figure;
    loglog(h_values, errores(:, 2), 'o-', 'LineWidth', 2);
    hold on;
    loglog(h_values, h_values.^orden_esperado, 'r--', 'LineWidth', 1.5);
    title('Error Global vs h (derivada)');
    xlabel('h (paso espacial)');
    ylabel('Error máximo');
    legend('Error numérico', ['h^' num2str(orden_esperado)], 'Location', 'northwest');
    grid on;
    
    % Calcular orden numérico observado
    orders = zeros(niveles-1, 1);
    for i = 1:niveles-1
        orders(i) = log10(errores(i, 1)/errores(i+1, 1)) / log10(2);
    end
    
    % Mostrar resultados en una tabla
    fprintf('\nAnálisis de convergencia global del método RKN:\n');
    fprintf('m\t\tn\t\th\t\ttau\t\tError Sol.\tError Der.\tOrden\n');
    fprintf('%d\t\t%d\t\t%.6f\t%.6f\t%.6e\t%.6e\t-\n', ...
            m_values(1), n_values(1), h_values(1), tau_values(1), errores(1,1), errores(1, 2));
    
    for i = 2:niveles
        fprintf('%d\t\t%d\t\t%.6f\t%.6f\t%.6e\t%.6e\t%.4f\n', ...
                m_values(i), n_values(i), h_values(i), tau_values(i), ...
                errores(i, 1), errores(i, 2), orders(i-1));
    end
    
end

function W0 = Winicial(x)
    W0 = 2 * sin(4*pi*x)';
end