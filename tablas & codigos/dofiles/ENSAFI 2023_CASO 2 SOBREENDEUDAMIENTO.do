****TRABAJANDO CON LA ENSAFI 2023

****PROGRAMA PARA GENERAR LAS VARIABLES DE INTERÉS DEL CASO 2, SOBREENDEUDAMIENTO

/*CASO 2.	Sobreendeudamiento con tarjetas de crédito y préstamos 
Imagina que trabajas en un banco y has identificado un segmento de clientes con un nivel de endeudamiento superior al 45% de sus ingresos mensuales, lo que compromete su estabilidad financiera. Pregunta: Cómo diseñarías un experimento para medir una estrategia de comunicación efectiva para ayudar a estos clientes a reducir su endeudamiento por debajo del 35%? Considera el tipo de mensaje, canal y momento adecuado para la intervención utilizando ciencias del comportamiento.*/


cd "C:/SEM 8/Bloque dos & materias final/Proyecto BeWay/tablas & codigos/dtas"
use "BASE_ENSAFI.dta"

/*Permite que Stata acceda directamente a los archivos ubicados en esa carpeta sin necesidad de escribir la ruta completa en cada comando.
Es útil para organizar el trabajo y asegurarse de que los archivos de entrada y salida (como bases de datos, do-files o logs) se guarden en el lugar correcto.
Si después de ejecutar este comando ejecutas dir, Stata te mostrará los archivos disponibles en esa carpeta.*/

*Nota la persona elegida en la ENSAFI 2023 fue un integrante del hogar de 18 años o más, cuyo cumpleaños era el siguiente a la fecha de la entrevista. 



*******************************************************
****PREGUNTAS QUE SE PUEDEN USAR PARA IDENTIFICAR LOS CLIENTES CON nivel de endeudamiento superior al 45% de sus ingresos mensuales

****=====endeudamiento superior al 45% de sus ingresos mensuales

/*​Para calcular el porcentaje de tus ingresos mensuales que destinamos al pago de deudas y evaluar si este supera el 45%​
Suma los pagos mensuales de deuda: Incluye todas las obligaciones financieras que se pagan cada mes, como:​
*Hipoteca o alquiler​
*Préstamos personales​
*Pagos de tarjetas de crédito​
*Préstamos para automóviles​
*Pagos de préstamos estudiantiles​
*Manutención de hijos​
*Otras deudas​

Calcula los ingresos mensuales brutos: Este es el monto que se recibe antes de impuestos y otras deducciones.​
Divide el total de los pagos mensuales de deuda entre los ingresos mensuales brutos y multiplica el resultado por 100 para obtener el porcentaje.​
Fórmula:(Pagos mensuales de deuda / Ingresos mensuales brutos) x 100 = % de endeudamiento
Ejemplo práctico:
Pagos mensuales de deuda:​
*Hipoteca: $1,200​
*Préstamo de automóvil: $300​
*Tarjetas de crédito: $200​
*Total: $1,200 + $300 + $200 = $1,700
*Ingresos mensuales brutos:​ $4,000​
Cálculo:​ ($1,700 / $4,000) x 100 = 42.5%​
En este ejemplo, el 42.5% de los ingresos mensuales se destinan al pago de deudas, lo que supera el límite recomendado del 35%.​
Recomendaciones:
Límite sugerido: Se recomienda que la relación deuda/ingreso no supere el 35% de los ingresos mensuales brutos para mantener una salud financiera adecuada. ​
Acciones a considerar: Reducir el monto de las deudas existentes; Aumentar los ingresos mensuales; Reestructurar las deudas para obtener mejores condiciones.​
Mantener una relación deuda/ingreso saludable es crucial para evitar dificultades financieras y garantizar la capacidad de asumir nuevas obligaciones crediticias en el futuro.*/



