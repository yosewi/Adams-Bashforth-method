function test2()
% Zadanie 36
% Julian Sowiński, 331435
%
% Skrypt weryfikuje stopień wielomianu, dla którego zaimplementowana metoda
% Adamsa-Bashfortha 4. rzędu jest dokładna.
%
% Zgodnie z teorią, metoda liniowa wielokrokowa rzędu p powinna całkować
% bezbłędnie równania, których rozwiązaniem jest wielomian stopnia 
% co najwyżej p.
%
% Parametry testu:
% - Krok całkowania h = 0.02
% - Przedział [0, 1]
% - Zerowe warunki początkowe

fprintf('=============================================================================|\n');
fprintf(' TEST 2: Badanie dokładności metody dla rozwiązań wielomianowych             |\n');
fprintf('-----------------------------------------------------------------------------|\n');
fprintf(' Metoda: Adams-Bashforth rzędu 4 (start: Ralston RK4).                       |\n');
fprintf(' Cel: Sprawdzenie, czy dla wielomianów stopnia <= 4 błąd jest bliski zeru    |\n');
fprintf('      maszynowemu (rzędu 10^-16). (Spodziewamy się, że taki będzie           |\n');
fprintf('=============================================================================|\n');

% Parametry wspólne dla wszystkich testów:
x0 = 0; 
xN = 1.0; 
h = 0.02;          
N = round((xN - x0) / h); % N = 50

% Nagłówek tabeli wyników
fprintf('\n| %-15s | %-15s | %-20s|\n', 'Równanie', 'Rozwiązanie', ...
    'Błąd globalny');
fprintf('|%s|\n', repmat('-', 1, 57));

% y' = x -> y = x^2/2
check_row("y'(x) = x", "y(x) = x^2/2", ...
          {@(x)0, @(x)1}, @(x)x, 0, @(x)(x.^2)/2, x0, xN, N);

% y' = x^2 -> y = x^3/3
check_row("y'(x) = x^2", "y(x) = x^3/3", ...
          {@(x)0, @(x)1}, @(x)x.^2, 0, @(x)(x.^3)/3, x0, xN, N);

% y' = x^3 -> y = x^4/4
check_row("y'(x) = x^3", "y(x) = x^4/4", ...
          {@(x)0, @(x)1}, @(x)x.^3, 0, @(x)(x.^4)/4, x0, xN, N);

fprintf('|%s|\n', repmat('-', 1, 57));

% y'' = 1 -> y = x^2/2
check_row("y''(x) = 1", "y(x) = x^2/2", ...
          {@(x)0, @(x)0, @(x)1}, @(x)1, [0;0], @(x)(x.^2)/2, x0, xN, N);

% y'' = x -> y = x^3/6
check_row("y''(x) = x", "y(x) = x^3/6", ...
          {@(x)0, @(x)0, @(x)1}, @(x)x, [0;0], @(x)(x.^3)/6, x0, xN, N);

% y'' = x^2 -> y = x^4/12
check_row("y''(x) = x^2", "y(x) = x^4/12", ...
          {@(x)0, @(x)0, @(x)1}, @(x)x.^2, [0;0], @(x)(x.^4)/12, x0, xN, N);
      
fprintf('|%s|\n', repmat('-', 1, 57));

% y' = x^4 -> y = x^5/5
check_row("y'(x) = x^4", "y(x) = x^5/5", ...
          {@(x)0, @(x)1}, @(x)x.^4, 0, @(x)(x.^5)/5, x0, xN, N);

% y'' = x^3 -> y = x^5/20
check_row("y''(x) = x^3", "y(x) = x^5/20", ...
          {@(x)0, @(x)0, @(x)1}, @(x)x.^3, [0;0], @(x)(x.^5)/20, x0, xN, N);

fprintf('|%s|\n', repmat('-', 1, 57));
end
