// Caracterización de la población objetivo con base en percepción de endeudamiento
**** UTILIZANDO ENSAFI 2023
cd "C:/SEM 8/Bloque dos & materias final/Proyecto BeWay/tablas & codigos/dtas"

clear
set more off

use "BASE_ENSAFI.dta", clear
rename *, lower

//renombrando variables
rename p5_7 tiene_hijos
rename p5_21 gasto_mensual
rename ingreso_m ingreso_mensual
rename p6_8 deuda_percepcion //esta es la variable que usaremos para el proxy
gen pob_objetivo = cond(inlist(deuda_percepcion, 1, 2), 1, 0)


// -------------------------------
// ETAPA 1: Preparar datos base
// -------------------------------
preserve

/* deuda_percepcion = tomando en cuenta todas sus deudas ¿considera que lo que debe es: 
1 excesivo? >80%
2 alto? 60& - 80%
3 moderado? 35% - 60%
4 bajo? <35%
5 no tiene deudas
9 no sabe
b blanco por consecuencia

*/

//VARIABLE OBJETIVO DE IDENTIFICACIÓN

gen deudamax_men=p6_13
recode deudamax_men 999888=. 999999=.

// Reemplazar valores para crear variables binarias
replace tiene_hijos = 0 if tiene_hijos != 1
replace sexo = 0 if sexo != 1 // 1 = hombres, 0 = mujeres

// Conservar solo las variables necesarias
keep sexo edad tiene_hijos gasto_mensual ingreso_mensual fac_ele deudamax_men deuda_percepcion pob_objetivo


//Generamos los gráficos de identificación

//GRUPOS ETAREOS
// Filtrar personas mayores de 18 años
keep if edad > 18

// Crear sextiles de edad
xtile grupo_edad = edad, n(6)

// Rango de edad de cada grupo
gen edad_min = .
gen edad_max = .
bysort grupo_edad (edad): replace edad_min = edad[1]
bysort grupo_edad (edad): replace edad_max = edad[_N]

// Crear etiquetas de edad
gen etiqueta_edad = string(edad_min) + "-" + string(edad_max)

// Crear variable dummy para conteo
gen uno = 1

// Guardar datos originales antes de colapsar
tempfile base
save `base'

// Obtener totales por grupo de edad y sexo
collapse (count) total = uno, by(grupo_edad etiqueta_edad sexo)
tempfile totales
save `totales'

// Restaurar base para obtener sobreendeudados
use `base', clear
keep if pob_objetivo == 1
collapse (count) sobreendeudados = uno, by(grupo_edad etiqueta_edad sexo)

// Unir con totales
merge 1:1 grupo_edad etiqueta_edad sexo using `totales', nogen

// Reemplazar missing con 0 (por si algún grupo no tiene sobreendeudados)
replace sobreendeudados = 0 if missing(sobreendeudados)

// Calcular proporción
gen prop = (sobreendeudados / total) * 100
gen etiqueta = string(prop, "%4.2f") + "%"
label var prop "Porcentaje de personas sobreendeudadas"

// Etiquetas para sexo
label define sexo_lbl 1 "H" 2 "M"
label values sexo sexo_lbl

// Graficar
graph bar (asis) prop, over(sexo) over(etiqueta_edad, label(angle(45))) ///
    bar(1, color("orange*0.8")) bar(2, color("navy")) ///
    legend(order(1 "Hombres" 2 "Mujeres") size(small)) ///
    ytitle("Porcentaje de personas sobreendeudadas", size(medsmall)) ///
    ylabel(0(10)100, format(%4.0f) angle(horizontal)) ///
    blabel(bar, position(outside) gap(2) size(small)) ///
    title("Personas sobreendeudadas por grupo etario y sexo", size(medlarge)) ///
    graphregion(color(white)) bgcolor(white)



*------------------------------------------------------------
* Paso 1: Preparar datos
*------------------------------------------------------------
preserve

* Mantener solo variables necesarias
keep ingreso_mensual sexo pob_objetivo fac_ele

