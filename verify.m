function verify(nazwa, a, b, y0, x0, xN, N, opis_math, oczekiwany)
% Zadanie 36
% Julian Sowiński, 331435
%
% Funkcja porównuje wynik otrzymany z oczekiwanym.

% Uruchamiamy program (wymuszamy 3 kroki startowe Ralstona, 4. krok to Adams)
y_res = P2Z36_JSO_Adams_Bashforth(b, a, x0, xN, y0, N, 3);
wynik_programu = y_res(1, end);

diff = abs(wynik_programu - oczekiwany);

fprintf('| %-10s | %-55s | %-12.8f   | %-8.1e |\n', ...
    nazwa, opis_math, wynik_programu, diff);
end