****Generando la variable ingreso mensual con la ENSAFI 2023
*generando la variable ingreso mensual laboral considerando temporalidad "ing_lab" 
/*p5_19 ¿Cuánto gana o recibe usted por trabajar (su actividad)?	
00000	No recibe ingresos
00050 - 92000	Ingresos por trabajo y periodo
98000	$98,000 y más
99999	No sabe
b	Blanco por secuencia
p5_19a ¿Cada cuándo?	
1	A la semana
2	A la quincena
3	Al mes
4	Al año
b	Blanco por secuencia*/
gen ing_lab=p5_19 if p5_19!=99999
replace ing_lab=ing_lab*4 if p5_19a==1
replace ing_lab=ing_lab*2 if p5_19a==2
replace ing_lab=ing_lab/12 if p5_19a==4

 
**Para identificar las personas con deudas 
/*p4_5_2 ¿Usted o alguien de su hogar tiene tarjeta o crédito de banco o personal? 1 Sí 2 No
p4_7_1 ¿Usted o alguien de su hogar tiene deuda en una tarjeta o crédito de banco, de institución financiera o de tienda departamental? 1 Sí 2 No
p6_6_1 ¿Usted tiene tarjeta de crédito departamental o de tienda de autoservicio? 1 Sí 2 No
p6_6_2 ¿Usted tiene tarjeta de crédito de banco? 1 Sí 2 No
p6_6_3 ¿Usted tiene crédito de nómina? 1 Sí 2 No
p6_6_4 ¿Usted tiene crédito personal? 1 Sí 2 No
p6_6_5 ¿Usted tiene crédito automotriz? 1 Sí 2 No
p6_6_6 ¿Usted tiene crédito de vivienda como INFONAVIT, FOVISSSTE, banco u otra institución? 1 Sí 2 No
p6_6_7 ¿Usted tiene crédito grupal, comunal o solidario (como el de Compartamos)? 1 Sí 2 No
p6_6_8 ¿Usted tiene crédito contratado por internet o aplicación como Prestadero, Doopla o Playbusiness? 1 Sí 2 No
p6_6_9 Otro 1 Sí 2 No
filtro_s6_2 ¿LA PERSONA TIENE AL MENOS UN CÓDIGO 1 EN 6.5 O 6.6? 1 Sí 2 No
p6_7¿Usted se ha atrasado en el pago de uno de estos préstamos o créditos? 1 Sí 2 No */

**PREGUNTAS PARA IDENTIFICAR EL NIVEL DE ENDEUDAMIENTO EN LA ENSAFI 2023
/*p6_8 Tomando en cuenta todas sus deudas, ¿considera que lo que debe es...
1 excesivo? >80%
2 alto? 60%
3 moderado? 35%-60%
4 bajo? <35%
5 No tiene deudas
9 No sabe
b Blanco por secuencia*/
tab p6_8
dis 4.96+10.38+43.43=58.77

*p6_9 Durante el último mes, ¿lo que ganó o recibió fue suficiente para cubrir sus gastos sin endeudarse? 1 Sí 2 No

/*p6_12 ¿Cuál es el monto máximo con el que podría endeudarse sin afectar su patrimonio? Piense en alguna necesidad como comprar una casa, automóvil, ropa, irse de viaje, entre otras.
00000000 No tiene deudas
00000001 - 09800000 Capacidad de endeudamiento
98000000 $98 000 000 y más
99999888 No responde
99999999 No sabe*/

/*p6_13 Ahora dígame, ¿cuál podría ser el monto máximo mensual en deudas que usted podría pagar sin afectar su patrimonio?
00000000 No tiene deudas 
000001 - 300000 Capacidad de endeudamiento 
980000 $980 000 y más
999888 No responde
999999 No sabe
Se toma esta variable como proxy de monto de endeudamiento mensual*/
gen deuda_men=p6_13
recode deuda_men 999888=. 999999=.

