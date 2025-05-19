%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function W = metodoRKN(c, m, n, tau, W)
    
    Dh = crearMatrizDh(m, c);
    for i=1:n
        % Establecemos las etapas
        k1 = Dh * W(2:m+1, i, 1);
    
        k2 = Dh * (W(2:m+1, i, 1) + tau/2 * W(2:m+1, i, 2) + tau^2 / 8 * k1);
    
        k3 = Dh * (W(2:m+1, i, 1) + tau * W(2:m+1, i, 2) + tau^2 / 2 * k2);
    
        % Almacenamos el paso siguiente
        W(2:m+1, i+1, 1) = W(2:m+1, i, 1) + tau * W(2:m+1, i, 2) ...
                            + tau^2 / 6 * (k1 + 2 * k2);
        
        W(2:m+1, i+1, 2) = W(2:m+1, i, 2) + tau / 6 * (k1 + 4 * k2 + k3);
    end

end