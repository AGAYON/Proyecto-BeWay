**** UTILIZANDO ENSAFI 2023
clear all
set more off

* Carpeta de entrada (donde están los .csv)
local carpeta_csv "C:/SEM 8/Bloque dos & materias final"

* Carpeta de salida (donde se guardarán los .dta)
local carpeta_dta "C:/SEM 8/Bloque dos & materias final/Proyecto BeWay/tablas & codigos/dtas"

* Obtiene la lista de archivos CSV en la carpeta de entrada
local archivos: dir "`carpeta_csv'" files "*.csv"

* Recorre cada archivo CSV en la carpeta
foreach archivo in `archivos' {

    * Obtiene el nombre base del archivo sin la extensión
    local nombre = subinstr("`archivo'", ".csv", "", .)

    * Importa el archivo CSV
    import delimited "`carpeta_csv'/`archivo'", clear

    * Opcional: genera una variable con el nombre del archivo
    generate fuente = "`nombre'"

    * Guarda el dataset en formato .dta en la carpeta de salida
    save "`carpeta_dta'/`nombre'.dta", replace

    * Muestra mensaje de confirmación
    di "Archivo `archivo' importado y guardado como `carpeta_dta'/`nombre'.dta"
}

* Mensaje de dtas creados
di "Todos los archivos han sido convertidos a .dta y guardados en `carpeta_dta'"


//DECLARAMOS LA RUTA DE LOS DTA
cd "C:/SEM 8/Bloque dos & materias final/Proyecto BeWay/tablas & codigos/dtas"


**** GENERAMOS LAS TABLAS A PARTIR DE LOS DTAs CREADOS
dir 

clear
set more off

// Definir archivos temporales
tempfile temp1 temp2 temp3

// Unir TVIVIENDA con THOGAR
use TVIVIENDA.dta, clear
merge 1:m llaveviv using THOGAR.dta
keep if _merge == 3  // Mantener solo las coincidencias
drop _merge
save `temp1'

// Unir el resultado con TSDEM
use `temp1', clear
merge 1:m llaveviv llavehog using TSDEM.dta
keep if _merge == 3
drop _merge
duplicates drop llaveviv llavehog, force
sort llaveviv llavehog
save `temp2'

// Unir el resultado con TMODULO
use `temp2', clear
merge 1:m llaveviv llavehog using TMODULO.dta
keep if _merge == 3
drop _merge
sort llaveviv llavehog llavemod
save BASE_ENSAFI.dta, replace  // Guardar resultado final