function numtest2()
% Zadanie 36
% Julian Sowiński, 331435
%
% Wyznaczenie granicznego kroku całkowania h, powyżej którego metoda
% Adamsa-Bashfortha (AB4) traci stabilność numeryczną.
%
% Metody jawne wielokrokowe posiadają ograniczony obszar stabilności.
% Przekroczenie granicznego h powoduje gwałtowny wzrost błędu,
% mimo że metoda jest wysokiego rzędu.
%
% Testujemy zachowanie metody dla malejącej liczby kroków N (rosnącego h)
% w porównaniu do metody Rungego-Kutty (Ralstona), która posiada szerszy
% obszar stabilności.

fprintf('==================================================================================|\n');
fprintf(' TEST NUMERYCZNY 2:                                                               |\n');
fprintf('----------------------------------------------------------------------------------|\n');
fprintf(' Badamy zachowanie błędu globalnego w funkcji wielkości kroku h.                  |\n');
fprintf(' Oczekujemy gwałtownego wzrostu błędu dla AB4 przy przekroczeniu krytycznego h.   |\n');
fprintf(' Metoda Ralstona (RK4) służy jako punkt odniesienia (jest bardziej stabilna).     |\n');
fprintf('==================================================================================|\n');
fprintf("\n");

% y' + y = 0.
run_stability_test("y' = -y", "y(x) = exp(-x)", ...
    {@(x)1, @(x)1}, @(x)0, 1, ...      % a={1,1} -> y' + y = 0
    0, 5, ...                          % Przedział [0, 5]
    @(x) exp(-x), ...                  % Rozwiązanie
    [10, 20, 30, 40, 50, 60]);         % Zakres N

% y' + 20y = 0.
run_stability_test("y' = -20y", "y(x) = exp(-20x)", ...
    {@(x)20, @(x)1}, @(x)0, 1, ...     % a={20,1} -> y' + 20y = 0
    0, 2, ...                          % Przedział [0, 2]
    @(x) exp(-20*x), ...
    [100, 120, 140, 160, 180, 200]);   % Zakres N

% y'' + 10y' + y = 0.
% Rozwiązanie analityczne:
r1 = (-10 + sqrt(96))/2; 
r2 = (-10 - sqrt(96))/2;
C1 = (2*r2 + 10)/(r2-r1); 
C2 = 2 - C1;
sol_damped = @(x) C1*exp(r1*x) + C2*exp(r2*x);

run_stability_test(...
    "y'' + 10y' + y = 0", "y(x) = C1*exp(r1*x) + C2*exp(r2*x)", ...
    {@(x)1, @(x)10, @(x)1}, @(x)0, [2; -10], ... % y(0)=2, y'(0)=-10
    0, 2, ...
    sol_damped, ...
    [40, 50, 60, 70, 80, 100]);

end