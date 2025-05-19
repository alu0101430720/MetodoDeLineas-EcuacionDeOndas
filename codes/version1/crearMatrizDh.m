%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function Dh=crearMatrizDh(m)

    % En esta función construiremos la matriz D_h fruto de la
    % discretización espacial del problema presentado en el informe anexo.

    h = 1/(m+1);
    Dh_u = ones(m, 1); Dh_u(1) = 0;
    Dh_d = -2*ones(m, 1);
    Dh_l = ones(m, 1); Dh_l(m) = 0;

    Dh = 1/(16*h^2) * spdiags([Dh_l, Dh_d, Dh_u], -1:1, m, m);

end