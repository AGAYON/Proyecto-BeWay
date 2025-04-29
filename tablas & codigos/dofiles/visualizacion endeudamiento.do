**** UTILIZANDO ENSAFI 2023
cd "C:/SEM 8/Bloque dos & materias final/Proyecto BeWay/tablas & codigos/dtas"

clear
set more off

use "BASE_ENSAFI.dta", clear


// -------------------------------
// ETAPA 1: Preparar datos base
// -------------------------------

//renombrando variables
rename p5_7 tiene_hijos
rename p5_21 gasto_mensual
rename ingreso_m ingreso_mensual
rename p6_8 deuda_percepcion

//Crear variable proxy de endeudamiento
/*p6_13 Ahora dígame, ¿cuál podría ser el monto máximo mensual en deudas que usted podría pagar sin afectar su patrimonio?
00000000 No tiene deudas 
000001 - 300000 Capacidad de endeudamiento 
980000 $980 000 y más
999888 No responde
999999 No sabe*/

gen deuda_men=p6_13
recode deuda_men 999888=. 999999=. 

/*PARA IDENTIFICAR LA POBLACIÓN CON ENDEUDAMIENTO ARRIBA DEL 45%
*nivel de deuda factible con respecto al ingreso*/
gen nivel_deuda= ( deuda_men/ ingreso_mensual)

//IDENTIFICADOR DE DEUDA MAYOR A 45%
gen sobre_deuda = nivel_deuda >= .45
gen sobre_deuda_g = gasto_mensual/ingreso_mensual >= .45

// Reemplazar valores para crear variables binarias
replace tiene_hijos = 0 if tiene_hijos != 1
replace sexo = 0 if sexo != 1 // 1 = hombres, 0 = mujeres

// Conservar solo las variables necesarias
keep sexo edad tiene_hijos gasto_mensual ingreso_mensual nivel_deuda sobre_deuda sobre_deuda_g fac_ele deuda_men deuda_percepcion

save "BASE_ENSAFI_sobredeuda.dta", replace
// -------------------------------------------
// ETAPA 2: Gráfico por grupos etarios (sextiles)
// -------------------------------------------

// Expandir datos si quieres aplicar ponderación
*expand fac_ele

// Guardar el estado original para restaurar después
preserve


* Filtrar mayores de 18
keep if edad > 18

* Crear 6 grupos etarios del mismo tamaño
xtile grupo_edad = edad, n(6)

* Obtener los rangos de edad por grupo
gen edad_min = .
gen edad_max = .

bysort grupo_edad (edad): replace edad_min = edad[1]
bysort grupo_edad (edad): replace edad_max = edad[_N]

gen etiqueta_edad = string(edad_min) + "-" + string(edad_max)

* Filtrar solo personas sobreendeudadas
keep if sobre_deuda == 1

* Generar tabla
contract grupo_edad etiqueta_edad

* Calcular proporciones
gen total = sum(_freq)
replace total = total[_N]
gen prop = (_freq / total) * 100
gen etiqueta = string(prop, "%4.2f") + "%"
label var prop "Porcentaje de personas sobreendeudadas"

* Graficar
graph bar (asis) prop, over(etiqueta_edad, label(angle(45))) ///
    bar(1, color("orange")) ///
    ytitle("Porcentaje de personas sobreendeudadas", size(medsmall)) ///
    ylabel(0(10)100, format(%4.0f) angle(horizontal)) ///
    blabel(bar, position(outside) gap(2) size(small)) ///
    title("Distribución de personas sobreendeudadas por grupo etario", size(medlarge)) ///
    graphregion(color(white)) bgcolor(white)
	
restore // restauramos datos originales sin filtrar



// -------------------------------------------
// ETAPA 3: Gráfico por quintil económico
// -------------------------------------------
preserve // volvemos a salvar el dta

*expand fac_ele

* Crear quintiles de ingreso
xtile quintil = ingreso_mensual, n(5)

* Filtrar solo personas sobreendeudadas
keep if sobre_deuda == 1

* Generar tabla
contract quintil

* Calcular proporciones
gen total = sum(_freq)
replace total = total[_N]
gen prop = (_freq / total) * 100
gen etiqueta = string(prop, "%4.2f") + "%"
label var prop "Porcentaje de personas sobreendeudadas"

* Graficar
graph bar (asis) prop, over(quintil, label(angle(0))) ///
    bar(1, color("orange")) ///
    ytitle("Porcentaje", size(medsmall)) ///
    ylabel(0(10)100, format(%4.0f) angle(horizontal)) ///
    blabel(bar, position(outside) gap(2) size(small)) ///
    title("Porcentaje de personas sobreendeudadas por quintil económico", size(medlarge)) ///
    graphregion(color(white)) bgcolor(white)

	
restore // recuperamos la memoria original