%Informe - Biomecánica Sentadilla con Barra
%Estudio de la biomecanica de la Sentadilla con Barra en un sujeto de
%prueba
%Matias Madrid 01/05/2025

clear all;
close all;
%% LECTURA DE ARCHIVOS

Archivo_000 = 'sentadilla_000.c3d';
Archivo_001 = 'sentadilla_001.c3d';
h_000 = btkReadAcquisition(Archivo_000);
h_001 = btkReadAcquisition(Archivo_001);
[marcadores_000,informacionCine_000] = btkGetMarkers(h_000);
[marcadores_001,informacionCine_001] = btkGetMarkers(h_001);

%% DATOS ANTROPOMETRICOS

altura = 180; %[cm]
A1 = 72; %peso [Kg] / Masa Corporal Total
A2 = 28/100; %BIILEOCRESTAL / Distancia entre Crestas Ilíacas Superiores Ant. [m]
A3 = 40/100; %TROCANTER A TIBIAL R / Longitud Muslo Derecho
A4 = 40/100; %TROCANTER A TIBIAL L / Longitud Muslo Izquierdo
A5 = 54/100; % PERIMETRO MUSLO R / Circunferencia Muslo Derecho (Máxima Circunf)
A6 = 54/100; %PERIMETRO MUSLO  L / Circunferencia Muslo Izquierdo (Máxima Circunf)
A7 = 40/100; %TIBIAL L-MALEOLO R / Longitud Pierna Derecha
A8 = 41/100; %TIBIAL L-MALEOLO L / Longitud Pierna Izquierda
A9 = 36.5/100; %PERIMETRO PANTORRILLA R / Circunferencia Pierna Derecha (Máxima Circunf)
A10 = 36/100; %PERIMETRO PANTORRILLA L / Circunferencia Pierna Izquierda (Máxima Circunf)
A11 = 11.5/100; % BIEPICÓNDELO FEMUR R / Diámetro Rodilla Derecha
A12 = 9.5/100; % BIEPICÓNDELO FEMUR L / Diámetro Rodilla Izquierda
A13 = 28.5/100; % LONGITUD PIE R / Longitud Pie Derecho (desde talón a punta del pie)
A14 = 28.9/100; % LONGITUD PIE L / Longitud Pie Izquierdo (desde talón a punta del pie)
A15 = (48.5-40)/100; % (TIBIAL L-MALEOLO - TIBIAL  LATERAL (PISO)) / Altura Maléolo Derecho (la persona debe estar parada)
A16 = (49-41)/100; % (TIBIAL L-MALEOLO - TIBIAL  LATERAL (PISO)) / Altura Maléolo Izquierdo (la persona debe estar parada)
A17 = 7/100; % DIAMETRO MALEOLO R / Ancho Maléolo Derecho (Ancho máximo de maléolo lat a medial)
A18 = 9/100; % DIAMETRO MALEOLO L / Ancho Maléolo Izquierdo (Ancho máximo de maléolo lat a medial)


%% LECTURA Y RECTORTE DE LOS MARCADORES (ARCHIVO 000)
%Graficamos para determinar visualmente
%inicio_aux y fin_aux de cada ciclo (max y min locales)

fm_000 = informacionCine_000.frequency(1); %340 frames
fm = fm_000;

sacro_coord_z_000 = marcadores_000.MarkerSet__SACRUM(:,3);  % marcador en el extremo izquierdo
%{
 figure;
 plot(sacro_coord_z_000, 'k', 'LineWidth', 2);
 xlabel('Frames');
 ylabel('Altura sacro(m)');
 title('Altura de la barra durante la sentadilla - marcadores_000');
 grid on;
%}
% Defin_auximos los intervalos de interés como pares [inicio_aux, fin_aux]
% para buscar maximos locales
intervalos = [
    300,  350;
    800, 1000;
    1400, 1600;
    2100, 2300;
    2750, 2950;
    3280, 3480
];%estos intervalos fueron elegidos a partir de la grafica del sacro en z

% Inicializamos vectores de resultados
frames_maximos = zeros(size(intervalos,1),1);
valores_maximos = zeros(size(intervalos,1),1);

% Iteramos por cada intervalo
for k = 1:size(intervalos,1)
    inicio_aux = intervalos(k,1);
    fin_aux = intervalos(k,2);

    % Recorte de la señal dentro del intervalo
    senial_intervalo = sacro_coord_z_000(inicio_aux:fin_aux);

    % Buscar máximo local (podría haber más de uno, tomamos el mayor)
    [picos, locs] = findpeaks(senial_intervalo);

    if ~isempty(picos)
        [valor_max, idx_max] = max(picos);
        frame_max = locs(idx_max) + inicio_aux - 1; % Corrige la posición en el vector global

        % Guardar resultados
        valores_maximos(k) = valor_max;
        frames_maximos(k) = frame_max;
    else
        % Si no se detecta pico, marcar como NaN
        valores_maximos(k) = NaN;
        frames_maximos(k) = NaN;
    end
