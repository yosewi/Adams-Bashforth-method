function y_next = ralston(t, y, h, a, b, rzad)
% Zadanie 36
% Julian Sowiński, 331435
%
% RALSTON - Metoda Rungego-Kutty 4. rzędu o minimalnym błędzie.
% Współczynniki dokładne (z pierwiastkami) wg Anthony Ralston (1962).

% Stała pomocnicza
s5 = sqrt(5);

% Węzły czasowe (c)
c2 = 0.4;                 
c3 = (14 - 3*s5) / 16;    
c4 = 1.0;                      

% Współczynniki macierzy A (aij)
% Wiersz 2 (dla k2):
a21 = 0.4;            

% Wiersz 3 (dla k3):
a31 = (-2889 + 1428*s5) / 1024;
a32 = (3785 - 1620*s5) / 1024;

% Wiersz 4 (dla k4):
a41 = (-3365 + 2094*s5) / 6040;
a42 = (-975 - 3046*s5) / 2552;
a43 = (467040 + 203968*s5) / 240845;

% Wagi (b)
b1 = (263 + 24*s5) / 1812;
b2 = (125 - 1000*s5) / 3828;
b3 = (3426304 + 1661952*s5) / 5924787;
b4 = (30 - 4*s5) / 123;

% Algorytm

% Krok 1 (k1)
k1 = oblicz_pochodne(t, y, a, b, rzad);

% Krok 2 (k2)
t2 = t + c2*h;
y2 = y + h * (a21 * k1);
k2 = oblicz_pochodne(t2, y2, a, b, rzad);

% Krok 3 (k3)
t3 = t + c3*h;
y3 = y + h * (a31 * k1 + a32 * k2);
k3 = oblicz_pochodne(t3, y3, a, b, rzad);

% Krok 4 (k4)
t4 = t + c4*h;
y4 = y + h * (a41 * k1 + a42 * k2 + a43 * k3);
k4 = oblicz_pochodne(t4, y4, a, b, rzad);

% Wynik końcowy (suma ważona)
y_next = y + h * (b1*k1 + b2*k2 + b3*k3 + b4*k4);
end