* Asegurar codificación de sexo (1 = Hombres, 2 = Mujeres)
replace sexo = 1 if sexo == 1
replace sexo = 2 if sexo != 1

* Eliminar missings y ceros en ingreso
drop if missing(ingreso_mensual) | ingreso_mensual <= 0

* Expandir por factor de expansión si es necesario
expand fac_ele

*------------------------------------------------------------
* Paso 2: Crear quintiles
*------------------------------------------------------------
xtile quintil = ingreso_mensual, n(5)

* Etiquetas de quintil (Q1, Q2, ...)
gen etiqueta_quintil = "Q" + string(quintil)

* Crear dummy para contar
gen uno = 1

*------------------------------------------------------------
* Paso 3: Calcular totales por quintil y sexo
*------------------------------------------------------------
tempfile base
save `base'

collapse (count) total = uno, by(quintil etiqueta_quintil sexo)
tempfile totales
save `totales'

*------------------------------------------------------------
* Paso 4: Calcular número de personas con pob_objetivo == 1
*------------------------------------------------------------
use `base', clear
keep if pob_objetivo == 1
collapse (count) objetivo = uno, by(quintil etiqueta_quintil sexo)

*------------------------------------------------------------
* Paso 5: Unir datos y calcular proporción
*------------------------------------------------------------
merge 1:1 quintil etiqueta_quintil sexo using `totales', nogen
replace objetivo = 0 if missing(objetivo)

gen prop = 100 * objetivo / total
label var prop "Porcentaje con pob_objetivo == 1"

*------------------------------------------------------------
* Paso 6: Etiquetas para sexo
*------------------------------------------------------------
label define sexo_lbl 1 "Hombres" 2 "Mujeres"
label values sexo sexo_lbl

*------------------------------------------------------------
* Paso 7: Graficar
*------------------------------------------------------------
graph bar (asis) prop, over(sexo) over(etiqueta_quintil, label(angle(0))) ///
    bar(1, color("orange*0.8")) bar(2, color("navy")) ///
    legend(order(1 "Hombres" 2 "Mujeres") size(small)) ///
    ytitle("Porcentaje de población objetivo", size(medsmall)) ///
    ylabel(0(5)30, format(%4.0f) angle(horizontal)) ///
    yscale(range(0 30)) ///
    blabel(bar, position(outside) size(small)) ///
    title("Población objetivo por quintil socioeconómico y sexo", size(medlarge)) ///
    graphregion(color(white)) bgcolor(white)

* Restaurar si lo deseas
restore




//-------------------------------------------------------------
// ANALIZAMOS LA VARIABLE SQUEEZE POR POBLACION SOBREENDEUDADA
//-------------------------------------------------------------


rename p6_13 nivel_deuda //nivel maximo de deuda posible
preserve

keep ingreso_mensual gasto_mensual pob_objetivo deuda_percepcion nivel_deuda 
keep if ingreso_mensual >= 0 & gasto_mensual >=0

//creamos el cociente de gasto sobre ingreso_m
gen gasto_ingreso = gasto_mensual/ingreso_mensual

//generamos el cociente de maxima deuda sobre ingreso_m
gen deudamax_ingreso = nivel_deuda/ingreso_mensual


//generamos la variable de squeeze
gen squeeze = deudamax_ingreso/gasto_ingreso
count if !missing(squeeze)

* Etiquetas para población objetivo
label define pob_lbl 0 "No sobreendeudado" 1 "sobreendeudado"
label values pob_objetivo pob_lbl

* Boxplot
twoway ///
    (kdensity squeeze if pob_objetivo == 0, lcolor(navy) lwidth(medthick)) ///
    (kdensity squeeze if pob_objetivo == 1, lcolor(orange) lpattern(dash)), ///
    legend(order(1 "No sobreendeudado" 2 "Sobreendeudado")) ///
    title("Distribución de squeeze por sobreendeudamiento") ///
    xtitle("Squeeze") ytitle("Densidad") ///
    xscale(range(0 2)) ///
    graphregion(color(white)) bgcolor(white)


restore