/*PARA IDENTIFICAR LA POBLACIÓN CON ENDEUDAMIENTO ARRIBA DEL 45%
*Se toman las variables "ing_lab" y "deuda_men" para generar nivel de endeudamiento "nivel_deuda1"*/
gen nivel_deuda1= ( deuda_men/ ing_lab)*100
*para ver los outliers
count if nivel_deuda1>100
count if nivel_deuda1>45
dis (11087/20448)*100= 54.220462
gen pob_deuda=1 if nivel_deuda1>45
recode pob_deuda .=0

/*Otra forma
*PARA IDENTIFICAR LA POBLACIÓN CON ENDEUDAMIENTO ARRIBA DEL 45%
*Se asume que lo que no se cubre del gasto mensaul con el ingreso mensual se cubre con algún tipo de deuda 
*Se toman las variables "ing_lab" y "gasto_men" para generar nivel de endeudamiento "nivel_deuda2"
p5_21 Considerando todos sus gastos en alimentación, transporte, vivienda, pago de servicios, entretenimiento, ropa, calzado, entre otros, ¿cuál es su gasto mensual?
00000 No tiene gastos
00200 - 90000 Gasto mensual
98000 $98 000 y más
99999 No sabe
*/
gen gasto_men=p5_21
recode gasto_men 99999=.
gen deuda=gasto_men-ing_lab 
count if deuda>45
dis (10431/20448)*100= 51.012324

/*Otra forma usando la base concentradohogar de la ENIGH 2022
*PARA IDENTIFICAR LA POBLACIÓN CON ENDEUDAMIENTO ARRIBA DEL 45%
*Se usa la variable "ing_cor": Ingreso corriente. Suma de los ingresos por trabajo, provenientes de rentas, de transferencias, de estimación del alquiler y de otros ingresos.
**Se usa la variable "ingtrab": Ingreso por trabajo. Suma del ingreso obtenido por trabajo, subordinado, como independiente y de otros trabajos.
*Se usa la variable deudas: Pago de deudas de los miembros del hogar a la empresa donde trabajan y/o a otras personas o instituciones. (Suma de erogaciones.ero_tri cuando la clave está en Q004 más la suma de gastoshogar.gasto_tri cuando la clave está en Q004 más la suma de gastospersona.gasto_tri cuando la clave está en Q004.)
*/
*con la variable ingreso corriente
tab deudas, m
tab ing_cor, m 
gen nivel_deuda_enigh1= (deudas/ ing_cor)*100
count if nivel_deuda_enigh1>45
dis (64/90102)*100= .07103061
*con la variable ingreso por trabajo
tab deudas, m
tab ingtrab, m 
gen nivel_deuda_enigh2= (deudas/ ingtrab)*100
count if nivel_deuda_enigh2>45
dis (384/90102)*100= .42618366
*Por cuestiones de temporalidad no se recomienda usar la ENIGH en este caso, los datos son trimestrales


****GENERANDO LA VARIABLE AHORRO  "ahorro" 
*generando la variable ahorros
/*p6_1_1 Actualmente, ¿usted ahorra prestando dinero?	
p6_1_2 Actualmente, ¿usted ahorra comprando propiedades animales o bienes?	
p6_1_3 Actualmente, ¿usted tiene dinero guardado en una caja de ahorro del trabajo o de personas conocidas?	
p6_1_4 Actualmente, ¿usted tiene dinero guardado con familiares o personas conocidas?	
p6_1_5 Actualmente, ¿usted participa en una tanda?	
p6_1_6 Actualmente, ¿usted ahorra dinero en su casa?
1=Sí
2=No
p6_3 Actualmente, ¿usted tiene ahorros en alguna de esas cuentas que mencionó?	
1=Sí
2=No
b=Blanco por secuencia  */
gen ahorros=1 if p6_1_1==1 | p6_1_2==1 | p6_1_3==1 | p6_1_4==1 | p6_1_5==1 | p6_1_6==1 | p6_3==1
recode ahorros .=0
tab ahorros [w= fac_ele]


