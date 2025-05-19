%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ordenTemporal()
    % Definición de los valores de n (temporal) para el análisis
    n_base = 10;
    niveles = 7;
    n_values = n_base * 2.^(0:niveles-1); % [10, 20, 40, 80, 160]
    tau_values = 1 ./ n_values;

    m = 40; % Fijo

    % Dominio espacial y temporal
    x0 = 0; x1 = 1;
    t0 = 0; t1 = 1;

    x = linspace(x0, x1, m+2);
    x_inner = x(2:m+1);
    
    %--------Solucion de Referencia--------%
    nReferencia = 100000;
    tReferencia = linspace(t0, t1, nReferencia+1);
    tauReferencia = 1/nReferencia;
    
    W0 = [0; Winicial(x_inner); 0];
    W_Referencia = NaN(m+2, nReferencia+1, 2); % Tenemos dos capas, capa 1 la funcion, 
                                           % capa 2 la derivada.

    W_Referencia(:, 1, 1) = W0;
    W_Referencia(1, :, 1) = 0.*tReferencia;
    W_Referencia(end, :, 1) = 0.*tReferencia;
    
    W_Referencia(:, 1, 2) = 0.*x';
    W_Referencia(1, :, 2) = 0.*tReferencia;
    W_Referencia(end, :, 2) = 0.*tReferencia;
    W_Referencia = metodoRKN(m, nReferencia, tauReferencia, W_Referencia);

    %--------Comenzamos la comparativa--------%
    errores = NaN(length(n_values), 2);
    for i = 1:length(n_values)
        n = n_values(i);
        t = linspace(t0, t1, n+1);
        tau = tau_values(i);
        W0 = [0; Winicial(x_inner); 0];
        W = NaN(m+2, n+1, 2); % Tenemos dos capas, capa 1 la función, 
                                               % capa 2 la derivada.
    
        W(:, 1, 1) = W0;
        W(1, :, 1) = 0.*t;
        W(end, :, 1) = 0.*t;
        
        W(:, 1, 2) = 0.*x';
        W(1, :, 2) = 0.*t;
        W(end, :, 2) = 0.*t;
    
        W = metodoRKN(m, n, tau, W);

        W_ref = W_Referencia(:, end, 1);
        dW_ref = W_Referencia(:, end, 2);

        errores(i, 1) = max(max(abs(W_ref-W(:, end, 1))));
        errores(i, 2) = max(max(abs(dW_ref-W(:, end, 2))));
    end

    
    
    figure;
    loglog(tau_values, errores(:, 1), 'o-', 'LineWidth', 2);
    hold on;
    loglog(tau_values, tau_values.^4, 'r--', 'LineWidth', 1.5);
    title(sprintf('Error vs tau (m = %d)', m));
    xlabel('tau (paso temporal)');
    ylabel('Error máximo');
    legend('Error numérico', 'tau^4', 'Location', 'northwest');
    grid on;

    figure;
    loglog(tau_values, errores(:, 2), 'o-', 'LineWidth', 2);
    hold on;
    loglog(tau_values, tau_values.^4, 'r--', 'LineWidth', 1.5);
    title(sprintf('Error vs tau (m = %d)', m));
    xlabel('tau (paso temporal)');
    ylabel('Error máximo');
    legend('Error numérico', 'tau^4', 'Location', 'northwest');
    grid on;

    orders = zeros(length(n_values)-1, 2);
    for i = 1:length(n_values)-1
        orders(i, 1) = log10(errores(i, 1)/errores(i+1, 1)) / log10(2);
        orders(i, 2) = log10(errores(i, 2)/errores(i+1, 2)) / log10(2);
    end
    % Mostrar resultados
    fprintf('Análisis de convergencia del método RKN:\n');
    fprintf('n\t\ttau\t\tError Sol.\tError Der.\tOrden Sol.\tOrden Der.\n');
    fprintf('%d\t\t%.6f\t%.6e\t%.6e\t-\t\t-\n', n_values(1), tau_values(1), errores(1,1), errores(1, 2));
    for i = 2:length(n_values)
        fprintf('%d\t\t%.6f\t%.6e\t%.6e\t%.4f\t\t%.4f\n', n_values(i), tau_values(i), errores(i, 1), errores(i, 2), orders(i-1, 1), orders(i-1, 2));
    end
end

function W0 = Winicial(x)

    W0 = 2 * sin(4*pi*x)';

end