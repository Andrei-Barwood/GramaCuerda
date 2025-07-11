# Script TCL para Ejercitar Prefijos del Sistema Internacional (SI)

proc ejercitar_prefijos_si {} {
    puts "---"
    puts "## Prefijos del Sistema Internacional (SI): ¡Vamos a memorizar esta cuestión!"
    puts "---"
    puts "Estos pequeños aliados nos permiten hablar de números gigantes o diminutos de una forma súper práctica y corta."
    puts "Piensa en ellos como atajos matemáticos, ¡perfectos para la ciencia y la ingeniería!"
    puts ""

    # Datos de la tabla de prefijos SI (desde Tera a Pico)
    set prefijos {
        {10^12 "Tera" "T"}
        {10^9  "Giga" "G"}
        {10^6  "Mega" "M"}
        {10^3  "Kilo" "k"}
        {10^0  "Unidad" "-"} 
        {10^-3 "Mili" "m"}
        {10^-6 "Micro" "µ"}
        {10^-9 "Nano" "n"}
        {10^-12 "Pico" "p"}
    }

    # Imprimir la tabla
    puts "### Nuestra Hoja de Trucos: La Tabla de Prefijos del SI"
    puts "Aquí tienes la tabla que nos guiará. ¡Apréndetela, te será de gran ayuda!"
    puts ""
    puts [format "%-20s %-15s %-10s" "Factor de Multiplicación" "Prefijo del SI" "Símbolo del SI"]
    puts [format "%-20s %-15s %-10s" "------------------------" "---------------" "------------"]
    foreach p $prefijos {
        set factor [lindex $p 0]
        set prefijo [lindex $p 1]
        set simbolo [lindex $p 2]
        puts [format "%-20s %-15s %-10s" $factor $prefijo $simbolo]
    }
    puts "--------------------------------------------------"
    puts ""

    # Ejercicios: {número_original} {prefijo_correcto} {potencia_correcta_para_explicacion} {explicacion_adicional}
    set ejercicios {
        {15000 "Kilo" "10^3" "¡Exacto! 15.000 es lo mismo que 15 x 1.000. Como 'Kilo' significa 1.000 (o 10^3), es la opción perfecta. Piensa en 15 kilómetros (km) o 15 kilogramos (kg)."}
        {0.03000 "Mili" "10^-3" "¡Lo tienes! 0.03000 puede verse como 30 x 0.001. El prefijo 'Mili' es el que mejor representa ese 0.001 (o 10^-3). Un buen ejemplo sería 30 milímetros (mm) o 30 milisegundos (ms)."}
        {7400000 "Mega" "10^6" "¡Fantástico! 7.400.000 es igual a 7.4 x 1.000.000. Y el prefijo 'Mega' es el campeón cuando hablamos de millones (10^6). ¿Te suenan 7.4 Megawatts (MW) en una central eléctrica?"}
        {0.00000068 "Micro" "10^-6" "¡Bingo! 0.00000068 es 0.68 x 0.000001. El prefijo 'Micro' es ideal para este tipo de números, ya que significa una millonésima (10^-6). Esto es común en componentes electrónicos, como 0.68 microfaradios (µF)."}
        {0.00040200 "Mili" "10^-3" "¡Así se hace! 0.00040200 es 0.402 x 0.001. El prefijo 'Mili' encaja a la perfección con la milésima (10^-3). Imagina 0.402 miliamperios (mA) en un circuito pequeño."}
        {0.0000000002 "Nano" "10^-9" "¡De diez! 0.0000000002 es 0.2 x 0.000000001. 'Nano' es el prefijo que usamos para referirnos a las milmillonésimas (10^-9). Piensa en la velocidad de la luz, que a veces se mide en nanosegundos (ns)."}
    }

    set contador_correctas 0
    set total_ejercicios [llength $ejercicios]

    puts "### ¡Manos a la Obra!:"
    puts "Para cada número, elige el prefijo del SI que te parezca más lógico y práctico para usar en cálculos."
    puts ""

    foreach ejercicio $ejercicios {
        set numero_original [lindex $ejercicio 0]
        set prefijo_correcto [lindex $ejercicio 1]
        set potencia_correcta [lindex $ejercicio 2]
        set explicacion_adicional [lindex $ejercicio 3]

        puts "--------------------------------------------------"
        puts ">> ¡Desafío! Para el número: **$numero_original**"
        puts "   ¿Cuál de estos prefijos del SI lo representa mejor de una forma elegante y útil?"
        puts ""

        # Obtenemos los prefijos de la tabla para las opciones
        set opciones_disponibles [lmap p $prefijos {lindex $p 1}]
        set opciones_para_ejercicio {}

        # Añadir la opción correcta
        lappend opciones_para_ejercicio $prefijo_correcto

        # Añadir 2 opciones incorrectas aleatorias que no sean la correcta
        while {[llength $opciones_para_ejercicio] < 3} {
            set indice_aleatorio [expr {int(rand() * [llength $opciones_disponibles])}]
            set opcion_falsa [lindex $opciones_disponibles $indice_aleatorio]
            # Asegurarse de que no sea la correcta y que no esté ya en las opciones
            if {$opcion_falsa ne $prefijo_correcto && [lsearch -exact $opciones_para_ejercicio $opcion_falsa] == -1} {
                lappend opciones_para_ejercicio $opcion_falsa
            }
        }

        # Usamos las opciones sin mezclar, para compatibilidad con versiones antiguas de TCL
        set opciones_mezcladas $opciones_para_ejercicio 

        set i 1
        foreach opcion $opciones_mezcladas {
            puts "  $i) $opcion"
            incr i
        }
        puts ""

        set intento_valido 0
        while {$intento_valido == 0} {
            puts -nonewline "Tu elección (1, 2 o 3): "
            gets stdin respuesta_usuario
            if {[string is integer $respuesta_usuario] && $respuesta_usuario >= 1 && $respuesta_usuario <= 3} {
                set intento_valido 1
            } else {
                puts "❌ ¡Ups! Esa no es una opción válida. Por favor, solo escribe 1, 2 o 3."
            }
        }

        set eleccion_usuario [lindex $opciones_mezcladas [expr {$respuesta_usuario - 1}]]

        if {$eleccion_usuario eq $prefijo_correcto} {
            puts "🎉 ¡FELICITACIONES! Has acertado. El prefijo más apropiado es **$prefijo_correcto**."
        } else {
            puts "😕 ¡Casi! Esa no era la respuesta. La correcta es: **$prefijo_correcto**."
            puts "Te explico por qué: $explicacion_adicional"
            puts "✨ **Consejo Pro:** Cuando elijas un prefijo, busca que el número original, al dividirlo por la potencia de diez del prefijo, te dé un resultado entre 0.1 y 1000 (idealmente entre 1 y 1000). Así mantienes la notación científica 'limpia'. Por ejemplo, 15.000 se convierte en 15 x 10^3, que es perfecto para Kilo."
        }
        puts ""
    }

    puts "---"
    puts "## ¡Misión Cumplida!"
    puts "---"
    puts "Has terminado los ejercicios y te has familiarizado más con los prefijos del SI."
    puts "¡Sigue practicando, y verás cómo los dominas como un experto!"
    puts "---"
}

# Llama a la función principal para iniciar el script
ejercitar_prefijos_si