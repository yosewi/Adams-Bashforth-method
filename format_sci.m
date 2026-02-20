function str = format_sci(val)
% Zadanie 36
% Julian Sowiński, 331435
%
% Formatowanie liczb
 
if val == 0
    str = '0'; 
    return;
end
exponent = floor(log10(val));
mantissa = val / (10^exponent);
str = sprintf('%.2f * 10^{%d}', mantissa, exponent);
end