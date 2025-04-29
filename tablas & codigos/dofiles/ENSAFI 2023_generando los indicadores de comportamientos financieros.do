****TRABAJANDO CON LA ENSAFI 2023

****PROGRAMA PARA GENERAR LOS INDICADORES DE COMPORTAMIENTOS FINANCIEROS
cd "C:/SEM 8/Bloque dos & materias final/Proyecto BeWay/tablas & codigos/dtas"
use "BASE_ENSAFI.dta"

preserve
*preparar los datos para cruzar con los comportamientos financieros
rename *, lower

//renombrando variables
rename p5_7 tiene_hijos
rename p5_21 gasto_mensual
rename ingreso_m ingreso_mensual
rename p6_8 deuda_percepcion //esta es la variable que usaremos para el proxy
gen pob_objetivo = cond(inlist(deuda_percepcion, 1, 2), 1, 0)



*******************************************************
*****COMPORTAMIENTOS FINANCIEROS
*******************************************************
/*¿Qué son los sesgos cognitivos y cómo influyen en la toma de decisiones financiera
 
Las emociones y la intuición son fundamentales en el proceso de toma de decisiones financieras.

Relación entre Psicología y economía 1970's→ Daniel Kahneman (Premio Nobel de Economía 2002) y Amos Tversky estudiaron la toma de decisiones bajo incertidumbre y los factores que subyacen a las decisiones financieras.

La comprensión del comportamiento financiero → las decisiones económicas no siempre son racionales, están influidas por factores emocionales y psicológicos. 

Los sesgos cognitivos son "errores sistemáticos" que afectan el pensamiento de las personas en determinadas situaciones y las llevan a interpretar erróneamente la información y a tomar decisiones financieras equivocadas, llevándolas a tomar decisiones irracionales que pueden perjudicar su salud financiera y estabilidad económica.

*Preguntas de los rasgos de la personalidad

**====Confianza financiera
p7_9_1 Vea la Tarjeta 6. Dígame, ¿qué tanto confía en su habilidad para administrar su dinero día con día?
1. Mucho
2. Algo
3. Poco
4. Nada
p7_9_2 Vea la Tarjeta 6. Dígame, ¿qué tanto confía en su habilidad para planificar su futuro financiero?
1. Mucho
2. Algo
3. Poco
4. Nada
p7_9_3 Vea la Tarjeta 6. Dígame, ¿qué tanto confía en su habilidad para tomar decisiones sobre productos de bancos o instituciones financieras?
1. Mucho
2. Algo
3. Poco
4. Nada

**====Grado de control
p7_10_1 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Puede controlar bastante bien lo que sucede en su vida
1. Mucho
2. Algo
3. Poco
4. Nada
p7_10_2 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Cuando hace planes, hace todo lo posible para tener éxito
1. Mucho
2. Algo
3. Poco
4. Nada

**====Orientación hacia el futuro
p7_10_3 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Vive más para el hoy que para el mañana
1. Mucho
2. Algo
3. Poco
4. Nada
p7_10_4 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Su futuro se arreglará solo
1. Mucho
2. Algo
3. Poco
4. Nada

**====Impulsividad
p7_10_5 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Con frecuencia hace cosas sin pensarlas mucho
1. Mucho
2. Algo
3. Poco
4. Nada
p7_10_6 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Se deja llevar por sus emociones
1. Mucho
2. Algo
3. Poco
4. Nada

**====Orientación hacia la acción
p7_10_7 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Cuando tiene que tomar una decisión difícil, tiende a dejarla para otro día
1. Mucho
2. Algo
3. Poco
4. Nada
p7_10_8 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Le cuesta dejar sus malos hábitos (llegar tarde, tomar, fumar, comer poco saludable)
1. Mucho
2. Algo
3. Poco
4. Nada

**====Optimismo
p7_10_9 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Cree que conseguirá las principales metas de su vida
1. Mucho
2. Algo
3. Poco
4. Nada
p7_10_10 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Le ocurren más cosas buenas que malas
1. Mucho
2. Algo
3. Poco
4. Nada
p7_10_11 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Tiene confianza en superar sus problemas
1. Mucho
2. Algo
3. Poco
4. Nada
p7_10_12 Vea la Tarjeta 6. ¿Qué tan de acuerdo está con las siguientes afirmaciones? Piensa que todo saldrá mal
1. Mucho
2. Algo
3. Poco
4. Nada

**====Gastos Versus ahorro
p7_11_1 Vea la Tarjeta 4. Le voy a leer algunas preguntas. ¿Con qué frecuencia prefiere comprar a crédito que comprar de contado?
1. Siempre
2. Casi siempre
3. A veces
4. Casi nunca
5. Nunca
p7_11_2 Vea la Tarjeta 4. Le voy a leer algunas preguntas. ¿Con qué frecuencia prefiere gastar el dinero que tiene, que ahorrarlo para gastos inesperados?
1. Siempre
2. Casi siempre
3. A veces
4. Casi nunca
5. Nunca
p7_11_3 Vea la Tarjeta 4. Le voy a leer algunas preguntas. ¿Con qué frecuencia le parece más satisfactorio gastar que ahorrar el dinero?
1. Siempre
2. Casi siempre
3. A veces
4. Casi nunca
5. Nunca
p7_11_4 Vea la Tarjeta 4. Le voy a leer algunas preguntas. ¿Con qué frecuencia usted decide comprar más que ahorrar?
1. Siempre
2. Casi siempre
3. A veces
4. Casi nunca
5. Nunca */