end

% Mostrar resultados
%disp('Frames de máximos locales encontrados:');
%disp(frames_maximos);
inicio1_000 = frames_maximos(1);
fin1_000 = frames_maximos(2);

inicio2_000 = fin1_000;
fin2_000 = frames_maximos(3);

inicio3_000 = fin2_000;
fin3_000 = frames_maximos(4);

inicio4_000 = fin3_000;
fin4_000 = frames_maximos(5);

inicio5_000 = fin4_000;
fin5_000 = frames_maximos(6);

p1_000=marcadores_000.MarkerSet__R_META(inicio1_000:fin5_000,:);%Cabeza del 2do metatarsiano derecho(Rightmetatarsal head V)
p2_000=marcadores_000.MarkerSet__R_HEEL(inicio1_000:fin5_000,:);%Talón derecho(Rightheel)
p3_000=marcadores_000.MarkerSet__R_MAL_L(inicio1_000:fin5_000,:);%Maléolo lateral derecho(Right lateral malleolus)
p4_000=marcadores_000.MarkerSet__R_TIB_DIAF(inicio1_000:fin5_000,:);%Banda tibial derecha(Right tibial wand)
p5_000=marcadores_000.MarkerSet__R_KNEE_EL(inicio1_000:fin5_000,:);%Epicóndilo femoral derecho(Right Femoral epicondyle)
p6_000=marcadores_000.MarkerSet__R_FEM_DIAF(inicio1_000:fin5_000,:);%Banda femoral derecha(Right femoral wand)
p7_000=marcadores_000.MarkerSet__R_ASIS(inicio1_000:fin5_000,:);%EIAS derecha(Right ASIS)

p8_000=marcadores_000.MarkerSet__L_META(inicio1_000:fin5_000,:);%Cabeza del 2do metatarsiano izquierdo(Leftmetatarsal head II)
p9_000=marcadores_000.MarkerSet__L_HEEL(inicio1_000:fin5_000,:);%Talón izquierdo(Leftheel)
p10_000=marcadores_000.MarkerSet__L_MAL_L(inicio1_000:fin5_000,:);%Maléolo lateral izquierdo(Left lateral malleolus)
p11_000=marcadores_000.MarkerSet__L_TIB_DIAF(inicio1_000:fin5_000,:);%Banda tibial izquierda(Left tibial wand)
p12_000=marcadores_000.MarkerSet__L_KNEE_EL(inicio1_000:fin5_000,:);%Epicóndilo femoral izquierdo(Left Femoral epicondyle)
p13_000=marcadores_000.MarkerSet__L_FEM_DIAF(inicio1_000:fin5_000,:);%Banda femoral izquierda(Left femoral wand)
p14_000=marcadores_000.MarkerSet__L_ASIS(inicio1_000:fin5_000,:);%EIAS izquierda(Left ASIS)

p15_000=marcadores_000.MarkerSet__SACRUM(inicio1_000:fin5_000,:);%Sacro(Sacrum)

pBarra_der_000=marcadores_000.MarkerSet__R_Barra(inicio1_000:fin5_000,:);
pBarra_izq_000=marcadores_000.MarkerSet__L_Barra(inicio1_000:fin5_000,:);

%% LECTURA Y RECTORTE DE LOS MARCADORES (ARCHIVO 001)
%Graficamos para determinar visualmente
%inicio_aux y fin_aux de cada ciclo (max y min locales)

fm_001 = informacionCine_001.frequency(1); %340 frames

sacro_coord_z_001 = marcadores_001.MarkerSet__SACRUM(:,3);  % marcador en el extremo izquierdo
%{
 figure;
 plot(sacro_coord_z_001, 'k', 'LineWidth', 2);
 xlabel('Frames');
 ylabel('Altura sacro(m)');
 title('Altura de la barra durante la sentadilla - marcadores_000');
 grid on;
%}
% Defin_auximos los intervalos de interés como pares [inicio_aux, fin_aux]
% para buscar maximos locales
intervalos = [
    60,  120;
    550, 750;
    1150, 1350;
    1750, 1950;
    2350, 2550;
    2900, 3000
];%estos intervalos fueron elegidos a partir de la grafica del sacro en z

% Inicializamos vectores de resultados
frames_maximos = zeros(size(intervalos,1),1);
valores_maximos = zeros(size(intervalos,1),1);

