function test3()
% Zadanie 36
% Julian Sowiński, 331435
%
% Test porównuje wynik programu z ręcznym obliczeniem wykorzystującym
% unikalne wagi metody Adamsa-Bashfortha: 55, -59, 37, -9.
%
% Jeśli wynik programu zgadza się z wynikiem ręcznym, oznacza to,
% że program wykonuje dokładnie te same mnożenia.

fprintf('===================================================================================================|\n');
fprintf(' TEST 3: weryfikacja współczynników                                                                |\n');
fprintf('===================================================================================================|\n');
fprintf(' Metoda weryfikacji:                                                                               |\n');
fprintf(' 1. Bierzemy historię wartości funkcji (f) dla prostego równania.                                  |\n');
fprintf(' 2. Podstawiamy je ręcznie do wzoru: y_new = y_old + h/24 * (55*fn - 59*fn-1 + 37*fn-2 - 9*fn-3).  |\n');
fprintf(' 3. Sprawdzamy, czy program zwraca ten sam wynik. (Spodziewamy się, że zwróci)                     |\n');
fprintf('---------------------------------------------------------------------------------------------------|\n');

% Parametry testu
h = 1.0;
N = 4;
x0 = 0;
xN = x0 + N*h;
y0 = 0;

% Nagłówek tabeli
fprintf('\n| %-10s | %-55s | %-12s | %-8s |\n', 'Równanie', ... 
     'Obliczenie Ręczne (Wzór Adamsa)', 'Wynik Programu', 'Różnica');
fprintf('|%s|\n', repmat('-', 1, 98));

% Historia pochodnych (f): 0, 1, 2, 3
% y_start (z dokładnego wzoru dla y=x^2/2 w punkcie x=3): 4.5
%
% Ręczne obliczenie kroku:
% y_new = 4.5 + 1/24 * ( 55*3 - 59*2 + 37*1 - 9*0 )
% y_new = 4.5 + 1/24 * ( 165  - 118  + 37   - 0   )
% y_new = 4.5 + 1/24 * ( 84 )
% y_new = 4.5 + 3.5 = 8.0

verify("y' = x", ...
    {@(x)0, @(x)1}, @(x)x, ...
    y0, x0, xN, N, ...
    "4.5 + 1/24*(55*3 - 59*2 + 37*1) = 8.0", 8.0);

% Historia pochodnych (f): 1, 1, 1, 1
% y_start (dla y=x w punkcie x=3): 3.0
%
% Ręczne obliczenie kroku:
% y_new = 3.0 + 1/24 * ( 55*1 - 59*1 + 37*1 - 9*1 )
% y_new = 3.0 + 1/24 * ( 24 )
% y_new = 3.0 + 1.0 = 4.0

verify("y' = 1", ...
    {@(x)0, @(x)1}, @(x)1, ...
    y0, x0, xN, N, ...
    "3.0 + 1/24*(55*1 - 59*1 + 37*1 - 9*1) = 4.0", 4.0);

% Historia pochodnych (f): 0, 2, 4, 6
% y_start (dla y=x^2 w punkcie x=3): 9.0
%
% Ręczne obliczenie kroku:
% y_new = 9.0 + 1/24 * ( 55*6 - 59*4 + 37*2 - 9*0 )
% y_new = 9.0 + 1/24 * ( 330  - 236  + 74   - 0   )
% y_new = 9.0 + 1/24 * ( 168 )
% y_new = 9.0 + 7.0 = 16.0

verify("y' = 2x", ...
    {@(x)0, @(x)1}, @(x)2*x, ...
    y0, x0, xN, N, ...
    "9.0 + 1/24*(55*6 - 59*4 + 37*2) = 16.0", 16.0);

fprintf('|%s|\n', repmat('-', 1, 98));
end