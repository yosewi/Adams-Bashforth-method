function run_stability_test(eq_str, sol_str, a, b, y0, x0, xN, sol_func, N_values)
% Zadanie 36
% Julian Sowiński, 331435
%
% Funkcja pomocnicza wykonująca serię symulacji dla różnych N

fprintf(' Równanie:    %s\n', eq_str);
fprintf(' Rozwiązanie: %s\n', sol_str);

fprintf('\n| %-6s | %-10s | %-22s | %-22s |\n', 'N', 'Krok h', ... 
     'Błąd Adams (AB4)', 'Błąd Ralston (RK4)');
fprintf('|%s|\n', repmat('-', 1, 71));

for N = N_values
    h = (xN - x0)/N;
    
    % Metoda Adamsa (z minimalnym startem Ralstona - 3 kroki)
    % To symuluje zachowanie metody wielokrokowej.
    ya = P2Z36_JSO_Adams_Bashforth(b, a, x0, xN, y0, N, 3);
    err_a = abs(ya(1,end) - sol_func(xN));
    
    % Metoda Ralstona (całość liczona RK4)
    % Służy jako referencja stabilności metody jednokrokowej.
    yr = P2Z36_JSO_Adams_Bashforth(b, a, x0, xN, y0, N, N);
    err_r = abs(yr(1,end) - sol_func(xN));
    
    % Formatowanie wyjścia
    fprintf('| %-6d | %-10.4f | %-22s | %-22s |\n', ...
        N, h, format_sci(err_a), format_sci(err_r));
end
fprintf('|%s|\n', repmat('-', 1, 71));
fprintf("\n");
fprintf("Nacisnij dowolny przycisk...");
pause;
fprintf("\n")
end