% Iteramos por cada intervalo
for k = 1:size(intervalos,1)
    inicio_aux = intervalos(k,1);
    fin_aux = intervalos(k,2);

    % Recorte de la señal dentro del intervalo
    senial_intervalo = sacro_coord_z_001(inicio_aux:fin_aux);

    % Buscar máximo local (podría haber más de uno, tomamos el mayor)
    [picos, locs] = findpeaks(senial_intervalo);

    if ~isempty(picos)
        [valor_max, idx_max] = max(picos);
        frame_max = locs(idx_max) + inicio_aux - 1; % Corrige la posición en el vector global

        % Guardar resultados
        valores_maximos(k) = valor_max;
        frames_maximos(k) = frame_max;
    else
        % Si no se detecta pico, marcar como NaN
        valores_maximos(k) = NaN;
        frames_maximos(k) = NaN;
    end
end

% Mostrar resultados
%disp('Frames de máximos locales encontrados:');
%disp(frames_maximos);
inicio1_001 = frames_maximos(1);
fin1_001 = frames_maximos(2);

inicio2_001 = fin1_001;
fin2_001 = frames_maximos(3);

inicio3_001 = fin2_001;
fin3_001 = frames_maximos(4);

inicio4_001 = fin3_001;
fin4_001 = frames_maximos(5);

inicio5_001 = fin4_001;
fin5_001 = frames_maximos(6);

p1_001=marcadores_001.MarkerSet__R_META(inicio1_001:fin5_001,:);%Cabeza del 2do metatarsiano derecho(Rightmetatarsal head V)
p2_001=marcadores_001.MarkerSet__R_HEEL(inicio1_001:fin5_001,:);%Talón derecho(Rightheel)
p3_001=marcadores_001.MarkerSet__R_MAL_L(inicio1_001:fin5_001,:);%Maléolo lateral derecho(Right lateral malleolus)
p4_001=marcadores_001.MarkerSet__R_TIB_DIAF(inicio1_001:fin5_001,:);%Banda tibial derecha(Right tibial wand)
p5_001=marcadores_001.MarkerSet__R_KNEE_EL(inicio1_001:fin5_001,:);%Epicóndilo femoral derecho(Right Femoral epicondyle)
p6_001=marcadores_001.MarkerSet__R_FEM_DIAF(inicio1_001:fin5_001,:);%Banda femoral derecha(Right femoral wand)
p7_001=marcadores_001.MarkerSet__R_ASIS(inicio1_001:fin5_001,:);%EIAS derecha(Right ASIS)

p8_001=marcadores_001.MarkerSet__L_META(inicio1_001:fin5_001,:);%Cabeza del 2do metatarsiano izquierdo(Leftmetatarsal head II)
p9_001=marcadores_001.MarkerSet__L_HEEL(inicio1_001:fin5_001,:);%Talón izquierdo(Leftheel)
p10_001=marcadores_001.MarkerSet__L_MAL_L(inicio1_001:fin5_001,:);%Maléolo lateral izquierdo(Left lateral malleolus)
p11_001=marcadores_001.MarkerSet__L_TIB_DIAF(inicio1_001:fin5_001,:);%Banda tibial izquierda(Left tibial wand)
p12_001=marcadores_001.MarkerSet__L_KNEE_EL(inicio1_001:fin5_001,:);%Epicóndilo femoral izquierdo(Left Femoral epicondyle)
p13_001=marcadores_001.MarkerSet__L_FEM_DIAF(inicio1_001:fin5_001,:);%Banda femoral izquierda(Left femoral wand)
p14_001=marcadores_001.MarkerSet__L_ASIS(inicio1_001:fin5_001,:);%EIAS izquierda(Left ASIS)

p15_001=marcadores_001.MarkerSet__SACRUM(inicio1_001:fin5_001,:);%Sacro(Sacrum)
pBarra_der_001=marcadores_001.MarkerSet__R_Barra(inicio1_001:fin5_001,:);
pBarra_izq_001=marcadores_001.MarkerSet__L_Barra(inicio1_001:fin5_001,:);
%% FILTRADO DE MARCADORES

%Filtrado de marcadores del archivo 000
                        %fm - frec de muestreo
fe = fm/2;              %frec de Nyquist
wn = 10/fe;             %elijo frec de corte - 10Hz
[B,A] = butter(2,wn);   %FILTRO BUTTERWORTH
                        %help butter

