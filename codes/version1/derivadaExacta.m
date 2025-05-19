%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Carlos Yanes Pérez
% MNEDP - 2025
% Trabajo final de la asignatura
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function du = derivadaExacta(x, t)

    du = -2 * pi * sin(4 * pi * x)' .* sin(pi * t);

end