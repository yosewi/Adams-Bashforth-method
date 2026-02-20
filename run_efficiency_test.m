function run_efficiency_test(eq_str, sol_str, a, b, y0, x0, xN, N, sol_func)
% Zadanie 36
% Julian Sowiński, 331435
%
% Funkcja pomocnicza wykonująca test dla jednego równania

fprintf('Równanie: %s\n', eq_str);
fprintf('Rozwiązanie: %s\n', sol_str);
fprintf('Parametry: Przedział [%g, %g], Liczba kroków N = %d\n', x0, xN, N);

% Nagłówek tabeli
fprintf('\n| %-15s | %-12s | %-15s | %-15s |\n', 'Udział RK4', ...
    'Kroki RK4', 'Czas [s]', 'Błąd Globalny');
fprintf('|%s|\n', repmat('-', 1, 68));

ratios = [0, 0.25, 0.50, 0.75, 1.00];

for r = ratios
    % Wyznaczanie liczby kroków Ralstona
    if r == 0
        steps = 3; % Minimum dla AB4
        label = "0%";
    elseif r == 1
        steps = N;
        label = "100%";
    else
        steps = round(r * N);
        label = sprintf('%.0f%%', r*100);
    end
    
    % Pomiar czasu (uśredniony z 10 prób)
    t_start = tic;
    n_rep = 10;
    for i = 1:n_rep
        y_res = P2Z36_JSO_Adams_Bashforth(b, a, x0, xN, y0, N, steps);
    end
    avg_time = toc(t_start) / n_rep;
    
    % Obliczenie błędu globalnego
    h = (xN - x0)/N;
    X = x0:h:xN;
    y_exact = sol_func(X);
    
    err = max(abs(y_res(1,:) - y_exact));
    
    % Wyświetlenie wiersza
    fprintf('| %-15s | %-12d | %-15.5f | %-15.2e |\n', ...
        label, steps, avg_time, err);
end
fprintf('|%s|\n', repmat('-', 1, 68));
fprintf("\n");
end