for i=1:3               %help filtfilt
    p1_000(:,i) = filtfilt(B,A,p1_000(:,i));
    p2_000(:,i) = filtfilt(B,A,p2_000(:,i));
    p3_000(:,i) = filtfilt(B,A,p3_000(:,i));
    p4_000(:,i) = filtfilt(B,A,p4_000(:,i));
    p5_000(:,i) = filtfilt(B,A,p5_000(:,i));
    p6_000(:,i) = filtfilt(B,A,p6_000(:,i));
    p7_000(:,i) = filtfilt(B,A,p7_000(:,i));
    p8_000(:,i) = filtfilt(B,A,p8_000(:,i));
    p9_000(:,i) = filtfilt(B,A,p9_000(:,i));
    p10_000(:,i) = filtfilt(B,A,p10_000(:,i));
    p11_000(:,i) = filtfilt(B,A,p11_000(:,i));
    p12_000(:,i) = filtfilt(B,A,p12_000(:,i));
    p13_000(:,i) = filtfilt(B,A,p13_000(:,i));
    p14_000(:,i) = filtfilt(B,A,p14_000(:,i));
    p15_000(:,i) = filtfilt(B,A,p15_000(:,i));
    pBarra_der_000(:,i) = filtfilt(B,A,pBarra_der_000(:,i));
    pBarra_izq_000(:,i) = filtfilt(B,A,pBarra_izq_000(:,i));
end

% La frecuencia de 001 es la misma que tiene 000

for i=1:3               %help filtfilt
    p1_001(:,i) = filtfilt(B,A,p1_001(:,i));
    p2_001(:,i) = filtfilt(B,A,p2_001(:,i));
    p3_001(:,i) = filtfilt(B,A,p3_001(:,i));
    p4_001(:,i) = filtfilt(B,A,p4_001(:,i));
    p5_001(:,i) = filtfilt(B,A,p5_001(:,i));
    p6_001(:,i) = filtfilt(B,A,p6_001(:,i));
    p7_001(:,i) = filtfilt(B,A,p7_001(:,i));
    p8_001(:,i) = filtfilt(B,A,p8_001(:,i));
    p9_001(:,i) = filtfilt(B,A,p9_001(:,i));
    p10_001(:,i) = filtfilt(B,A,p10_001(:,i));
    p11_001(:,i) = filtfilt(B,A,p11_001(:,i));
    p12_001(:,i) = filtfilt(B,A,p12_001(:,i));
    p13_001(:,i) = filtfilt(B,A,p13_001(:,i));
    p14_001(:,i) = filtfilt(B,A,p14_001(:,i));
    p15_001(:,i) = filtfilt(B,A,p15_001(:,i));
    pBarra_der_001(:,i) = filtfilt(B,A,pBarra_der_001(:,i));
    pBarra_izq_001(:,i) = filtfilt(B,A,pBarra_izq_001(:,i));
end


%% VERSORES U, V y W

%% U V W DE CADERA
%-----------------------------------------------------------------------------------------000
%vdepelvis
Avp_000=p14_000-p7_000;
Bvp_000=Avp_000.^2;
normvp_000=sqrt(sum(Bvp_000,2));
vpelvis_000=Avp_000./normvp_000;

%wpelvis
Aw_000=p7_000-p15_000;
Bw_000=p14_000-p15_000;
Cw_000=cross(Aw_000,Bw_000);
normwp_000=sqrt(sum(Cw_000.^2,2));
wpelvis_000=Cw_000./normwp_000;

%upelvis
upelvis_000=cross(vpelvis_000,wpelvis_000);

%calculo de centros articulares
CA_cad_der_000=p15_000+0.598*A2*upelvis_000 - 0.344*A2*vpelvis_000 - 0.290*A2*wpelvis_000;
CA_cad_izq_000=p15_000+0.598*A2*upelvis_000 + 0.344*A2*vpelvis_000 - 0.290*A2*wpelvis_000;
%------------------------------------------------------------------------------------------001
%vdepelvis
Avp_001=p14_001-p7_001;
Bvp_001=Avp_001.^2;
normvp_001=sqrt(sum(Bvp_001,2));
vpelvis_001=Avp_001./normvp_001;

%wpelvis
Aw_001=p7_001-p15_001;
Bw_001=p14_001-p15_001;
Cw_001=cross(Aw_001,Bw_001);
normwp_001=sqrt(sum(Cw_001.^2,2));
wpelvis_001=Cw_001./normwp_001;

%upelvis
upelvis_001=cross(vpelvis_001,wpelvis_001);

%calculo de prhip y plhip (posición de los centros articulares de la
%cadera)
CA_cad_der_001=p15_001+0.598*A2*upelvis_001 - 0.344*A2*vpelvis_001 - 0.290*A2*wpelvis_001;
CA_cad_izq_001=p15_001+0.598*A2*upelvis_001 + 0.344*A2*vpelvis_001 - 0.290*A2*wpelvis_001;


