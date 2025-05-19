function fichero(m, n, error_sol, error_der)
    % Guarda resultados en un fichero de texto (modo escritura)
    nombre_fichero = sprintf('resultados_m%d_n%d.txt', m, n);
    modo = 'w'; % Sobrescribir cada vez

    fid = fopen(nombre_fichero, modo);
    
    if fid == -1
        error('No se pudo abrir el archivo para escritura.');
    end
    
    fprintf(fid, 'Resultados :\n');
    fprintf(fid, '=============================\n');
    fprintf(fid, 'm = %d\n', m);
    fprintf(fid, 'n = %d\n', n);
    fprintf(fid, 'Error máximo (solución)     = %.6e\n', error_sol);
    fprintf(fid, 'Error máximo (derivada)     = %.6e\n', error_der);
    
    fclose(fid);
    fprintf('Resultados guardados en %s\n', nombre_fichero);
end
