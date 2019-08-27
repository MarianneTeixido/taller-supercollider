//Abril 4, 2019
//Buenos Aires, Argentina
//Primer Festival Internacional Feminoise
//Taller basado en las clases de Sergio Luque, Ernesto Romero, Ezequiel Netri, Hernani Villaseñor y Alexandra Cárdenas.
//Licencia Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

//___________________Taller de SuperCollider básico
//___________________Impartido por Marianne Teixido


//Sección 2
//Continuamos con

//______________________ F I L T R O S
//Un filtro es un sistema que realiza un proceso de discriminación de una señal de entrada para obtener variaciones en su salida. Un filtro de audio está diseñado para dejar pasar determinadas segmentos de frecuencia y no dejar pasar otras. En los filtros que usaremos, el primer argumento indica la señal que será filtrada y el segundo argumento es su frecuencia de corte. Los tres filtros que veremos a continuación pueden funcionar tanto con .ar como con .kr. La condición al usarlos es que la señal que se quiera filtrar tenga el mismo rate que el filtro.



//________ H P F  - High Pass Filter (Filtro Pasa Altas)
//Es aquel que permite el paso de frecuencias desde una frecuencia determinada hacia arriba, sin que exista un límite superior especificado. Esta frecuencia determinada es la frecuencia de corte. Por ejemplo, si determinamos que sea 700Hz la frecuencia de corte dejaremos pasar todas las frecuencias mas altas que 700 Hz.


{HPF.ar(in:, freq:, mul:, add: )}; //Sintaxis

//Argumentos:
in: //señal que filtraremos. Tiene que tener .ar
freq: //frecuencia de corte
mul: //multiplicación
add: //adición


{HPF.ar(WhiteNoise.ar(0.1), 7030)}.scope

//Aqui un WhiteNoise es filtrado por un pasa altos dejando pasar frecuencias arriba de los 7030 Hz



//________ L P F - Low Pass Filter (Filtro Pasa Bajas)
//Es aquel que permite el paso de frecuencias bajas, desde la frecuencia 0 hasta una frecuencia determinada. Esta frecuencia determinada es la frecuencia de corte. Por ejemplo, si determinamos que sea 200 Hz la frecuencia de corte dejaremos pasar todas las frecuencias mas bajas que 200 Hz. Es importante recordar que no hay frecuencias menores a 0 Hz.
//Los argumentos son los mismos que los del HPF.

{LPF.ar(WhiteNoise.ar(0.1),7030)}.scope // Aqui lo contrario: pasan las frecuencias debajo de los 7030 Hz




////________ B P F - Band Pass Filter (Filtro Pasa Banda)
//Es aquel que permite el paso de frecuencias contenidas dentro de un determinado rango o banda, comprendido entre una frecuencia inferior y otra superior. La distancia entre estas frecuencias determina el ancho de banda. La frecuencia que está en el centro de esta distancia es la frecuencia de corte. Por ejemplo, si determinamos que sea 1000 Hz la frecuencia de corte y 200 Hz el ancho de banda podemos saber cual es el rango de frecuencias que dejaremos pasar usando la siguiente fórmula:

//cota inferior = frecuencia de corte - ancho de banda/2
//cota superior = frecuencia de corte + ancho de banda/2

//La cota superior es la frecuencia límite superior y la cota inferior es la frecuencia límite inferior.

//Si sabemos cuáles son las cotas inferior y superior que queremos entonces podemos obtener el ancho de banda y la frecuencia de corte con la siguiente fórmula:

//ancho de banda = cota superior - cota inferior
1100 - 900

//frecuencia de corte = cota superior - ancho de banda/2
1100- (200/2)

// o frecuencia de corte = cota inferior + ancho de banda/2
900 + (200/2)

//El BPF no es el único filtro que usa un ancho de banda. En los filtros de este tipo el ancho de banda no puede escribirse como un argumento. Para establecer el ancho de banda, SC utiliza el factor de calidad del filtro, que es un parámetro que mide la relación de energía que dispersa el filtro y la que almacena. Este factor es conocido como Q y es igual a la frecuencia de corte/ancho de banda. Entonces, en vez del ancho de banda, usamos el recíproco de Q, ya que esto le ahorra al programa una división adentro del UGen. El recíproco de Q se representa así Q/1 = 1/Q. Por consiguiente: rq= ancho de banda /frecuencia de corte.


//Argumentos:
in: //señal de entrada
freq: //frecuencia de corte en Hz
rq: //recíproco de Q, es decir el ancho de banda / frecuencia de corte.
mul: y add:

{ BPF.ar(WhiteNoise.ar(0.1), 7000, 700/7000)}.scope // El tercer argumento del pasa banda es el reciproco de q.

//En este ejemplo tenemos ancho de banda=700 y frecuencia de corte=7000.
700/7000 = 0.1
//Por lo tanto
rq=0.1