%% U V y W DE RODILLAS 
%-----------------------------------------------------------------------------------000
%calculo de v de rodilla derecha
Avkr_000=p3_000-p5_000;%meleolo lateral derecho - epicondilo lateral derecho
Bvkr_000=Avkr_000.^2;
normvkr_000=sqrt(sum(Bvkr_000,2));
vrodilla_der_000=Avkr_000./normvkr_000;

%calculo de u de rodilla derecha
Aukr_000=p4_000-p5_000;%banda tibial derecha - epicondilo lateral derecho
Bukr_000=p3_000-p5_000;
Cukr_000=cross(Aukr_000,Bukr_000);
normukr_000=sqrt(sum(Cukr_000.^2,2));
urodilla_der_000=Cukr_000./normukr_000;

%calculo de w de rodilla derecha
wrodilla_der_000=cross(urodilla_der_000,vrodilla_der_000);

%calculo de v de rodilla izquierda
Avkl_000=p10_000-p12_000;%meleolo lateral izquierdo - epicondilo lateral izquierdo
Bvkl_000=Avkl_000.^2;
normvkl_000=sqrt(sum(Bvkl_000,2));
vrodilla_izq_000=Avkl_000./normvkl_000;

%calculo de u de rodilla izquierda
Aukl_000=p10_000-p12_000;%meleolo lateral izquierdo - epicondilo lateral izquierdo
Bukl_000=p11_000-p12_000;%banda tibial izquierda -  epicondilo lateral izquierdo
Cukl_000=cross(Aukl_000,Bukl_000);
normukl_000=sqrt(sum(Cukl_000.^2,2));
urodilla_izq_000=Cukl_000./normukl_000;

%calculo de w de rodilla izquierda
wrodilla_izq_000=cross(urodilla_izq_000,vrodilla_izq_000);

%calculo de centroa articulares
CA_rodilla_der_000=p5_000 + 0.000*A11*urodilla_der_000 + 0.000*A11*vrodilla_der_000 + 0.5*A11*wrodilla_der_000;
CA_rodilla_izq_000=p12_000 + 0.000*A11*urodilla_izq_000 + 0.000*A11*vrodilla_izq_000 - 0.5*A11*wrodilla_izq_000;

%----------------------------------------------------------------------------------------001
%calculo de v de rodilla derecha
Avkr_001=p3_001-p5_001;%meleolo lateral derecho - epicondilo lateral derecho
Bvkr_001=Avkr_001.^2;
normvkr_001=sqrt(sum(Bvkr_001,2));
vrodilla_der_001=Avkr_001./normvkr_001;

%calculo de u de rodilla derecha
Aukr_001=p4_001-p5_001;%banda tibial derecha - epicondilo lateral derecho
Bukr_001=p3_001-p5_001;
Cukr_001=cross(Aukr_001,Bukr_001);
normukr_001=sqrt(sum(Cukr_001.^2,2));
urodilla_der_001=Cukr_001./normukr_001;

%calculo de w de rodilla derecha
wrodilla_der_001=cross(urodilla_der_001,vrodilla_der_001);

%calculo de v de rodilla izquierda
Avkl_001=p10_001-p12_001;%meleolo lateral izquierdo - epicondilo lateral izquierdo
Bvkl_001=Avkl_001.^2;
normvkl_001=sqrt(sum(Bvkl_001,2));
vrodilla_izq_001=Avkl_001./normvkl_001;

%calculo de u de rodilla izquierda
Aukl_001=p10_001-p12_001;%meleolo lateral izquierdo - epicondilo lateral izquierdo
Bukl_001=p11_001-p12_001;%banda tibial izquierda -  epicondilo lateral izquierdo
Cukl_001=cross(Aukl_001,Bukl_001);
normukl_001=sqrt(sum(Cukl_001.^2,2));
urodilla_izq_001=Cukl_001./normukl_001;

%calculo de w de rodilla izquierda
wrodilla_izq_001=cross(urodilla_izq_001,vrodilla_izq_001);

%calculo de centroa articulares
CA_rodilla_der_001=p5_001 + 0.000*A11*urodilla_der_001 + 0.000*A11*vrodilla_der_001 + 0.5*A11*wrodilla_der_001;
CA_rodilla_izq_001=p12_001 + 0.000*A11*urodilla_izq_001 + 0.000*A11*vrodilla_izq_001 - 0.5*A11*wrodilla_izq_001;


%% U,V y W DE TOBILLOS
%----------------------------------------------------------000
%calculo de u de tobillo derecho
Auar_000=p1_000-p2_000; 
Buar_000=Auar_000.^2;
normBuar_000=sqrt(sum(Buar_000,2));
utobillo_der_000=Auar_000./normBuar_000;

