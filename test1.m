function test1()
% Zadanie 36
% Julian Sowiński, 331435
%
% Skrypt weryfikuje eksperymentalnie rząd zbieżności zaimplementowanej metody
% Adamsa-Bashfortha. Metoda ta jest teoretycznie rzędu 4, co oznacza, że
% globalny błąd dyskretyzacji powinien być proporcjonalny do h^4.
%
% Weryfikacja polega na rozwiązywaniu równań testowych ze znanym rozwiązaniem
% analitycznym dla malejącego kroku całkowania h (0.1 -> 0.01 -> 0.001).
% Oczekujemy, że przy 10-krotnym zmniejszeniu kroku, błąd zmaleje
% w przybliżeniu 10^4 = 10 000 razy.
%
% Test obejmuje równania liniowe 1. rzędu (stałe i zmienne współczynniki)
% oraz równania liniowe 2. rzędu (oscylatory, rezonanse, równania Eulera).

fprintf('=============================================================================|\n');
fprintf(' TEST ZBIEŻNOŚCI: Badanie rzędu metody Adamsa-Bashfortha (4. rząd)           |\n');
fprintf('-----------------------------------------------------------------------------|\n');
fprintf(' Metodologia: Rozwiązujemy równania na ustalonym przedziale, zmieniając krok |\n');
fprintf(' h w sekwencji: 0.1 -> 0.01 -> 0.001.                                        |\n');
fprintf('-----------------------------------------------------------------------------|\n');
fprintf(' Cel: Potwierdzenie, że błąd globalny maleje proporcjonalnie do h^4.         |\n');
fprintf(' Oczekiwana redukcja błędu przy zmianie kroku 10x to około 10 000 razy.      |\n');
fprintf('=============================================================================|\n');
fprintf("Nacisnij dowolny przycisk...");
pause;
fprintf("\n");
fprintf("\n");

% y' - 5y = -3, y(2)=1
a = {@(x)-5, @(x)1}; 
b = @(x)-3;
y0 = 1; x0 = 2; xN = 2.4;
sol = @(x) 0.4 * exp(5*(x-2)) + 0.6;
generuj_tabele("y' - 5y = -3", "y(2) = 1", "y(x) = 0.4e^{5(x-2)} + 0.6", ...
    a, b, y0, x0, xN, sol);

% y' - 2xy = 0, y(0)=1
a = {@(x)-2*x, @(x)1}; 
b = @(x)0;
y0 = 1; x0 = 0; xN = 1;
sol = @(x) exp(x.^2);
generuj_tabele("y' - 2xy = 0", "y(0) = 1", "y(x) = e^{x^2}", ...
    a, b, y0, x0, xN, sol);

% y' + y*tan(x) = cos(x), y(0)=0
a = {@(x)tan(x), @(x)1}; 
b = @(x)cos(x);
y0 = 0; x0 = 0; xN = 1;
sol = @(x) x.*cos(x);
generuj_tabele("y' + y*tan(x) = cos(x)", "y(0) = 0", "y(x) = x*cos(x)", ...
    a, b, y0, x0, xN, sol);

% 2y'' + 3y' - 5y = 0
a = {@(x)-5, @(x)3, @(x)2}; 
b = @(x)0;
y0 = [2; -1]; x0 = 0; xN = 1;
sol = @(x) (6/7)*exp(-2.5*x) + (8/7)*exp(x);
generuj_tabele("2y'' + 3y' - 5y = 0", "y(0) = 2, y'(0) = -1", "y(x) = (6/7)e^{-2.5x} + ...", ...
    a, b, y0, x0, xN, sol);

% y'' + y = 2cos(x)
a = {@(x)1, @(x)0, @(x)1}; 
b = @(x) 2*cos(x);
y0 = [0; 0]; x0 = 0; xN = 4;
sol = @(x) x.*sin(x);
generuj_tabele("y'' + y = 2cos(x)", "y(0) = 0, y'(0) = 0", "y(x) = x*sin(x)", ...
    a, b, y0, x0, xN, sol);

% x^2 y'' - 2xy' + 2y = 0
a = {@(x)2, @(x)-2*x, @(x)x^2}; 
b = @(x) 0;
y0 = [3; 4]; x0 = 1; xN = 2;
sol = @(x) 2*x + x.^2;
generuj_tabele("x^2 y'' - 2xy' + 2y = 0", "y(1) = 3, y'(1) = 4", "y(x) = 2x + x^2", ...
    a, b, y0, x0, xN, sol);

% y'' + 4y' + 4y = e^{-2x}
a = {@(x)4, @(x)4, @(x)1}; 
b = @(x) exp(-2*x);
y0 = [0; 0]; x0 = 0; xN = 2;
sol = @(x) 0.5 * x.^2 .* exp(-2*x);
generuj_tabele("y'' + 4y' + 4y = e^{-2x}", "y(0) = 0, y'(0) = 0", "y(x) = 0.5 x^2 e^{-2x}", ...
    a, b, y0, x0, xN, sol);
end