function [y] = P2Z36_JSO_Adams_Bashforth(b, a, x0, xN, y0, N, varargin)
% Projekt 2, zadanie 36
% Julian Sowiński, 331435
%
% Funkcja rozwiązuje liniowe równania różniczkowe rzędu 1. i 2. metodą
% jawną Adamsa-Bashfortha 4. rzędu. Do inicjalizacji (pierwsze kroki)
% wykorzystywana jest metoda Ralstona (RK4).
%
% SKŁADNIA:
%   y = P2Z36_JSO_Adams_Bashforth(b, a, x0, xN, y0, N)
%   y = P2Z36_JSO_Adams_Bashforth(b, a, x0, xN, y0, N, steps_ralston)
%
% WEJŚCIE:
%   b - uchwyt do funkcji b(x)
%   a - komórka uchwytów do funkcji współczynników (np. {@(x)1, @(x)1})
%   x0, xN - początek i koniec przedziału całkowania
%   y0 - warunki początkowe (skalar dla rz. 1, wektor kolumnowy dla rz. 2)
%   N - liczba kroków siatki
%   varargin - (opcjonalnie) liczba kroków startowych Ralstona
%   (domyślnie 3)
%
% WYJŚCIE:
%   y - macierz rozwiązania (wiersz 1: y(x), wiersz 2: y'(x))

h = (xN - x0) / N;     
T = x0 : h : xN;       
rzad_rownania = length(a) - 1; 

y = zeros(rzad_rownania, N + 1);
y(:, 1) = y0(:);

% Ustalenie liczby kroków Ralstona
if nargin > 6 && ~isempty(varargin{1})
    steps_ralston = varargin{1};
else
    steps_ralston = 3; 
end

% Uruchamiamy metodę jednokrokową, aby zebrać historię punktów
y = wykonaj_start_ralston(y, T, h, a, b, rzad_rownania, steps_ralston);

% Jeśli zostało coś do policzenia, uruchamiamy metodę wielokrokową
if steps_ralston < N
    y = wykonaj_petle_adams(y, T, h, a, b, rzad_rownania, steps_ralston, N);
end