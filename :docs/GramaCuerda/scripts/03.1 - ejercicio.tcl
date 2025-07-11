# Script interactivo: caída de tensión en turbinas de gas

proc mezclar_lista {lista} {
    set mezclada {}
    set original [concat $lista]
    while {[llength $original] > 0} {
        set idx [expr {int(rand() * [llength $original])}]
        lappend mezclada [lindex $original $idx]
        set original [lreplace $original $idx $idx]
    }
    return $mezclada
}

proc redondear1 {num} {
    return [format "%.1f" $num]
}

proc generar_ejercicio {num} {
    set a1 [expr {rand()*100 + 100}]
    set b1 [expr {rand()*10 + 10}]
    set a2 [expr {rand()*20 + 10}]
    set b2 [expr {rand()*50 + 50}]
    set a3 [expr {rand()*300 + 100}]
    set b3 [expr {rand()*20 + 10}]

    set ecuaciones {
        {"V = W / Q" V}
        {"W = Q * V" W}
        {"Q = W / V" Q}
    }

    set valores [list [list $a1 $b1] [list $a2 $b2] [list $a3 $b3]]

    set hints {
        {
            "El voltaje indica cuánta energía se entrega por unidad de carga. Es clave en la distribución eléctrica desde turbinas."
            "Cuando se conoce la energía generada y la carga transferida, podemos calcular el voltaje de salida."
            "El voltaje de salida ayuda a determinar si es necesario escalar con transformadores para transmisión eficiente."
        }
        {
            "La energía generada depende de la cantidad de carga transferida y del voltaje con el que se mueve."
            "Ideal para estimar la producción total de energía en un ciclo de operación bajo carga constante."
            "Se usa para medir la eficiencia energética de las turbinas bajo condiciones de trabajo prolongadas."
        }
        {
            "La carga eléctrica permite estimar el flujo total de electrones en un sistema de generación."
            "Calcular la carga es importante para evaluar la demanda eléctrica de los consumidores conectados."
            "El conocimiento de la carga permite dimensionar adecuadamente cables y protecciones en la planta."
        }
    }

    set eqIndex [expr {int(rand() * [llength $ecuaciones])}]
    set eqData [lindex $ecuaciones $eqIndex]
    set formula [lindex $eqData 0]
    set variable [lindex $eqData 1]
    # set parA [lindex [lindex $valores $eqIndex] 0]
    # set parB [lindex [lindex $valores $eqIndex] 1]

  #  set parA_raw [lindex [lindex $valores $eqIndex] 0]
  #  set parB_raw [lindex [lindex $valores $eqIndex] 1]
  #  set parA [redondear1 $parA_raw]
  #  set parB [redondear1 $parB_raw]

    # Obtener valores crudos
    set parA_raw [lindex [lindex $valores $eqIndex] 0]
    set parB_raw [lindex [lindex $valores $eqIndex] 1]

    # Redondear a 1 decimal (y usar los redondeados para el cálculo)
    set parA [expr {double([format "%.1f" $parA_raw])}]
    set parB [expr {double([format "%.1f" $parB_raw])}]


    if {$variable eq "V"} {
        set resultado [expr {$parA / $parB}]
        set pregunta "Una turbina de gas ha entregado $parA joules de energía a través de $parB coulombs de carga. ¿Cuál es la caída de tensión (V)?"
    } elseif {$variable eq "W"} {
        set resultado [expr {$parA * $parB}]
        set pregunta "Durante una operación, una turbina de gas transfiere $parA coulombs de carga con un voltaje de $parB V. ¿Cuánta energía (W) se entregó?"
    } else {
        set resultado [expr {$parA / $parB}]
        set pregunta "Una turbina generó $parA J de energía con un voltaje de $parB V. ¿Qué cantidad de carga (Q) fue necesaria?"
    }

    set resultadoRed [redondear1 $resultado]
    set opciones [mezclar_lista [list $resultadoRed [redondear1 [expr {$resultado + rand()*5 + 1}]] [redondear1 [expr {$resultado - rand()*3 - 1}]]]]

    # Seleccionar hint
    set hint_list [lindex $hints $eqIndex]
    set hint [lindex $hint_list [expr {int(rand() * [llength $hint_list])}]]

    # Mostrar pregunta
    puts "\n📘 Fórmula: $formula"
    puts "💡 $hint\n"
    puts "Ejercicio $num/7"
    puts "$pregunta"

    for {set i 0} {$i < [llength $opciones]} {incr i} {
        puts "[expr {$i+1}]. [lindex $opciones $i]"
    }

    puts -nonewline "Tu respuesta (1-3): "
    flush stdout
    gets stdin respuesta

# Definir unidad según la variable
switch $variable {
    V { set unidad "V" }
    W { set unidad "J" }
    Q { set unidad "C" }
}

    if {[string is integer -strict $respuesta] && $respuesta >= 1 && $respuesta <= 3} {
        set seleccion [lindex $opciones [expr {$respuesta - 1}]]
        if {$seleccion eq $resultadoRed} {
            puts "✅ ¡Correcto! $resultadoRed $unidad\n"
        } else {
            puts "❌ Incorrecto. La respuesta correcta era $resultadoRed $unidad\n"
        }
    } else {
        puts "⚠️ Entrada no válida.\n"
    }

}

# Introducción educativa
puts "\n⚡ Bienvenido al simulador de caída de tensión en plantas de turbina de gas 🔥"
puts "\n🌀 Una turbina de gas funciona en 4 etapas:"
puts "1. El aire es comprimido."
puts "2. Se mezcla con combustible y se quema."
puts "3. Los gases calientes hacen girar la turbina."
puts "4. El generador transforma ese movimiento en electricidad.\n"

puts "💬 En este simulador resolverás 7 ejercicios sobre caída de tensión, energía y carga, usando fórmulas básicas en contexto industrial.\n"

# Iniciar ejercicios
for {set i 1} {$i <= 7} {incr i} {
    generar_ejercicio $i
}

puts "\n🏁 Fin del entrenamiento."
