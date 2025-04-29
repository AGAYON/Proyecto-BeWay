**** UTILIZANDO ENSAFI 2023
cd "C:/SEM 8/Bloque dos & materias final/Proyecto BeWay/tablas & codigos/dtas"

clear
set more off

use "BASE_ENSAFI_sobredeuda.dta", clear


//nivel_deuda: nivel_deuda= ( deuda_men/ ingreso_mensual) // p6_13: monto máximo de deuda posible 

// sobre_deuda_g: identificador de gasto > 45% de los ingresos == 1, 0

// -------------------------------------------------
// ETAPA 2: Gráfico por grupos etarios controlado por sexo
// -------------------------------------------------

preserve // guarda el estado original

// Filtrar mayores de 18
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

// Filtrar personas sobreendeudadas
keep if sobre_deuda_g == 1

// Tabla de frecuencia por grupo de edad y sexo
contract grupo_edad etiqueta_edad sexo

// Calcular proporciones
gen total = .
bysort sexo (grupo_edad): replace total = sum(_freq)
bysort sexo (grupo_edad): replace total = total[_N]
gen prop = (_freq / total) * 100
gen etiqueta = string(prop, "%4.2f") + "%"
label var prop "Porcentaje de personas sobreendeudadas"

// Etiquetas para sexo
label define sexo_lbl 0 "M" 1 "H"
label values sexo sexo_lbl

// Graficar con colores y leyenda
graph bar (asis) prop, over(sexo) over(etiqueta_edad, label(angle(45))) ///
    bar(1, color("orange*0.8")) bar(2, color("navy")) ///
    legend(order(1 "Mujeres" 2 "Hombres") size(small)) ///
    ytitle("Porcentaje de personas sobreendeudadas", size(medsmall)) ///
    ylabel(0(10)100, format(%4.0f) angle(horizontal)) ///
    blabel(bar, position(outside) gap(2) size(small)) ///
    title("Personas sobreendeudadas por grupo etario y sexo", size(medlarge)) ///
    graphregion(color(white)) bgcolor(white)

restore // vuelve al dataset original


// -------------------------------------------------
// ETAPA 3: Gráfico por quintil económico controlado por sexo
// -------------------------------------------------
preserve

xtile quintil = ingreso_mensual, n(5)
keep if sobre_deuda_g == 1

contract quintil sexo

gen total = .
bysort sexo (quintil): replace total = sum(_freq)
bysort sexo (quintil): replace total = total[_N]

gen prop = (_freq / total) * 100
gen etiqueta = string(prop, "%4.2f") + "%"
label var prop "Porcentaje de personas sobreendeudadas"

label define sexo_lbl 0 "M" 1 "H"
label values sexo sexo_lbl

graph bar (asis) prop, over(sexo, label(angle(0))) over(quintil, label(angle(0))) ///
    bar(1, color("orange*0.8")) bar(2, color("navy")) ///
    ytitle("Porcentaje de personas sobreendeudadas", size(medsmall)) ///
    ylabel(0(10)100, format(%4.0f) angle(horizontal)) ///
    blabel(bar, position(outside) gap(2) size(small)) ///
    legend(order(1 "Mujeres" 2 "Hombres")) ///
    title("Personas sobreendeudadas por quintil económico y sexo", size(medlarge)) ///
    graphregion(color(white)) bgcolor(white)

	
	
	
preserve	
	
	
	
	
	
	* Crear variable de quintiles
xtile quintil = ingreso_mensual, n(5)

* Calcular total de personas por quintil y sexo
gen uno = 1
collapse (count) total = uno (sum) endeudados = sobre_deuda, by(quintil sexo)

* Calcular proporción de endeudados
gen prop = (endeudados / total) * 100
gen etiqueta = string(prop, "%4.2f") + "%"

label define sexo_lbl 0 "M" 1 "H"
label values sexo sexo_lbl
label var prop "Porcentaje sobreendeudado dentro del grupo"

* Graficar
graph bar (asis) prop, over(sexo, label(angle(0))) over(quintil, label(angle(0))) ///
    bar(1, color("orange*0.8")) bar(2, color("navy")) ///
    ytitle("Montos de deuda respecto al ingreso", size(medsmall)) ///
    ylabel(0(10)100, format(%4.0f) angle(horizontal)) ///
    blabel(bar, position(outside) gap(2) size(small)) ///
    legend(order(1 "M" 2 "H")) ///
    title("Máxima deuda por quintil económico", size(medlarge)) ///
    graphregion(color(white)) bgcolor(white)

	

	
	
	
	
restore //reestablecemos la memoria


// -------------------------------------------------
// ETAPA 4: Creamos el proxy de deuda 
// -------------------------------------------------
preserve

*Primero creamos el cociente del gasto sobre el ingreso_mensual
gen gasto_ingreso = (gasto_mensual/ingreso_mensual)

*ahora creamos el cociente del monto máximo de deuda sobre el ingreso mensual
gen deudamax_ingreso = (nivel_deuda/ingreso_mensual)

*visualizar las distribuciones
histogram gasto_ingreso if gasto_ingreso<=3
histogram deudamax_ingreso if deudamax_ingreso >0.01

*creamos la variable de squeeze financiero
*Entre más cercano a cero mayor será la presión del consumo sobre el ingreso
*0 = no puedo consumir más/ estoy totalmente gastado
*entre más se aleje del 0 menor será el squeeze/ más holgado estoy
*1 = puedo endeudarme exactamente con la cantidad para pagar mis gastos
//Interpretación general: El cociente compara la capacidad de endeudamiento con la necesidad de gasto. En otras palabras: ¿tengo suficiente margen (vía deuda) para cubrir mis gastos?
gen squeeze = deudamax_ingreso/gasto_ingreso
histogram squeeze

*Medimos el squeeze contra la condición de sobre_deuda 45%



restore

//notas
/*
Si las personas no pueden endeudarse mas quiere decir que ya están al límite
NO PERDER DE VISTA EL OBJETIVO: encontrar tendencias que ocasionen sobredeuda 

usar la variable gasto_ingreso como INDICADOR de consumo (establecer con este el umbral de 45%)
usar la variable squeeze para controlar. Si esta gastando de más y no puede endeudarse
quiere decir que ya está endeudado, no puede endeudarse más.


*/
//preguntas






