//Abril 4, 2019
//Buenos Aires, Argentina
//Primer Festival Internacional Feminoise
//Taller basado en las clases de Sergio Luque, Ernesto Romero, Ezequiel Netri, Hernani Villaseñor y Alexandra Cárdenas.
//Licencia Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International (CC BY-NC-SA 4.0)

//___________________Taller de SuperCollider básico
//___________________Impartido por Marianne Teixido



//Bienvenidxs a SuperCollider.
//Editor de texto, motor de audio y lenguaje de programación en el que podemos escribir líneas de código para dar intrucciones que generen sonidos a partir de la síntesis de sonido, así controlar muestras de audio.
//Lenguaje de programación de código abierto.
//supercollider.github.io
//toplap.org



//Antes de comenzar es necesario que sepas que para evaluar líneas de código debes de utilizar
// Shift + Enter (MacOS y  Linux)
// Control + Return (Windows)

//Para detener el sonido utiliza
// cmd +  punto (MacOs)
// control + punto (Linux y Windows)

//SuperCollider tiene ayuda incluída. Para visualizarla presionamos
// cmd + D (MacOS)
// control + D (Linux + Windows)


1+1
2*2
5/2
2**4
2 ** 10       //potencia
8<2
0.06>0.9
"hola"=="ola" //comparaciones booleanas
"hola mundo"


//________________ s i n t a x i s

//Las llaves { agrupan funciones }
//Los paréntesis (agrupan expresiones)
//Los corchetes [agrupan arreglos]

(
"SC es la onda"
)

(
2+
2.4 ** 4
/7+4
)

//Para anidar funciones, de igual forma utilizamos los corchetes.

(
(4/5)*5+(8 ** 3)/2
)

(
([4/5,10/2])*5+([8 ** 3, 11+1])/2
)

//________________ s e r v e r

//Para comenzar a hacer sonido necesitamos prender el servidor.

s.boot;



//________________ U G E N s

/*(Unidades Generadoras) Son objetos que producen una señal de audio. Cuando conectas varios UGENs creamos un patch.
Todos los UGENs comienzan con mayúsculas y exiten dos tipos.
*/

.ar //Audio Rate | todos corren a una velocidad de 44100 muestra por segundo. Los audio rate son parte de la cadena de mensajes que será escuchada.

.kr //Control Rate | Todos los UGENs con este mensaje corren a una velocidad de control. Es decir a 64 muestras por segundo. Los UGENs de contro generalmente son usados como moduladores de sonida de las señales de audio.

//Pero ya pela la maldita naranja!!




//Vayamos por pasos

//Para hacer sonido existen múltiples métodos. La forma más simple y rápida de ver si nuestro código funciona es con

{}.play

//Sin embargo, para piezas complejas, éste método no es el más adecuado.
//Para controlar los osciladores, es necesario escribir una serie de argumentos para indicar cómo es que queremos que se comporten.
//Los argumentos básicos son: frecuencia, fase y amplitud. Aunque esto varia dependiendo del oscilador.
//SC nos va indicando qué qué argumentos siguen cuando escribes un oscilador. De cualquier forma siempre que tengan duda, revisen la documentación con cmd + D posicionando el cursor en el UGEN que les perturba. :v


{SinOsc.ar (1500, 0, 0.1)}.play //onda senoidal

{SinOsc.ar (700, 0, 0.1)!2}.play //para crear un stéreo rápidamente:

{Pulse.ar (700, 0.2, 0.1) !2}. scope //onda cuadrada

{Saw.ar (750, 0.1)!2}.scope // onda de sierra

{LFTri.ar (700, 0, 0.3)!2}.scope //onda triangular




//________ S i n O s c

SinOsc //es un oscilador de onda senoidal. Funciona con .ar y .kr
//Sus argumentos son: frecuencia, fase, mul y add. Su sintaxis es la siguiente:

SinOsc.ar(frec, fase, mul, add)

// F r e c u e n c i a
// Ciclos por segundo o Hertz. El rango auditivo del ser humano es de 20 Hz a 20KHz en promedio. SC da por default 440Hz que es equivalente a la nota Fa.

// F a s e
//Punto del ciclo en el que queremos que inicie el oscilador. Se especifica en radianes y su rango es de 0 a 2pi. El default es 0 que es el inicio del ciclo. Es decir, es la posición en el tiempo que tiene el ciclo de oscilación.

// M u l
//Número por el que multiplicamos la señal. Generalmente se identifica con el volumen o amplitud del sonido siendo 0 el mínimo y 1 el máximo recomendado. El default es 1.

// A d d
//Número que se le suma a la señal del oscilador. Notar que se pone primero el mul y luego el add. El default es 0, dejando la señal sin alterar.

