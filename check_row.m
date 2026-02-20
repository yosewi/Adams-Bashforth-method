function check_row(eq_name, sol_name, a, b, y0, sol_func, x0, xN, N)
% Zadanie 36
% Julian Sowiński, 331435
%
% Uruchomienie głównej funkcji
y_res = P2Z36_JSO_Adams_Bashforth(b, a, x0, xN, y0, N, 4);

h = (xN - x0)/N;
X = x0:h:xN;
y_exact = sol_func(X);

% Dla równań 2. rzędu (y_res jest macierzą 2xN) bierzemy 1. wiersz (y)
err = max(abs(y_res(1,:) - y_exact));

% Formatowanie wyniku
err_str = format_sci(err);

fprintf('| %-15s | %-15s | %-20s|\n', eq_name, sol_name, err_str);

end