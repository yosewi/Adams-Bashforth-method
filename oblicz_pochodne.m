function dY = oblicz_pochodne(x, Y, a, b, rzad)
% Zadanie 36
% Julian Sowiński, 331435
%
% Funkcja zwraca pełny wektor pochodnych dY = [y'; y''; ...; y^(n)]
% Łączy w sobie przepisywanie niższych pochodnych i obliczanie najwyższej.

    % Część dolna (przepisanie pochodnych niższych rzędów)
    if rzad > 1
        pochodne_nizsze = Y(2:end);
    else
        pochodne_nizsze = [];
    end
    
    % Część górna (najwyższa pochodna z równania)
    suma_lewej_strony = 0;
    for k = 1:rzad
        wspolczynnik = a{k}(x);  
        wartosc_y    = Y(k);     
        
        suma_lewej_strony = suma_lewej_strony + (wspolczynnik * wartosc_y);
    end
    
    wspolczynnik_przy_najwyzszej = a{rzad+1}(x);
    wymuszenie_b = b(x);
    
    najwyzsza_pochodna = (wymuszenie_b - suma_lewej_strony) / ...
        wspolczynnik_przy_najwyzszej;
   
    dY = [pochodne_nizsze; najwyzsza_pochodna];
    
end