**====Confianza financiera
tab p7_9_1 [w=fac_ele]
gen p7_9_1b=p7_9_1
*recodificando la variable
recode p7_9_1b (1=3) (2=2) (3=1) (4=0)

tab p7_9_2 [w=fac_ele]
gen p7_9_2b=p7_9_2
*recodificando la variable
recode p7_9_2b (1=3) (2=2) (3=1) (4=0)

tab p7_9_3 [w=fac_ele]
gen p7_9_3b=p7_9_3
*recodificando la variable
recode p7_9_3b (1=3) (2=2) (3=1) (4=0)

**====generando la variable confianza financiera
egen sum_confianza = rowtotal(p7_9_1b p7_9_2b p7_9_3b)
*Si confianza financiera está entre 0-4 Poco característico 5-9 Muy característico
gen confianza_fin=1 if sum_confianza<5
replace  confianza_fin=2 if sum_confianza>=5 & sum_confianza<=9
*label asigna los nombres a las categorías de las variables creadas
label define confianza_fin_n 1 "Poco característico" 2 "Muy característico" 
label values confianza_fin confianza_fin_n
tab sexo confianza_fin [w=fac_ele], ro
tab sexo confianza_fin [w=fac_ele], co


**====Grado de control
tab p7_10_01 [w=fac_ele]
gen p7_10_01b=p7_10_01
*recodificando la variable
recode p7_10_01b (1=3) (2=2) (3=1) (4=0)

tab p7_10_02 [w=fac_ele]
gen p7_10_02b=p7_10_02
*recodificando la variable
recode p7_10_02b (1=3) (2=2) (3=1) (4=0)

**====generando la variable Grado de control
egen sum_gdo_control = rowtotal(p7_10_01b p7_10_02b)
*Si grado de control está entre 0-3 Poco característico 4-6 Muy característico
gen gdo_control=1 if sum_gdo_control<3
replace  gdo_control=2 if sum_gdo_control>=4 & sum_gdo_control<=6
*label asigna los nombres a las categorías de las variables creadas
label define gdo_control_n 1 "Poco característico" 2 "Muy característico" 
label values gdo_control gdo_control_n
tab sexo gdo_control [w=fac_ele], ro
tab sexo gdo_control [w=fac_ele], co

**====Orientación hacia el futuro
tab p7_10_03 [w=fac_ele]
gen p7_10_03b=p7_10_03
*recodificando la variable
recode p7_10_03b (1=3) (2=2) (3=1) (4=0)

tab p7_10_04 [w=fac_ele]
gen p7_10_04b=p7_10_04
*recodificando la variable
recode p7_10_04b (1=3) (2=2) (3=1) (4=0)

**====generando la variable Orientación hacia el futuro
egen sum_or_futuro = rowtotal(p7_10_03b p7_10_04b)
*Si orientación hacia el futuro está entre 0-3 Poco característico 4-6 Muy característico
gen or_futuro=1 if sum_or_futuro<3
replace  or_futuro=2 if sum_or_futuro>=4 & sum_or_futuro<=6
*label asigna los nombres a las categorías de las variables creadas
label define or_futuro_n 1 "Poco característico" 2 "Muy característico" 
label values or_futuro or_futuro_n
tab sexo or_futuro [w=fac_ele], ro
tab sexo or_futuro [w=fac_ele], co

**====Impulsividad
tab p7_10_05 [w=fac_ele]
gen p7_10_05b=p7_10_05
*recodificando la variable
recode p7_10_05b (1=3) (2=2) (3=1) (4=0)

