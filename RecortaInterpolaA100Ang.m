 function [Alfa,Beta,Gamma] = RecortaInterpolaA100Ang(alfa,beta,gamma,inicio,fin)
%  recibe una lista de ordenadas en la variable AMostrar y la interpola a 100 muestras de ordenadas;
% Genera la absisa original con la variable Tiempo
% Genera la nueva absisa  con la variable Porcentaje
% Devuelve sobreescriviendo la variable AMostrar con 10 muestras
 
 alfa_aux = alfa(inicio:fin);
 beta_aux = beta(inicio:fin);
 gamma_aux = gamma(inicio:fin);

 Alfa = InterpolaA100Muestras(alfa_aux);
 Beta = InterpolaA100Muestras(beta_aux);
 Gamma = InterpolaA100Muestras(gamma_aux);
 
 Alfa = Alfa';
 Beta = Beta';
 Gamma = Gamma';

 