%calculo de w de tobillo derecho
Awar_000=p1_000-p3_000;
Bwar_000=p2_000-p3_000;
Cwar_000=cross(Awar_000,Bwar_000);
normCwar_000=sqrt(sum(Cwar_000.^2,2));
wtobillo_der_000=Cwar_000./normCwar_000;

%calculo v de tobillo derecho
vtobillo_der_000=cross(wtobillo_der_000,utobillo_der_000);

%calculo de u de tobillo izquierdo
Aual_000=p8_000-p9_000;
Bual_000=Aual_000.^2;
normBual_000=sqrt(sum(Bual_000,2));
utobillo_izq_000=Aual_000./normBual_000;

%calculo w de tobillo izquierdo
Awal_000=p8_000-p10_000;
Bwal_000=p9_000-p10_000;
Cwal_000=cross(Awal_000,Bwal_000);
normCwal_000=sqrt(sum(Cwal_000.^2,2));
wtobillo_izq_000=Cwal_000./normCwal_000;

%calculo de v de tobillo izquierdo
vtobillo_izq_000=cross(wtobillo_izq_000,utobillo_izq_000);

%calculos de centros articulares
CA_tobillo_der_000=p3_000 + 0.016*A13*utobillo_der_000 + 0.392*A15*vtobillo_der_000 + 0.478*A17*wtobillo_der_000;
CA_tobillo_izq_000=p10_000 + 0.016*A14*utobillo_izq_000 + 0.392*A16*vtobillo_izq_000 - 0.478*A18*wtobillo_izq_000;

%calculos de las puntas de los pies
%ppie_der_000 = p3_000 +0.742*A13*utobillo_der_000 + 1.074*A15*vtobillo_der_000 - 0.187*A19*wtobillo_der_000;
%ppie_izq_000 = p10_000 +0.742*A13*utobillo_izq_000 + 1.074*A16*vtobillo_izq_000 + 0.187*A20*wtobillo_izq_000;

%---------------------------------------------------------------001
%calculo de u de tobillo derecho
Auar_001=p1_001-p2_001; 
Buar_001=Auar_001.^2;
normBuar_001=sqrt(sum(Buar_001,2));
utobillo_der_001=Auar_001./normBuar_001;

%calculo de w de tobillo derecho
Awar_001=p1_001-p3_001;
Bwar_001=p2_001-p3_001;
Cwar_001=cross(Awar_001,Bwar_001);
normCwar_001=sqrt(sum(Cwar_001.^2,2));
wtobillo_der_001=Cwar_001./normCwar_001;

%calculo v de tobillo derecho
vtobillo_der_001=cross(wtobillo_der_001,utobillo_der_001);

%calculo de u de tobillo izquierdo
Aual_001=p8_001-p9_001;
Bual_001=Aual_001.^2;
normBual_001=sqrt(sum(Bual_001,2));
utobillo_izq_001=Aual_001./normBual_001;

%calculo w de tobillo izquierdo
Awal_001=p8_001-p10_001;
Bwal_001=p9_001-p10_001;
Cwal_001=cross(Awal_001,Bwal_001);
normCwal_001=sqrt(sum(Cwal_001.^2,2));
wtobillo_izq_001=Cwal_001./normCwal_001;

%calculo de v de tobillo izquierdo
vtobillo_izq_001=cross(wtobillo_izq_001,utobillo_izq_001);

%calculos de centros articulares
CA_tobillo_der_001=p3_001 + 0.016*A13*utobillo_der_001 + 0.392*A15*vtobillo_der_001 + 0.478*A17*wtobillo_der_001;
CA_tobillo_izq_001=p10_001 + 0.016*A14*utobillo_izq_001 + 0.392*A16*vtobillo_izq_001 - 0.478*A18*wtobillo_izq_001;

%calculos de las puntas de los pies
%ppie_der_001 = p3_001 +0.742*A13*utobillo_der_001 + 1.074*A15*vtobillo_der_001 - 0.187*A19*wtobillo_der_001;
%ppie_izq_001 = p10_001 +0.742*A13*utobillo_izq_001 + 1.074*A16*vtobillo_izq_001 + 0.187*A20*wtobillo_izq_001;

%% Grafica de marcadores, centros articulares y u, v y w

