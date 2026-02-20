function numtest1()
% Zadanie 36
% Julian Sowiński, 331435
%
% Test bada wpływ proporcji użycia metod (startowej RK4 vs głównej AB4)
% na czas wykonywania obliczeń oraz błąd globalny.
%
% Dla wybranych równań różniczkowych zmieniamy parametr 'steps_ralston'
% (liczbę kroków startowych) od minimum (3 kroki) do maksimum (cały przedział).
%
% Oczekiwane rezultaty:
% - Czas obliczeń powinien rosnąć liniowo wraz z udziałem metody Ralstona 
%   (ponieważ RK4 wymaga 4 obliczeń funkcji na krok, a Adams tylko 1).
% - Błąd globalny zazwyczaj jest porównywalny, co ma wykazać przewagę
%   metody Adamsa-Bashfortha.

fprintf('==================================================================================|\n');
fprintf(' TEST NUMERYCZNY 1:                                                               |\n');
fprintf('----------------------------------------------------------------------------------|\n');
fprintf(' Zbadanie wpływu proporcji użycia metod Rungego-Kunnty i Adamsa-Bashfortha        |\n');
fprintf(' na czas wykonywania obliczeń oraz błąd globalny.                                 |\n');
fprintf(' Czas obliczeń powinien rosnąć liniowo wraz z udziałem metody Ralstona.           |\n');
fprintf(' Błąd globalny zazwyczaj jest porównywalny, co ma wykazać przewagę metody         |\n');
fprintf(' Adamsa-Bashfortha.                                                               |\n');
fprintf('==================================================================================|\n');
fprintf("\n");

% y'' + y = 0, y(0)=0, y'(0)=1
% Rozwiązanie: sin(x)
run_efficiency_test("y'' + y = 0", "y(x) = sin(x)", ...
    {@(x)1, @(x)0, @(x)1}, @(x)0, [0; 1], ... 
    0, 10, 5000, ...                          
    @(x) sin(x));                             

% y'' + 3y = x
% Rozwiązanie: x/3 - sqrt(3)/9 * sin(sqrt(3)*x)
s3 = sqrt(3);
run_efficiency_test("y'' + 3y = x", "y(x) = x/3 - (sqrt(3)/9)*sin(sqrt(3)x)", ...
    {@(x)3, @(x)0, @(x)1}, @(x)x, [0; 0], ...
    0, 10, 5000, ...
    @(x) (x./3) - (s3/9)*sin(s3*x));

% y' - y = x*e^x
% Rozwiązanie: 0.5 * x^2 * e^x
run_efficiency_test("y' - y = x*e^x", "y(x) = 0.5 * x^2 * e^x", ...
    {@(x)-1, @(x)1}, @(x) x.*exp(x), 0, ...
    0, 2, 2000, ...
    @(x) 0.5 * x.^2 .* exp(x));

K = 50; % Liczba składników sumy
vec_k = (1:K)';

P_func = @(x) sum(sin(vec_k * x), 1); 

% Rozwiązanie dokładne: y(x) = exp( Sum( (cos(kx)-1)/k ) )
sol_series = @(x) exp(sum( (cos(vec_k * x) - 1) ./ vec_k, 1 ));

run_efficiency_test("y' + y * Sum_{k=1}^{50} sin(kx) = 0", ...
    "y(x) = exp( Sum( (cos(kx)-1)/k ) )", ...
    {@(x) P_func(x), @(x)1}, @(x)0, 1, ...
    0, 5, 2000, ...                   
    @(x) sol_series(x));

end