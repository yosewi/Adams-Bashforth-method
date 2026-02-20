function generuj_tabele(rownanie, warunki, rozwiazanie, a, b, y0, x0, xN, sol_func)
% Zadanie 36
% Julian Sowiński, 331435
%
% Funkcja pomocnicza generująca tabelę dla pojedynczego przypadku

fprintf('%-10s %-20s %-20s\n', 'h', 'Błąd Globalny', 'Błąd Lokalny');
fprintf('------------------------------------------------------------\n');

h_values = [0.1, 0.01, 0.001]; 

for h = h_values
    N = round((xN - x0) / h);
    if N < 4, continue; end 
    
    % Wywołanie głównej funkcji
    y_res = P2Z36_JSO_Adams_Bashforth(b, a, x0, xN, y0, N, 3);
    
    % Obliczenie rozwiązania dokładnego
    x_vals = x0 : h : xN;
    y_exact = sol_func(x_vals);
    
    % Obliczenie błędów
    y_num = y_res(1, :);
    diffs = abs(y_num - y_exact);
    
    err_global = max(diffs);       
    err_local = min(diffs(2:end));
    
    % Wypisanie wiersza
    fprintf('%-10g %-20s %-20s\n', h, format_sci(err_global), ...
        format_sci(err_local));
            
end

% Sekcja Opisowa pod tabelą
fprintf('\n');
fprintf('Opis:\n');
fprintf('Równanie:    %s\n', rownanie);
fprintf('Warunki:     %s\n', warunki);
fprintf('Rozwiązanie: %s\n', rozwiazanie);
fprintf('============================================================\n');
fprintf('Nacisnij dowolny przycisk...\n');
pause;
fprintf('\n');
end