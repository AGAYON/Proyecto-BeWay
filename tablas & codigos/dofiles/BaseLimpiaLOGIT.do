*código para limpiar la base para LOGIT

cd "C:/SEM 8/Bloque dos & materias final/Proyecto BeWay/tablas & codigos/dtas"
use "BASE_ENSAFI.dta"

preserve

keep impulsivid gra_control p6_8 p5_21 p5_22 p6_10_7 p6_11_3 p6_11_4 p6_12 p6_13 p7_3 p7_5_1 p7_5_2 p7_5_3 p7_5_4 p7_5_5 p7_10_05 p7_10_08 p7_11_1 p7_11_2 p7_11_3 niv_estres niv_bienes p6_6_2 p6_10_2 sexo ingreso_m edad_v

replace impulsivid = 0 if impulsivid == 2

replace gra_control = 0 if gra_control == 2

rename p6_8 nivel_deuda_temp
gen nivel_deuda = .
replace nivel_deuda = 0 if nivel_deuda_temp == 5
replace nivel_deuda = 1 if nivel_deuda_temp == 4
replace nivel_deuda = 2 if nivel_deuda_temp == 3
replace nivel_deuda = 3 if nivel_deuda_temp == 2
replace nivel_deuda = 4 if nivel_deuda_temp == 1
replace nivel_deuda = . if nivel_deuda_temp == 9
drop nivel_deuda_temp

rename p5_21 gasto_mensual
mvdecode gasto_mensual, mv("999999" "999888")

rename p5_22 ingreso_ideal
mvdecode ingreso_ideal, mv("999999" "999888")

rename p6_10_7 atraso_credito
replace atraso_credito = 0 if atraso_credito == 2
//mvdecode atraso_credito, mv("b")

rename p6_11_3 darse_gusto
replace darse_gusto = 0 if darse_gusto == 2
//mvdecode darse_gusto, mv("b")

rename p6_11_4 adelanto_pagos
replace adelanto_pagos = 0 if adelanto_pagos == 2
//mvdecode adelanto_pagos, mv("b")

rename p6_12 monto_max_deuda_patr
mvdecode monto_max_deuda_patr, mv("99999888" "99999999")

rename p6_13 monto_max_deuda_mens
mvdecode monto_max_deuda_mens, mv("999888" "999999")

rename p7_3 cumple_registro
replace cumple_registro = 0 if cumple_registro == 2
//mvdecode cumple_registro, mv("b")

rename p7_5_1 no_registra
//mvdecode no_registra, mv("b")

rename p7_5_2 no_tiempo
//mvdecode no_tiempo, mv("b")

rename p7_5_3 registro_aburrido
//mvdecode registro_aburrido, mv("b")

rename p7_5_4 no_pensado
//mvdecode no_pensado, mv("b")

rename p7_5_5 no_sabe_como
//mvdecode no_sabe_como, mv("b")

rename p7_10_05 hace_no_piensa_temp
gen hace_no_piensa = .
replace hace_no_piensa = 0 if hace_no_piensa_temp == 4
replace hace_no_piensa = 1 if hace_no_piensa_temp == 3
replace hace_no_piensa = 2 if hace_no_piensa_temp == 2
replace hace_no_piensa = 3 if hace_no_piensa_temp == 1
drop hace_no_piensa_temp

rename p7_10_08 cuesta_habitos_temp
gen cuesta_habitos = .
replace cuesta_habitos = 0 if cuesta_habitos_temp == 4
replace cuesta_habitos = 1 if cuesta_habitos_temp == 3
replace cuesta_habitos = 2 if cuesta_habitos_temp == 2
replace cuesta_habitos = 3 if cuesta_habitos_temp == 1
drop cuesta_habitos_temp

rename p7_11_1 prefiere_credito_temp
gen prefiere_credito = .
replace prefiere_credito = 0 if prefiere_credito_temp == 5
replace prefiere_credito = 1 if prefiere_credito_temp == 4
replace prefiere_credito = 2 if prefiere_credito_temp == 3
replace prefiere_credito = 3 if prefiere_credito_temp == 2
replace prefiere_credito = 4 if prefiere_credito_temp == 1
drop prefiere_credito_temp

rename p7_11_2 gasta_no_ahorra_temp
gen gasta_no_ahorra = .
replace gasta_no_ahorra = 0 if gasta_no_ahorra_temp == 5
replace gasta_no_ahorra = 1 if gasta_no_ahorra_temp == 4
replace gasta_no_ahorra = 2 if gasta_no_ahorra_temp == 3
replace gasta_no_ahorra = 3 if gasta_no_ahorra_temp == 2
replace gasta_no_ahorra = 4 if gasta_no_ahorra_temp == 1
drop gasta_no_ahorra_temp

rename p7_11_3 satisfaccion_gastar_temp
gen satisfaccion_gastar = .
replace satisfaccion_gastar = 0 if satisfaccion_gastar_temp == 5
replace satisfaccion_gastar = 1 if satisfaccion_gastar_temp == 4
replace satisfaccion_gastar = 2 if satisfaccion_gastar_temp == 3
replace satisfaccion_gastar = 3 if satisfaccion_gastar_temp == 2
replace satisfaccion_gastar = 4 if satisfaccion_gastar_temp == 1
drop satisfaccion_gastar_temp

gen nivel_estres = .
replace nivel_estres = 1 if niv_estres == 3
replace nivel_estres = 3 if niv_estres == 1
replace nivel_estres = 2 if niv_estres == 2
drop niv_estres

gen nivel_bienestar = .
replace nivel_bienestar = 1 if niv_bienes == 4
replace nivel_bienestar = 2 if niv_bienes == 3
replace nivel_bienestar = 3 if niv_bienes == 2
replace nivel_bienestar = 4 if niv_bienes == 1
drop niv_bienes

rename p6_6_2 tiene_tarjeta
replace tiene_tarjeta = 0 if tiene_tarjeta == 2

rename p6_10_2 utilizo_ahorros
replace utilizo_ahorros = 0 if utilizo_ahorros == 2
//mvdecode utilizo_ahorros, mv("b")

replace sexo = 0 if sexo == 2

rename ingreso_m ingreso_mensual
//mvdecode ingreso_mensual, mv("b")

// Población objetivo: deuda alta (3) y excesiva (4), excluyendo respuestas 9
gen pob_objetivo = .
replace pob_objetivo = 1 if nivel_deuda == 3 | nivel_deuda == 4
replace pob_objetivo = 0 if inrange(nivel_deuda, 0, 4) & !inlist(nivel_deuda, 3, 4)



save "BASE_LOGIT.dta", replace

restore

