proc mezclar_lista {lista} {
    set mezclada {}
    set original [concat $lista] ;# hacemos copia

    while {[llength $original] > 0} {
        set idx [expr {int(rand() * [llength $original])}]
        lappend mezclada [lindex $original $idx]
        set original [lreplace $original $idx $idx]
    }
    return $mezclada
}


# Script interactivo de práctica de Ley de Ohm
proc generar_ejercicio {indice} {
    set ecuaciones {
        {"I = Q / t" "corriente (I)"}
        {"Q = I * t" "carga eléctrica (Q)"}
        {"t = Q / I" "tiempo (t)"}
    }

    # Diccionario de pistas (hints) para cada ecuación
    set pistas {
    {
        "La corriente es la cantidad de carga que pasa por un punto en cierto tiempo. Ideal para saber cuánta energía circula en un sistema eólico."
        "Piensa en la corriente como un flujo constante de electrones. ¿Cuánto fluye en un tiempo dado?"
        "Se usa para medir cuán intensamente fluye la electricidad. Muy útil en instalaciones solares o turbinas."
    }
    {
        "La carga es el resultado de mantener una corriente durante cierto tiempo. Así calculas cuánta energía ha sido transferida."
        "Imagina cuánta carga ha pasado si conoces la corriente y el tiempo. Ideal en almacenamiento de energía."
        "Esto sirve para estimar cuántos coulombs han sido movidos en un proceso energético completo."
    }
    {
        "El tiempo se deduce dividiendo la carga por la corriente. Así sabes cuánto duró una transferencia de energía."
        "Si sabes cuánta carga y cuánta corriente, puedes estimar cuánto tardó en pasar toda esa energía."
        "Útil para determinar la duración de una carga solar o descarga eólica según cuánta electricidad fluye."
    }
}


    # Diccionario de pistas con múltiples opciones por fórmula





    # Selección aleatoria de una ecuación
    set eqIndex [expr {int(rand()*3)}]
    set formula [lindex $ecuaciones $eqIndex 0]
    set variable [lindex $ecuaciones $eqIndex 1]

    # Generar números aleatorios entre rangos realistas
    set I [expr {round(10 + rand()*90)}]        ;# corriente: 10-100 A
    set t [expr {round(1 + rand()*10)}]         ;# tiempo: 1-10 s
    set Q [expr {$I * $t}]

    switch $eqIndex {
        0 {
            set correcto [format "%.2f" [expr {$Q / double($t)}]]
            set pregunta "Una turbina eólica transfiere una carga eléctrica de $Q C en $t segundos. ¿Cuál es la ${variable}?"
        }
        1 {
            set correcto [format "%.2f" [expr {$I * $t}]]
            set pregunta "Un sistema solar entrega una corriente de $I A durante $t segundos. ¿Cuál es la ${variable}?"
        }
        2 {
            set correcto [format "%.2f" [expr {$Q / double($I)}]]
            set pregunta "En una planta fotovoltaica se transfiere una carga de $Q C con una corriente de $I A. ¿Cuál es la ${variable}?"
        }
    }

    # Crear tres opciones: una correcta y dos distractores
    set opciones [list $correcto]

    # Agregar dos opciones erróneas
    while {[llength $opciones] < 3} {
        set distractor [format "%.2f" [expr {$correcto + (rand()*10 - 5)}]]
        if {[lsearch -exact $opciones $distractor] == -1} {
            lappend opciones $distractor
        }
    }

    # Mezclar opciones
    # set opciones [lsort -command {expr {rand() > 0.5 ? 1 : -1}} $opciones]
    set opciones [mezclar_lista $opciones]

    puts "\nEjercicio $indice/7"
    
    set pista [lindex $pistas $eqIndex]
    
    # Obtener lista de hints para esta ecuación
    set hint_list [lindex $pistas $eqIndex]

    # Elegir un hint aleatorio
    set hint [lindex $hint_list [expr {int(rand() * [llength $hint_list])}]]

    # Imprimir fórmula y pista
    puts "\n📘 Fórmula: $formula"
    puts "💡 $hint\n"


    puts "$pregunta"
    for {set i 0} {$i < 3} {incr i} {
        puts "[expr {$i+1}]. [lindex $opciones $i]"
    }

    puts -nonewline "Tu respuesta (1-3): "
    flush stdout
    gets stdin respuesta

    if {[string trim $respuesta] == "" || ![string is integer -strict $respuesta] || $respuesta < 1 || $respuesta > 3} {
        puts "Entrada inválida. Se contará como incorrecta."
        return 0
    }

    set elegida [lindex $opciones [expr {$respuesta - 1}]]
    if {$elegida == $correcto} {
        puts "✅ Correcto. ¡Buen trabajo!"
        return 1
    } else {
        puts "❌ Incorrecto. La respuesta correcta era $correcto."
        return 0
    }
}

# Bucle principal para 7 ejercicios
set puntaje 0
for {set i 1} {$i <= 7} {incr i} {
    set puntaje [expr {$puntaje + [generar_ejercicio $i]}]
}

puts "\nResultados finales: Obtuviste $puntaje de 7 respuestas correctas."
puts "Gracias."
