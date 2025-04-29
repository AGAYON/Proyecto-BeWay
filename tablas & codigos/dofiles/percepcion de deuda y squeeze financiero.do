**** UTILIZANDO ENSAFI 2023
cd "C:/SEM 8/Bloque dos & materias final/Proyecto BeWay/tablas & codigos/dtas"

clear
set more off

use "BASE_ENSAFI_sobredeuda.dta", clear


//nivel_deuda: nivel_deuda= ( deuda_men/ ingreso_mensual) // p6_13: monto máximo de deuda posible 

// sobre_deuda_g: identificador de gasto > 45% de los ingresos == 1, 0

//ASUMIMOS QUE LA DEUDA PERCIBIDA ALTA Y EXCESIVA = DEUDA > 45%

gen deuda_percepcion_bin = .
replace deuda_percepcion_bin = 1 if inlist(deuda_percepcion, 1, 2, 3, 4, 5)


* Crear variable de quintiles económicos
xtile quintil = ingreso_mensual, n(5)

* Crear variable auxiliar para conteo
gen uno = 1

* Calcular total de personas por grupo (quintil y sexo), y total de personas con percepción de deuda
collapse (count) total = uno (sum) con_deuda = deuda_percepcion_bin, by(quintil sexo)

* Calcular proporción de personas con percepción de deuda
gen prop = (con_deuda / total) * 100
gen etiqueta = string(prop, "%4.2f") + "%"

* Etiquetas para sexo
label define sexo_lbl 0 "M" 1 "H"
label values sexo sexo_lbl
label var prop "Porcentaje con percepción de deuda dentro del grupo"

* Graficar
graph bar (asis) prop, over(sexo, label(angle(0))) over(quintil, label(angle(0))) ///
    bar(1, color("orange*0.8")) bar(2, color("navy")) ///
    ytitle("Percepción de deuda alta", size(medsmall)) ///
    ylabel(0(10)100, format(%4.0f) angle(horizontal)) ///
    blabel(bar, position(outside) gap(2) size(small)) ///
    legend(order(1 "M" 2 "H")) ///
    title("Percepción de deuda >45% por quintil económico y sexo", size(medlarge)) ///
    graphregion(color(white)) bgcolor(white)

	
preserve

expand fac_ele
count if deuda_percepcion_bin == 1



restore




