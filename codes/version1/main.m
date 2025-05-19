%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function main(m, n)
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Función principal para ejecutar el código relativo al proyecto final
    % de la asignatura de MNEDP. En esta función se tienen diversos
    % ejecutables cuyo objetivo es el de obtener una aproximación al
    % problema de ecuación de onda pertinente haciendo uso del método de
    % líneas. Para ello se realiza una discretización espacial mediante
    % diferencias finitas centrales de segundo orden y, para la integración
    % temporal, se llevará a cabo un método RKN.
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
   if nargin < 2
       m = input('Valor de m (partición espacial): '); % Dentro de la malla quiero m puntos
       n = input('Valor de n: ');
   end
    
    x0 = 0; x1 = 1;
    t0 = 0; t1 = 1;

    tau = 1/n;

    x=linspace(x0, x1, m+2); % m+2, pues x0 en matlab es x1
    x_inner = x(2:m+1); % solo integro los que no conozco
    
    t = linspace(t0, t1, n+1);
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
    W(:, :, 1);
    
    error_max = max(max(abs(u-W(:, :, 1))));
    fprintf('Error máximo: %e\n', error_max);
    error_max = max(max(abs(du-W(:, :, 2))));
    fprintf('Error máximo (der): %e\n', error_max);
    
    disp('¿Desea graficar?')
    disp('1. Sí')
    disp('2. No')
    opc = input('Respuesta: ');
    
    if opc == 1
        graficar(x, t, n, u, du, W)
    end
    
    disp('¿Desea analizar la convergencia?')
    disp('1. Temporal')
    disp('2. Espacial')
    disp('3. Global')
    disp('4. No')
    opc_convergencia = input('Respuesta: ');
    
    switch opc_convergencia
        case 1
            ordenTemporal()
        case 2
            ordenEspacial()
        case 3
            ordenGlobal()
    end
    fichero(m, n, max(max(abs(u-W(:, :, 1)))), max(max(abs(du-W(:, :, 2)))))
end

function W0 = Winicial(x)

    W0 = 2 * sin(4*pi*x)';

end