figure;
plot3(p15_000(inicio1_000:fin1_000,1),p15_000(inicio1_000:fin1_000,2),p15_000(inicio1_000:fin1_000,3),'k','LineWidth',2); %marcador de sacro
hold on;
plot3(p7_000(inicio1_000:fin1_000,1),p7_000(inicio1_000:fin1_000,2),p7_000(inicio1_000:fin1_000,3),'r','LineWidth',2); %marcador de ASIS derecho
hold on;
plot3(p14_000(inicio1_000:fin1_000,1),p14_000(inicio1_000:fin1_000,2),p14_000(inicio1_000:fin1_000,3),'b','LineWidth',2); %marcador de ASIS izquierdo
hold on;
plot3(CA_cad_der_000(inicio1_000:fin1_000,1),CA_cad_der_000(inicio1_000:fin1_000,2),CA_cad_der_000(inicio1_000:fin1_000,3),'r--','LineWidth',2);% centro articular derecho de la cadera
hold on;
plot3(CA_cad_izq_000(inicio1_000:fin1_000,1),CA_cad_izq_000(inicio1_000:fin1_000,2),CA_cad_izq_000(inicio1_000:fin1_000,3),'b--','LineWidth',2);% centro articular izquierdo de la cadera
hold on;

for i=inicio1_000:40:fin1_000
    quiver3(p15_000(i,1),p15_000(i,2),p15_000(i,3),upelvis_000(i,1)./10,upelvis_000(i,2)./10,upelvis_000(i,3)./10,'r'); %versor u de pelvis
    hold on;
    quiver3(p15_000(i,1),p15_000(i,2),p15_000(i,3),vpelvis_000(i,1)./10,vpelvis_000(i,2)./10,vpelvis_000(i,3)./10,'g'); %versor v de pelvis
    hold on;
    quiver3(p15_000(i,1),p15_000(i,2),p15_000(i,3),wpelvis_000(i,1)./10,wpelvis_000(i,2)./10,wpelvis_000(i,3)./10,'b'); %versor w de pelvis
    hold on;
end

plot3(p5_000(inicio1_000:fin1_000,1),p5_000(inicio1_000:fin1_000,2),p5_000(inicio1_000:fin1_000,3),'r','LineWidth',2); %marcador de rodilla der (epicondilo)
hold on;
plot3(p3_000(inicio1_000:fin1_000,1),p3_000(inicio1_000:fin1_000,2),p3_000(inicio1_000:fin1_000,3),'k','LineWidth',2); %marcador del maleolo lateral derecho
hold on;
plot3(CA_rodilla_der_000(inicio1_000:fin1_000,1),CA_rodilla_der_000(inicio1_000:fin1_000,2),CA_rodilla_der_000(inicio1_000:fin1_000,3),'k--','LineWidth',2);% centro articular de la rodilla derecha
hold on;
plot3(p12_000(inicio1_000:fin1_000,1),p12_000(inicio1_000:fin1_000,2),p12_000(inicio1_000:fin1_000,3),'r','LineWidth',2); %marcador de rodilla izq (epicondilo)
hold on;
plot3(p10_000(inicio1_000:fin1_000,1),p10_000(inicio1_000:fin1_000,2),p10_000(inicio1_000:fin1_000,3),'k','LineWidth',2); %marcador del maleolo lateral izq
hold on;
plot3(CA_rodilla_izq_000(inicio1_000:fin1_000,1),CA_rodilla_izq_000(inicio1_000:fin1_000,2),CA_rodilla_izq_000(inicio1_000:fin1_000,3),'k--','LineWidth',2);% centro articular de la rodilla izq
hold on;

for i=inicio1_000:40:fin1_000
    quiver3(p5_000(i,1),p5_000(i,2),p5_000(i,3),urodilla_der_000(i,1)./10,urodilla_der_000(i,2)./10,urodilla_der_000(i,3)./10,'r'); %versor u de rodilla der
    hold on;
    quiver3(p5_000(i,1),p5_000(i,2),p5_000(i,3),vrodilla_der_000(i,1)./10,vrodilla_der_000(i,2)./10,vrodilla_der_000(i,3)./10,'g'); %versor v de rodilla der
    hold on;
    quiver3(p5_000(i,1),p5_000(i,2),p5_000(i,3),wrodilla_der_000(i,1)./10,wrodilla_der_000(i,2)./10,wrodilla_der_000(i,3)./10,'b'); %versor w de rodilla der
    hold on;
    quiver3(p12_000(i,1),p12_000(i,2),p12_000(i,3),urodilla_izq_000(i,1)./10,urodilla_izq_000(i,2)./10,urodilla_izq_000(i,3)./10,'r'); %versor u de rodilla izq
    hold on;
    quiver3(p12_000(i,1),p12_000(i,2),p12_000(i,3),vrodilla_izq_000(i,1)./10,vrodilla_izq_000(i,2)./10,vrodilla_izq_000(i,3)./10,'g'); %versor v de rodilla izq
    hold on;
    quiver3(p12_000(i,1),p12_000(i,2),p12_000(i,3),wrodilla_izq_000(i,1)./10,wrodilla_izq_000(i,2)./10,wrodilla_izq_000(i,3)./10,'b'); %versor w de rodilla izq
    hold on;
end

