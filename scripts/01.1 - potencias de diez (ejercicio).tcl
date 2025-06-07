proc ejercitar_potencias_de_diez {} {
    puts "---"
    puts "## Ejercicio de Potencias de Diez"
    puts "---"
    puts "¡Hola! Vamos a practicar cómo expresar números como potencias de diez."
    puts "Recuerda que una potencia de diez indica cuántas veces debes multiplicar (o dividir) el 10 por sí mismo."
    puts "Por ejemplo: 100 es 10^2, y 0.1 es 10^-1."
    puts ""
    puts "Para salir presiona la tecla 'control' con la tecla C"
    puts ""

    # Lista de ejercicios: {número_a_adivinar} {respuesta_correcta} {explicación}
    set ejercicios {
        {10000 "10^4" "10.000 tiene 4 ceros después del 1, por lo tanto, es 10 elevado a la potencia de 4 (10^4)."}
        {1000 "10^3" "1.000 tiene 3 ceros después del 1, por lo tanto, es 10 elevado a la potencia de 3 (10^3)."}
        {0.0000001 "10^-7" "0.0000001 tiene 7 lugares decimales hasta el 1. Cuando el número es menor que 1, la potencia es negativa. Por lo tanto, es 10 elevado a la potencia de -7 (10^-7)."}
        {0.0001 "10^-4" "0.0001 tiene 4 lugares decimales hasta el 1. Cuando el número es menor que 1, la potencia es negativa. Por lo tanto, es 10 elevado a la potencia de -4 (10^-4)."}
        {1000000 "10^6" "1.000.000 tiene 6 ceros después del 1, por lo tanto, es 10 elevado a la potencia de 6 (10^6)."}
        {0.00001 "10^-5" "0.00001 tiene 5 lugares decimales hasta el 1. Cuando el número es menor que 1, la potencia es negativa. Por lo tanto, es 10 elevado a la potencia de -5 (10^-5)."}
    }

    set contador_correctas 0
    set total_ejercicios [llength $ejercicios]

    foreach ejercicio $ejercicios {
        set numero [lindex $ejercicio 0]
        set respuesta_correcta [lindex $ejercicio 1]
        set explicacion [lindex $ejercicio 2]

        puts "--------------------------------------------------"
        puts ">> Expresa el siguiente número como una potencia de diez:"
        puts "   $numero"
        puts ""
        puts "Opciones de respuesta (escribe solo el número de la opción):"

        # Generar dos opciones: una correcta y una incorrecta
        # Asegurarse de que la opción incorrecta no sea igual a la correcta
        set opciones {}
        lappend opciones $respuesta_correcta

        while {[llength $opciones] < 2} {
            # Generar una potencia de diez aleatoria para la opción incorrecta
            set potencia_falsa [expr {int(rand() * 10) - 5}] ;# Números entre -5 y 4
            set opcion_incorrecta "10^${potencia_falsa}"
            if {$opcion_incorrecta ne $respuesta_correcta} {
                lappend opciones $opcion_incorrecta
            }
        }

        # Mezclar las opciones para que la correcta no siempre sea la primera
        

        set i 1
        
        foreach opcion $opciones {
            puts "  $i) $opcion"
            incr i
        }
        puts ""

        set intento_valido 0
        while {$intento_valido == 0} {
            puts -nonewline "Tu respuesta (1 o 2): "
            gets stdin respuesta_usuario
            if {[string is integer $respuesta_usuario] && $respuesta_usuario >= 1 && $respuesta_usuario <= 2} {
                set intento_valido 1
            } else {
                puts "❌ Entrada inválida. Por favor, ingresa 1 o 2."
            }
        }

        set eleccion_usuario [lindex $opciones [expr {$respuesta_usuario - 1}]]

        if {$eleccion_usuario eq $respuesta_correcta} {
            puts "✅ ¡Correcto!"
            incr contador_correctas
        } else {
            puts "❌ Incorrecto."
            puts "La respuesta correcta es: **$respuesta_correcta**"
            puts "Explicación: $explicacion"
        }
        puts ""
    }

    puts "---"
    puts "## Resultados del Ejercicio"
    puts "---"
    puts "Has respondido correctamente $contador_correctas de $total_ejercicios ejercicios."
    puts "¡Sigue practicando para mejorar tu comprensión de las potencias de diez!"
    puts "---"
}

# Llama a la función principal para iniciar el ejercicio
ejercitar_potencias_de_diez