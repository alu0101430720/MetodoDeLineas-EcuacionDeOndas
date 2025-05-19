%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ordenEspacial()
    % Definición de los valores de m (espacial) para el análisis
    m_base = 10;
    niveles = 5;
    m_values = m_base * 2.^(0:niveles-1); % [10, 20, 40, 80, 160]

    n = 40; %Fijo

    % Dominio espacial y temporal
    x0 = 0; x1 = 1;
    t0 = 0; t1 = 1;

    tau = 1/n;

    t = linspace(t0, t1, n+1);
    
    errores = NaN(length(m_values), 2);
    for i = 1:length(m_values)
        m = m_values(i);
        x=linspace(x0, x1, m+2); % m+2, pues x0 en matlab es x1
        x_inner = x(2:m+1); % solo integro los que no conozco
        u = solucionExacta(x, t);
        du = derivadaExacta(x, t);

        W0 = [0; Winicial(x_inner); 0];
        W = NaN(m+2, n+1, 2); % Tenemos dos capas, capa 1 la función, 
                                               % capa 2 la derivada.
    
        % Escribimos los valores conocidos (podríamos hacerlo después).
        W(:, 1, 1) = W0;
        W(1, :, 1) = 0.*t;
        W(end, :, 1) = 0.*t;
        
        W(:, 1, 2) = 0.*x';
        W(1, :, 2) = 0.*t;
        W(end, :, 2) = 0.*t;
    
        W = metodoRKN(m, n, tau, W);
        errores(i, 1) = max(max(abs(u-W(:, :, 1))));
        errores(i, 2) = max(max(abs(du-W(:, :, 2))));
    end

    h_values = 1 ./ (m_values + 1);
    
    figure;
    loglog(h_values, errores(:, 1), 'o-', 'LineWidth', 2);
    hold on;
    loglog(h_values, h_values.^2, 'r--', 'LineWidth', 1.5);
    title('Error vs h (n = 40)');
    xlabel('h (paso espacial)');
    ylabel('Error máximo');
    legend('Error numérico', 'h^2', 'Location', 'northwest');
    grid on;

    figure;
    loglog(h_values, errores(:, 2), 'o-', 'LineWidth', 2);
    hold on;
    loglog(h_values, h_values.^2, 'r--', 'LineWidth', 1.5);
    title('Error vs h (n = 40)');
    xlabel('h (paso espacial)');
    ylabel('Error máximo');
    legend('Error numérico', 'h^2', 'Location', 'northwest');
    grid on;

    orders = zeros(length(m_values)-1, 2);
    for i = 1:length(m_values)-1
        orders(i, 1) = log10(errores(i, 1)/errores(i+1, 1)) / log10(2);
        orders(i, 2) = log10(errores(i, 2)/errores(i+1, 2)) / log10(2);
    end
    % Mostrar resultados
    fprintf('Análisis de convergencia del método RKN:\n');
    fprintf('m\t\th\t\tError Sol.\tError Der.\tOrden Sol\tOrden Der.\n');
    fprintf('%d\t\t%.6f\t%.6e\t%.6e\t-\t\t-\n', m_values(1), h_values(1), errores(1,1), errores(1,2));
    for i = 2:length(m_values)
        fprintf('%d\t\t%.6f\t%.6e\t%.6e\t%.4f\t\t%.4f\n', m_values(i), h_values(i), errores(i, 1), errores(i, 2), orders(i-1, 1), orders(i-1, 2));
    end
end

function W0 = Winicial(x)

    W0 = 2 * sin(4*pi*x)';

end