tab p7_10_06 [w=fac_ele]
gen p7_10_06b=p7_10_06
*recodificando la variable
recode p7_10_06b (1=3) (2=2) (3=1) (4=0)

**====generando la variable Impulsividad
egen sum_impulsiv = rowtotal(p7_10_05b p7_10_06b)
*Si impulsividad está entre 0-3 Poco característico 4-6 Muy característico
gen impulsiv=1 if sum_impulsiv<3
replace  impulsiv=2 if sum_impulsiv>=4 & sum_impulsiv<=6
*label asigna los nombres a las categorías de las variables creadas
label define impulsiv_n 1 "Poco característico" 2 "Muy característico" 
label values impulsiv impulsiv_n
tab sexo impulsiv [w=fac_ele], ro
tab sexo impulsiv [w=fac_ele], co

**====Orientación hacia la acción
tab p7_10_07 [w=fac_ele]
gen p7_10_07b=p7_10_07
*recodificando la variable
recode p7_10_07b (1=3) (2=2) (3=1) (4=0)

tab p7_10_08 [w=fac_ele]
gen p7_10_08b=p7_10_08
*recodificando la variable
recode p7_10_08b (1=3) (2=2) (3=1) (4=0)

**====Orientación hacia la acción
egen sum_or_accion = rowtotal(p7_10_07b p7_10_08b)
*Si Orientación hacia la acción está entre 0-3 Poco característico 4-6 Muy característico
gen or_accion=1 if sum_or_accion<3
replace  or_accion=2 if sum_or_accion>=4 & sum_or_accion<=6
*label asigna los nombres a las categorías de las variables creadas
label define or_accion_n 1 "Poco característico" 2 "Muy característico" 
label values or_accion or_accion_n
tab sexo or_accion [w=fac_ele], ro
tab sexo or_accion [w=fac_ele], co

**====Optimismo
tab p7_10_09 [w=fac_ele]
gen p7_10_09b=p7_10_09
*recodificando la variable
recode p7_10_09b (1=3) (2=2) (3=1) (4=0)

tab p7_10_10 [w=fac_ele]
gen p7_10_10b=p7_10_10
*recodificando la variable
recode p7_10_10b (1=3) (2=2) (3=1) (4=0)

tab p7_10_11 [w=fac_ele]
gen p7_10_11b=p7_10_11
*recodificando la variable
recode p7_10_11b (1=3) (2=2) (3=1) (4=0)

tab p7_10_12 [w=fac_ele]
gen p7_10_12b=p7_10_12
*recodificando la variable
recode p7_10_12b (1=0) (2=1) (3=2) (4=3)

**====Optimismo
egen sum_optim = rowtotal(p7_10_09b p7_10_10b p7_10_11b p7_10_12b)
*Si Optimismo está entre 0-8 Poco característico 9-16 Muy característico
gen optim=1 if sum_optim<8
replace  optim=2 if sum_optim>=9 & sum_optim<=16
*label asigna los nombres a las categorías de las variables creadas
label define optim_n 1 "Poco característico" 2 "Muy característico" 
label values optim optim_n
tab sexo optim [w=fac_ele], ro
tab sexo optim [w=fac_ele], co

**====Gasto versus ahorro 
tab p7_11_1 [w=fac_ele]
gen p7_11_1b=p7_11_1
*recodificando la variable
recode p7_11_1b (1=4) (2=3) (3=2) (4=1) (5=0)

tab p7_11_2 [w=fac_ele]
gen p7_11_2b=p7_11_2
*recodificando la variable
recode p7_11_2b (1=4) (2=3) (3=2) (4=1) (5=0)

tab p7_11_3 [w=fac_ele]
gen p7_11_3b=p7_11_3
*recodificando la variable
recode p7_11_3b (1=4) (2=3) (3=2) (4=1) (5=0)

tab p7_11_4 [w=fac_ele]
gen p7_11_4b=p7_11_4
*recodificando la variable
recode p7_11_4b (1=4) (2=3) (3=2) (4=1) (5=0)

**====Gasto versus ahorro 
egen sum_gasto_ahor = rowtotal(p7_11_1b p7_11_2b p7_11_3b p7_11_4b)
*Si Gasto versus ahorro está entre 0-8 Poco característico 9-16 Muy característico
gen gasto_ahor=1 if sum_gasto_ahor<8
replace  gasto_ahor=2 if sum_gasto_ahor>=9 & sum_gasto_ahor<=16
*label asigna los nombres a las categorías de las variables creadas
label define gasto_ahor_n 1 "Poco característico" 2 "Muy característico" 
label values gasto_ahor gasto_ahor_n
tab sexo gasto_ahor [w=fac_ele], ro
tab sexo gasto_ahor [w=fac_ele], co