//A veces es mas rápido escribir el número decimal que el quebrado. Veamos entonces como queda sustituyendo del ejemplo anterior:
{BPF.ar (WhiteNoise.ar (0.1), 7030, 0.1)}.scope
{BPF.ar (WhiteNoise.ar(0.1), 7030, 1)}.scope // Aquí tenemos otro valor para el rq.

//___N O T A
//Hay señales que se prestan a ser filtradas y otras que no. Por ejemplo, una senoide (SinOsc) no se presta a ser filtrada porque sólo contiene una frecuencia. No existe nada más arriba ni más abajo de esa frecuencia para ser retirado. Los ruidos, que son un conjunto complejo de 18 frecuencias son los que dan resultados más notables al ser filtrados.


//Ejemplo de Hi Hat con WhiteNoise, un filtro, decaimiento y un secuenciador.

{(RHPF.ar(WhiteNoise.ar(0.3),[500,5100,4000],1))*Decay.kr(Demand.kr(Impulse.kr(1),0,Dseq([1,1,1,1],inf))*Impulse.kr(1),0.09)*3}.play



//_______________ Interactividad. Control con Mouse

//Una forma de controlar los argumentos de los UGens en SuperCollider es a través de las Clases MouseY, MouseX y MouseButton. Estas clases son UGens de control por lo que trabajan con el mensaje kr. Los argumentos principales de los UGens MouseY y MouseX son el valor mínimo y el valor máximo que queremos obtener al mover nuestro mouse. En MouseButton los argumentos son el valor cuando el mouse no está apretado y cuando si.

MouseX.kr(0,100) // nos da números desde 0 (cuando el mouse está totalmente a la izquierda) hasta 100 (cuando el mouse está en el extremo derecho).

MouseY.kr(0,100) // nos da números desde 0 (cuando el mouse esta completamente arriba) hasta 100 (cuando el mouse está totalmente abajo).

MouseButton.kr(0,1) // Cuando no esta apretado tengo el valor 0 y cuando si el valor 1.

//________

{SinOsc.ar(MouseY.kr(1000,100))}.scope // Puedo hacer un barrido desde la frecuencia 100Hz cuando el mouse esta abajo hasta 1000 Hz cuando el mouse esta hasta arriba.

{SinOsc.ar(400,0,MouseX.kr(0,1))}.scope // Amplitud 0 cuando el mouse esta en el extremo izquierdo hasta 1 cuando el mouse esta en el extremo derecho.

{SinOsc.ar(MouseX.kr(1000,100),0,MouseY.kr(0,1))}.scope // Mezclando los dos ejemplos anteriores con MouseY y MouseX

{Pulse.ar(MouseY.kr(10000,20),MouseX.kr(0.001,0.5),MouseButton.kr(0,1))}.scope

//Los mismos ejemplos de filtros usando la clase MouseY y MouseX
{HPF.ar(WhiteNoise.ar(0.1),MouseY.kr(10000,1000))}.scope
{LPF.ar(WhiteNoise.ar(0.1),MouseX.kr(10000,100))}.scope
{BPF.ar(WhiteNoise.ar(0.1),MouseY.kr(10000,1000), 0.05)}.scope
{BPF.ar(WhiteNoise.ar(0.5), 130,MouseX.kr(0.05,1.5))}.scope
{BRF.ar(WhiteNoise.ar(0.1),MouseY.kr(10000,1000),MouseButton.kr(0,1))}.scope
{BRF.ar(WhiteNoise.ar(0.1), 7030,MouseX.kr(0.05,1.5))}.scope






//EJERCICIOS

/* 1 */
{LPF.ar(BrownNoise.ar(0.5),___)}.scope

/* 2 */
{HPF.ar(Pulse.ar(___,0.75)*WhiteNoise.ar(__),10000)}.scope

/* 3 */
{Saw.ar(__,0.75)*BPF.ar(WhiteNoise.__(1),10000)}.scope

/* 4 */
{_______.ar(Saw.ar(2,0.6),3000,100/3000)+BPF.ar(_______.ar(3,0.4),_______,50/500)}.scope

/* 5 */
{LFTri.ar(1,0,1)*LPF.ar(_______.ar(30,0.1,1),1000)}.scope

/* 6 */
{Pulse.ar(117,_______.kr(0.5,0.01),0.5)}.scope

/* 7 */
{_______.ar(MouseX.kr(60,800),0,0.6)}.scope

/* 8 */
{_______.ar(_______.ar(100),MouseY.kr(15000, 160),60/MouseY.kr(15000,160))}.scope

/* 9 */
{Pulse.ar(_______.kr(5,20))_______(SinOsc.ar (10000,0,0.6)_______SinOsc.ar(90,0,0.6))}.scope

/* 10 */
{Pulse.ar(MouseY.kr(110,90),_______,0.5)*_______.ar(100,0.1,0.5)}.scope


//Woow, estuvo denso. Pero ya vamos de gane, continuamos con envolventes.
 