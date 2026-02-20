function y = wykonaj_start_ralston(y, T, h, a, b, rzad, steps)
% Zadanie 36
% Julian Sowiński, 331435
%
% Funkcja realizująca fazę rozruchową algorytmu.
% Oblicza pierwsze 'steps' punktów rozwiązania przy użyciu metody
% jednokrokowej Ralstona (RK4), co jest niezbędne do uruchomienia
% metody wielokrokowej Adamsa.
%
% WEJŚCIE:
%   y - macierz rozwiązania (zainicjalizowana warunkami początkowymi)
%   T - wektor czasu/siatki
%   h - krok całkowania
%   a, b  - parametry równania różniczkowego
%   rzad - rząd równania (1 lub 2)
%   steps - liczba kroków do wykonania
%
% WYJŚCIE:
%   y - uzupełniona macierz rozwiązania w zakresie kolumn 1 do steps+1

for i = 1:steps
    t_now = T(i);
    y_now = y(:, i);
    
    y_next = ralston(t_now, y_now, h, a, b, rzad);
    
    y(:, i+1) = y_next;
end
end