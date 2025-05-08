%Informe - Biomec�nica Sentadilla con Barra
%Estudio de la biomecanica de la Sentadilla con Barra en un sujeto de
%prueba
%Matias Madrid 01/05/2025

clear all;

%% LECTURA DE ARCHIVOS

Archivo_000 = 'sentadilla_000.c3d';
Archivo_001 = 'sentadilla_001.c3d';
h_000 = btkReadAcquisition(Archivo_000);
h_001 = btkReadAcquisition(Archivo_001);
[marcadores_000,informacionCine_000] = btkGetMarkers(h_000);
[marcadores_001,informacionCine_001] = btkGetMarkers(h_001);

%% LEECTURA Y RECTORTE DE LOS MARCADORES

fm_000 = informacionCine_000.frequency(1); %340 frames
fm_001 = informacionCine_001.frequency(1); %340 frames
fm = fm_000;

%% DATOS ANTROPOMETRICOS

altura = 180; %[cm]
A1 = 72; %peso [Kg] / Masa Corporal Total
A2 = 28/100; %BIILEOCRESTAL / Distancia entre Crestas Il�acas Superiores Ant. [m]
A3 = 40/100; %TROCANTER A TIBIAL R / Longitud Muslo Derecho
A4 = 40/100; %TROCANTER A TIBIAL L / Longitud Muslo Izquierdo
A5 = 54/100; % PERIMETRO MUSLO R / Circunferencia Muslo Derecho (M�xima Circunf)
A6 = 54/100; %PERIMETRO MUSLO  L / Circunferencia Muslo Izquierdo (M�xima Circunf)
A7 = 40/100; %TIBIAL L-MALEOLO R / Longitud Pierna Derecha
A8 = 41/100; %TIBIAL L-MALEOLO L / Longitud Pierna Izquierda
A9 = 36.5/100; %PERIMETRO PANTORRILLA R / Circunferencia Pierna Derecha (M�xima Circunf)
A10 = 36/100; %PERIMETRO PANTORRILLA L / Circunferencia Pierna Izquierda (M�xima Circunf)
A11 = 11.5/100; % BIEPIC�NDELO FEMUR R / Di�metro Rodilla Derecha
A12 = 9.5/100; % BIEPIC�NDELO FEMUR L / Di�metro Rodilla Izquierda
A13 = 28.5/100; % LONGITUD PIE R / Longitud Pie Derecho (desde tal�n a punta del pie)
A14 = 28.9/100; % LONGITUD PIE L / Longitud Pie Izquierdo (desde tal�n a punta del pie)
A15 = (48.5-40)/100; % (TIBIAL L-MALEOLO - TIBIAL  LATERAL (PISO)) / Altura Mal�olo Derecho (la persona debe estar parada)
A16 = (49-41)/100; % (TIBIAL L-MALEOLO - TIBIAL  LATERAL (PISO)) / Altura Mal�olo Izquierdo (la persona debe estar parada)
A17 = 7/100; % DIAMETRO MALEOLO R / Ancho Mal�olo Derecho (Ancho m�ximo de mal�olo lat a medial)
A18 = 9/100; % DIAMETRO MALEOLO L / Ancho Mal�olo Izquierdo (Ancho m�ximo de mal�olo lat a medial)