keep gasto_mensual ingreso_mensual pob_objetivo deuda_percepcion sexo fac_ele edad confianza_fin gdo_control or_futuro impulsiv or_accion optim 

*save "comportamientos.dta"
restore


**////////////////////////////////////////////////////////////////////////

use comportamientos, clear

* Gráfica de comportamientos financieros según condición de sobredeuda (pob_objetivo)
preserve

* Guardar copia temporal del archivo para trabajar dentro del loop
tempfile base
save `base'

rename confianza_fin confianza
rename gdo_control control
rename or_futuro futuro
rename impulsiv impulsividad
rename or_accion accion
rename optim optimismo

* Variables de interés
local vars confianza control futuro impulsividad accion optimismo

* Crear copia del archivo original para no usar preserve dentro del bucle
tempfile base
save `base', replace

* Crear archivo para resultados
tempfile resultados

* Contador para controlar primer guardado sin append
local i = 1

foreach var of local vars {
    
    use `base', clear

    keep pob_objetivo `var'
    gen es_2 = (`var' == 2)
	collapse (mean) prop=es_2, by(pob_objetivo)
	replace prop = prop * 100
    gen variable = "`var'"

    if `i' == 1 {
        save `resultados', replace
    }
    else {
        append using `resultados'
        save `resultados', replace
    }

    local ++i
}


* Abrir el dataset final con proporciones
use `resultados', clear

* Etiquetas
label define pob_lbl 0 "NS" 1 "S"
label values pob_objetivo pob_lbl

* Graficar barras
graph bar (mean) prop, over(pob_objetivo, gap(10) label(angle(45))) ///
    over(variable, gap(30) label(angle(45))) ///
    blabel(bar, format(%5.2f) color(black)) ///
    bar(1, color(navy)) bar(2, color(maroon)) ///
    ytitle("Porcentaje (%)") ///
    title("Autopercepciones por condición de sobreendeudamiento") ///
    ylabel(none) ///
    legend(off)


restore

 ///////////////////////////////////////////////////////////////////
 
*sobreendeudados, clasificados por edad y ver autopercepciones
preserve

* Filtrar a sobreendeudados mayores de 18
keep if pob_objetivo == 1 & edad > 18

* Renombrar variables para visualización
rename confianza_fin confianza
rename gdo_control control
rename or_futuro futuro
rename impulsiv impulsividad
rename or_accion accion
rename optim optimismo

* Crear grupos de edad
gen grupo_edad = .
replace grupo_edad = 1 if edad <= 29
replace grupo_edad = 2 if edad >= 30 & edad <= 44
replace grupo_edad = 3 if edad >= 45 & edad <= 59
replace grupo_edad = 4 if edad >= 60

label define grupo_lbl 1 "18–29" 2 "30–44" 3 "45–59" 4 "60+"
label values grupo_edad grupo_lbl

* Guardar base
tempfile base
save `base', replace

* Variables
local vars confianza control futuro impulsividad accion optimismo

* Dataset de resultados
tempfile resultados
local i = 1

foreach var of local vars {
    use `base', clear

    keep grupo_edad `var'
    gen es_2 = (`var' == 2)
    collapse (mean) prop=es_2, by(grupo_edad)
    replace prop = prop * 100
    gen variable = "`var'"

    if `i' == 1 {
        save `resultados', replace
    }
    else {
        append using `resultados'
        save `resultados', replace
    }

    local ++i
}

* Preparar datos para gráfico por grupo
use `resultados', clear
label values grupo_edad grupo_lbl

* Convertir a formato ancho para usar group()
reshape wide prop, i(variable) j(grupo_edad)

* Graficar con colores por grupo usando group()
graph bar prop1 prop2 prop3 prop4, over(variable, gap(30) label(angle(45))) ///
    blabel(bar, format(%4.2f) color(black)) ///
    bar(1, color(navy)) ///
    bar(2, color(teal)) ///
    bar(3, color(orange)) ///
    bar(4, color(brick)) ///
    ytitle("Porcentaje (%)") ///
    title("Proporción == 2 por variable y grupo de edad (pob. objetivo)") ///
    legend(order(1 "18–29" 2 "30–44" 3 "45–59" 4 "60+") ring(0) pos(6)) ///
    ylabel(none) ///
    bargap(15)

restore