plot3(p3_000(inicio1_000:fin1_000,1),p3_000(inicio1_000:fin1_000,2),p3_000(inicio1_000:fin1_000,3),'k','LineWidth',2); %marcador de meleolo derecho
hold on;
plot3(p2_000(inicio1_000:fin1_000,1),p2_000(inicio1_000:fin1_000,2),p2_000(inicio1_000:fin1_000,3),'r','LineWidth',2); %marcador de talon derecho
hold on;
plot3(CA_tobillo_der_000(inicio1_000:fin1_000,1),CA_tobillo_der_000(inicio1_000:fin1_000,2),CA_tobillo_der_000(inicio1_000:fin1_000,3),'k--','LineWidth',2); %centro articular pie derecho
hold on;
plot3(p10_000(inicio1_000:fin1_000,1),p10_000(inicio1_000:fin1_000,2),p10_000(inicio1_000:fin1_000,3),'k','LineWidth',2); %marcador de meleolo izquierdo
hold on;
plot3(p9_000(inicio1_000:fin1_000,1),p9_000(inicio1_000:fin1_000,2),p9_000(inicio1_000:fin1_000,3),'r','LineWidth',2); %marcador de talon izquierdo
hold on;
plot3(CA_tobillo_izq_000(inicio1_000:fin1_000,1),CA_tobillo_izq_000(inicio1_000:fin1_000,2),CA_tobillo_izq_000(inicio1_000:fin1_000,3),'k--','LineWidth',2); %centro articular pie izquierdo
hold on;
%plot3(ppie_der_000(inicio1_000:fin1_000,1),ppie_der_000(inicio1_000:fin1_000,2),ppie_der_000(inicio1_000:fin1_000,3),'m--','LineWidth',2); %punta de pie derecho
%hold on;
%plot3(ppie_izq_000(inicio1_000:fin1_000,1),ppie_izq_000(inicio1_000:fin1_000,2),ppie_izq_000(inicio1_000:fin1_000,3),'m--','LineWidth',2); %punta de pie izquierdo
%hold on;

for i=inicio1_000:40:fin1_000
    quiver3(p3_000(i,1),p3_000(i,2),p3_000(i,3),utobillo_der_000(i,1)./10,utobillo_der_000(i,2)./10,utobillo_der_000(i,3)./10,'r'); %versor u de tobillo der
    hold on;
    quiver3(p3_000(i,1),p3_000(i,2),p3_000(i,3),vtobillo_der_000(i,1)./10,vtobillo_der_000(i,2)./10,vtobillo_der_000(i,3)./10,'g'); %versor v de tobillo der
    hold on;
    quiver3(p3_000(i,1),p3_000(i,2),p3_000(i,3),wtobillo_der_000(i,1)./10,wtobillo_der_000(i,2)./10,wtobillo_der_000(i,3)./10,'b'); %versor w de tobillo der
    hold on;
    quiver3(p10_000(i,1),p10_000(i,2),p10_000(i,3),utobillo_izq_000(i,1)./10,utobillo_izq_000(i,2)./10,utobillo_izq_000(i,3)./10,'r'); %versor u de tobillo izq
    hold on;
    quiver3(p10_000(i,1),p10_000(i,2),p10_000(i,3),vtobillo_izq_000(i,1)./10,vtobillo_izq_000(i,2)./10,vtobillo_izq_000(i,3)./10,'g'); %versor v de tobillo izq
    hold on;
    quiver3(p10_000(i,1),p10_000(i,2),p10_000(i,3),wtobillo_izq_000(i,1)./10,wtobillo_izq_000(i,2)./10,wtobillo_izq_000(i,3)./10,'b'); %versor w de tobillo izq
    hold on;
end

legend('Marcador del sacro','Marcador del ASIS derecho','Marcador de ASIS izquierdo','Posicion del centro articular der','Posicion del centro articular izq','u de pelvis','v de pelvis','w pelvis','Marcador epicondilo der','Marcador del maleolo lateral der','Centro articular de la rodilla der','Marcador epicondilo izq','Marcador del maleolo lateral izq','Centro articular de la rodilla izq','u de rodilla derecha','v de rodilla derecha','w de rodilla derecha','u de rodilla izquierda','v de rodilla izquierda','w de rodilla izquierda','Marcador meleolo der','Marcador del talon der','Centro articular del pie der','Marcador maleolo izq','Marcador del talon izq','Centro articular del pie izq','u de tobillo derecho','v de tobillo derecho','w de tobillo derecho','u de tobillo izquierdo','v de tobillo izquierdo','w de tobillo izquierdo');
xlabel('Eje x');
ylabel('Eje y');
zlabel('Eje z');
title('Trayectoria de marcadores y diagrama de u, v y w');
grid on;