//Ejemplos:
{SinOsc.ar}.play // El SinOsc con los argumentos de default o sea frecuencia=440, fase=0, mul=1, add=0.

{SinOsc.ar(100)}.play // Con una frecuencia grave. Si no tienes audífonos o bocinas de buena calidad no la vas a oír por que las bocinas de la computadora no pueden hacer sonar frecuencias graves.

{SinOsc.ar(300,0,0.5)}.play // Una frecuencia media, con un volumen (mul) medio. {SinOsc.ar(3000,0,0.1)}.play // Una frecuencia aguda con un volumen bajo.

{SinOsc.ar(13000,0,0.9)}.play // Una frecuencia muy agudacon un volumen alto.


//________ P u l s e

Pulse //es un oscilador de onda cuadrada. Funciona solo con .ar. Sus argumentos son frecuencia, ancho de banda, mul y add. Su sintaxis es de la siguiente forma.

Pulse.ar (frecuencia, ancho de banda, mul, add)

//Ejemplos:
{Pulse.ar}.play // El Pulse con los argumentos de default.

{Pulse.ar(100)}.play // Con la frecuencia grave. En este caso si se oye en las bocinas de la computadora por la característica del tímbre que es rico en armónicos que son frecuencias más agudas.

{Pulse.ar (100, 0.3)}.play // la misma frecuencia pero un ancho de banda menor. Cambia el timbre pero la altura es la misma.

{Pulse.ar (100,0.9,0.1)}.play /* la misma frecuencia con mayor ancho de banda y amplitud más baja. No cambia el timpre pues el ancho de banda es simétrico con su eje de 0.5; así que 0.1=0.9, 0.2=0.8, 0.7=0.3 etc */

{Pulse.ar(100,MouseX.kr(0.1,1))}.scope // La misma frecuencia pero con un ancho de pulso menor. Observar cómo cambia el timbre pero la nota sigue siendo la misma. {Pulse.ar(100,0.9,0.1)}.play // La misma frecuencia pero con el ancho de pulso mayor. La amplitid baja. Nótese que el timbre no varía ya que el ancho de pulso es simétrico con su eje de simetría en 0.5 de tal modo que 0.1=0.9, 0.2=0.8, 0.7=0.3, etc.


//________ L F T r i

LFTri //Funciona con .ar y .kr.Su sintaxis es la siguiente:

LFTri.ar(frecuencia, fase, mul, add)

{LFTri.ar}.play //onda triangular con argumentos en default
{LFTri.ar(150)}.play //Con la frecuencia grave
{LFTri.ar (1000,0.1)}.scope //con frecuencia aguda y poca amplitud


//________ S a w

{Saw.ar}.play // El Saw con los argumentos de default.

{Saw.ar(350)}.scope // Con la frecuencia grave. En este caso si se oye en las bocinas de la computadora por la característica del tímbre que es rico en armónicos que son frecuencias más agudas.

{Saw.ar(10000,0.1)}.play // Con la frecuencia aguda y poca amplitud.


//Aquí terminamos con los osciladores periódicos y pasamos a los generadores de ruido.





//______________________ R U I D O S !!!!!!!!!

//El ruido, en términos físicos, es una señal aleatoria de ondas. Los tipos de ruido son clasificados por su densidad espectral es decir, dependiendo de la distribución de la potencia de las frecuencias en el espectro del ruido. Esta clasificación según la densidad espectral de un ruido recibe el nombre de "color".


//________ W h i t e  N o i s e
//Este nombre es una analogía a la "luz blanca" que contiene todos los colores en la misma intensidad y con una gran energía. Esta señal contiene todas las frecuencias y todas ellas con la misma potencia. El espectro del ruido blanco es plano.

{WhiteNoise.ar(0.19)!2}.scope


//________ P i n k   N o i s e
 //También se conoce como "ruido 1/f" ya que su densidad espectral de potencia decae 3dB por octava. Se usa mucho como señal de prueba en ingeniería acústica. El espectro del ruido rosa es semejante al espectro medio acumulado de la música sinfónica o de instrumentos como el piano y el órgano.

{PinkNoise.ar (0.9) !2}.scope


//________ B r o w n   N o i s e
 //También se conoce como "Brownian Noise" o "ruido browniano". Su PSD decae 6dB por octava, es decir que es directamente proporcional a 1/f**2. Su nombre no se debe al color marrón, sino a Robert Brown, el descubridor del "movimiento browniano", ya que este ruido puede ser generado por un algoritmo que simula dicho movimiento.

{BrownNoise.ar(0.8)!2}.scope

//________ D u s t
//Generador de impulsos aleatorios.

{Dust.ar (2500) !2}.scope
{Dust.ar(100)!2}.scope


//Ahora veremos cómo es que estos UGENs se interconectan para generar sonidos más complejos.


