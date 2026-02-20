function y = wykonaj_petle_adams(y, T, h, a, b, rzad, start_steps, N)
% Zadanie 36
% Julian Sowiński, 331435
%
% Funkcja realizująca główną pętlę algorytmu Adamsa-Bashfortha 4. rzędu.
% Wykorzystuje historię punktów obliczoną wcześniej przez metodę startową
% do wyznaczania kolejnych wartości rozwiązania.
%
% Wzór: y_{n+1} = y_n + h/24 * (55f_n - 59f_n-1 + 37f_n-2 - 9f_n-3)
%
% WEJŚCIE:
%   y - macierz rozwiązania (częściowo wypełniona przez start)
%   T - wektor czasu/siatki
%   h - krok całkowania
%   a, b - parametry równania różniczkowego
%   rzad - rząd równania
%   start_steps - liczba wykonanych kroków startowych
%   N - całkowita liczba kroków do wykonania
%
% WYJŚCIE:
%   y - obliczona macierz rozwiązania
   
start_idx = start_steps + 1;

% Obliczamy pochodne w punktach już wyznaczonych przez Ralstona
f_n   = oblicz_pochodne(T(start_idx),   y(:, start_idx),   a, b, rzad);
f_nm1 = oblicz_pochodne(T(start_idx-1), y(:, start_idx-1), a, b, rzad);
f_nm2 = oblicz_pochodne(T(start_idx-2), y(:, start_idx-2), a, b, rzad);
f_nm3 = oblicz_pochodne(T(start_idx-3), y(:, start_idx-3), a, b, rzad);
    
% Główna pętla iteracyjna
for i = start_idx : N
    % Krok algorytmu Adamsa-Bashfortha 4. rzędu
    y(:, i+1) = y(:, i) + (h/24) * ( ...
                  55 * f_n ...
                - 59 * f_nm1 ...
                + 37 * f_nm2 ...
                -  9 * f_nm3 );
    
    % Aktualizacja zmiennych
    f_nm3 = f_nm2;
    f_nm2 = f_nm1;
    f_nm1 = f_n;
    
    % Obliczenie nowej pochodnej dla nowo wyznaczonego punktu
    if i < N
        f_n = oblicz_pochodne(T(i+1), y(:, i+1), a, b, rzad);
    end
end
end