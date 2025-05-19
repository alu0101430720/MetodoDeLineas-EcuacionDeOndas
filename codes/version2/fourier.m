%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function U = fourier(m, n, x, t, L, N, c, f, g)
    % Aproximacion por fourier para la solucion de la ecuacion de ondas
    
    % Coeficientes de Fourier
    A = zeros(1,N);
    B = zeros(1,N);
    for n_idx = 1:N
        phi = @(x) sin(n_idx*pi*x/L);
        A(n_idx) = 2/L * integral(@(x) f(x).*phi(x), 0, L);
        B(n_idx) = 2/(n_idx*pi*c) * integral(@(x) g(x).*phi(x), 0, L);
    end
    
    % Calculo de la solucion
    
    x = x(:)';    
    t = t(:);     
    
    n_indices = (1:N)';                    
    lambda = n_indices * pi * c / L;       
    
    % sin(n*pi*x/L)
    phi_vals = sin(n_indices * pi * x / L);
    
    % lambda_n * t
    lambda_t = t * lambda';
    
    % cos y sin para t
    cos_lambda_t = cos(lambda_t);  
    sin_lambda_t = sin(lambda_t);  
    
    % Coedicientes dependientes del tiempo
    time_u = cos_lambda_t .* A + sin_lambda_t .* B;
    time_du = -sin_lambda_t .* (lambda' .* A) + cos_lambda_t .* (lambda' .* B);
    
    % Solucion y derivada
    U_vals = time_u * phi_vals;       
    dU_vals = time_du * phi_vals;
    
    % Almacenamiento
    U = zeros(m+2, n+1, 2);
    U(:,:,1) = U_vals';  
    U(:,:,2) = dU_vals';

end