//______________________ S í n t e s i s     d e    s o n i d o


//Síntesis aditiva y síntesis por modulación de frecuencia.
//Ahora exploraremos formas simples de hacer nuevos tímbres. Para ello utilizaremos operadores basícos: suma y multiplicación.

//________ s u m a
//La "síntesis aditiva" la obtenemos al sumar dos señales de audio, en la que se puede apreciar las cualidades sonoras de cada una. Las amplitudes de las señales se suman, así que hay que tener cuidado con que esta suma no sobrepase 1.0.

{SinOsc.ar(2500, 0, 0.2)!2}.play
{WhiteNoise.ar(0.1)!2}.play
{SinOsc.ar(2500, 0, 0.2)+WhiteNoise.ar(0.1)!2}.play


//________ m u l t i p l i c a c i ó n
//Al multiplicar dos señales obtenemos un timbre complejo. Esta técnica se relaciona con la Amplitud Modulada.


{SinOsc.ar(2500, 0, 0.7)*WhiteNoise.kr(0.8)!2}.play
{WhiteNoise.ar(0.8)*SinOsc.kr(2500,0,0.7)!2}.play
{WhiteNoise.kr(0.8)*SinOsc.ar(2500,0,0.7)!2}.play
{PinkNoise.ar(0.3)*SinOsc.kr(2000,0,0.9)!2}.scope
{(Pulse.ar(40,0.01,0.9)*SinOsc.kr(275,0,0.4,0.5)*WhiteNoise.kr(0.9))!2}.scope
{(Pulse.ar(40,0.01,0.9)*SinOsc.kr(275,0,0.4, 0.5)*WhiteNoise.kr(0.9)+Saw.ar(100,0.1))!2}.scope


//Momento de poner en práctica lo aprendido.














//Examen!! :B
















//Je, no se crean. Haremos unos cuantos ejercicios.




















//________ E J E R C I C I O S
//Completar los espacios en blanco.

/* 1 */
{SinOsc.ar(1360,0,0.6)*WhiteNoise.kr(0.3)}.scope


/* 2 */
{LFTri.ar(60,0.5)*SinOsc.kr(780,0,0.34)}.scope


/* 3 */
{SinOsc.ar(600,0,0.7)*SinOsc.kr(1240,0,0.7)}.scope

//_________________


/* 4 */
{___.ar(0.3)*___.kr(3,0,0.9)}.scope


/* 5 */
{Pulse.ar(__,__,0.5)*___.kr(100,___)}.scope


/* 6 */
{___.ar(30,0.3)*___.kr(0.6)}.scope


/* 7 */
{LFTri.ar(30,0.1,0.3)*___.kr(0.6)*___.kr(10,0,0.4,0.6)}.scope


/* 8 */
{___.ar(302,0.3)*___.kr(10.6,0,0.6)*___.kr(0
.710)}.scope


/* 9 */
{SinOsc.ar(___,0,0.5)*SinOsc.kr(___,0,0.5,0.5)}.scope


/* 10 */
{___.ar(___,0.4)*WhiteNoise.kr(___)*___.ar(1200,0.4)*SinOsc.kr(__,0,0.6)}.scope


/* 11 */
{(___.ar(___)*___.kr(0.2))+Saw.ar(___,0.041)}.scope


/* 12 */
{(Pulse.ar(40,0.01,0.3)*___.kr(___,0,0.4,0.5)*WhiteNoise.kr(___))+____.ar(___,0.4)}.scope


/* 13 */
{((___.ar(0.5)*Dust.kr(___))+PinkNoise.ar(___))*SinOsc.kr(___,0,0.4,0.5)}.scope


/* 14 */
{Saw.ar(___,0.3)+Saw.ar(___,0.3)}.scope


/* 15 */
{((Saw.ar(460,0.3)+Pulse.ar(462,___,0.3))*Dust.kr(___))+LFTri.ar(___,0.1,___)}.scope


/* 16 */
{___.ar(14000,0,0.9)*Dust.kr(___)}.scope


/* 17 */
{___.ar(70,0,__)*Dust.kr(___)}.scope


/* 18 */
{SinOsc.ar(___,0,0.3)+___.ar(___,0,0.3)+SinOsc.ar(___,0,0.2)+___.ar(50,0,0.7)}.scope


/* 19 */
{LFTri.ar(___,0,0.5)*SinOsc.kr(___,0,0.7)}.scope


/* 20 */
{___.ar(130,0.2)+___.ar(100,0,0.3)+___.ar(0.031)}.scope




//Listo, tomaremos un descanso y regresando revisaremos los tipos de filtros, envolventes, variables, así como algunos métodos para agilizar nuestros sonidos, como SynthDef y NodeProxy :)




