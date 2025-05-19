%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function graficar(x, t, n, u, du, W)
    % Funcion que nos permite visualizar los resultados.
    
    disp('0. Salir.')
    disp('1. Graficar sol. y der. para 4 tiempos.')
    disp('2. Graficar animación sol. y der.')
    disp('3. Graficar sol. y der. en 3D.')
    disp('4. Graficar todo para la solución.')
    opc = input('Seleccione una opción');
    switch opc
        case 0
            disp('No se graficará nada.')
            return
        case 1
            solucionTiempo_t(x, t, u, W(:, :, 1));
            solucionTiempo_t(x, t, du, W(:, :, 2));
        case 2
            evolucionSolucion(x, n, u, W(:, :, 1))
            evolucionSolucion(x, n, du, W(:, :, 2))
        case 3
            graficar3D(x, t, u, W(:, :, 1))
            graficar3D(x, t, du, W(:, :, 2))
        case 4
            solucionTiempo_t(x, t, u, W(:, :, 1))
            pause(1)
            evolucionSolucion(x, n, u, W(:, :, 1))
            graficar3D(x, t, u, W(:, :, 1))
    end

end

function solucionTiempo_t(x, t, u, W)
    t_indices = [1, ceil(length(t)/3), ceil(2*length(t)/3), length(t)];
    % Gráfica de la solución numérica vs exacta al tiempo final
    figure;
    for i = 1:length(t_indices)
        subplot(2, 2, i);
        hold on;
        plot(x, W(:,  t_indices(i)), 'b-', 'LineWidth', 2);
        plot(x, u(:,  t_indices(i)), 'r--', 'LineWidth', 1.5);
        title(['t = ', num2str(t(t_indices(i)))]);
        xlabel('x'); ylabel('');
        grid on;
    end
    hold off;
    legend('Aproximación', 'Exacta');
end

function evolucionSolucion(x, n, u, W)
    
    % Gráfica de la evolución temporal de ambas soluciones
    figure;
    hold on;
    for i = 1:n+1
        plot(x, u(:, i), 'r');
        plot(x, W(:, i), 'b--');
        if n <= 30
            pause(1); % Pausa para visualizar la evolución (activar solo si n pequeño)
        end
    end
    title('Evolución temporal de las soluciones');
    xlabel('Posición x');
    ylabel('Amplitud');
    legend('Exacta', 'Numérica');
    grid on;
    hold off;  

end

function graficar3D(x, t, u, W)

    % Figura 1: Comparación de soluciones 3D
    figure;
    
    subplot(1, 2, 1);
    surf(x, t, W(:, :)');
    shading interp;
    %colorbar;
    title('Numérica');
    xlabel('x'); ylabel('t'); zlabel('');
    
    subplot(1, 2, 2);
    surf(x, t, u');
    shading interp;
    %colorbar;
    title('Exacta');
    xlabel('x'); ylabel('t'); zlabel('');
    
    % Figura 2: Error
    figure;
    error_plot = abs(W(:, :)' - u');
    surf(x, t, error_plot);
    shading interp;
    %colorbar;
    title('Error máximo');
    xlabel('x'); ylabel('t'); zlabel('');

end