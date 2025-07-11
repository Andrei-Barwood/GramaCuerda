proc generar_ecuacion {} {
    puts "¿Desea generar la ecuación aleatoriamente o ingresar los valores manualmente? (a/m)"
    gets stdin opcion
    
    if {$opcion == "a"} {
        set ejemplos {
            {"Turbina eólica generando 500m en 10s. Una turbina eólica convierte la energía del viento en electricidad, y en este caso, el flujo de aire se mueve 500 metros en 10 segundos." 500 10}
            {"Panel solar transmitiendo energía en 300m en 15s. Los paneles solares generan electricidad que se transmite a través de cables. Este ejemplo representa el movimiento de la energía en una red de distribución." 300 15}
            {"Flujo de agua en hidroeléctrica recorriendo 800m en 20s. En una planta hidroeléctrica, el agua en movimiento impulsa turbinas para generar electricidad, recorriendo una distancia considerable en cierto tiempo." 800 20}
            {"Corriente eléctrica en una línea de alta tensión recorriendo 1000m en 5s. La electricidad viaja a grandes distancias en redes de transmisión de alta tensión, asegurando el suministro eficiente de energía." 1000 5}
        }
        set ejemplo [lindex $ejemplos [expr {int(rand() * [llength $ejemplos])}]]
        puts "Caso de uso: [lindex $ejemplo 0]"
        set d [lindex $ejemplo 1]
        set t [lindex $ejemplo 2]
    } elseif {$opcion == "m"} {
        puts "Ingrese la distancia (d) en metros:" 
        gets stdin d
        puts "Ingrese el tiempo (t) en segundos:" 
        gets stdin t
    } else {
        puts "Opción no válida."
        return
    }
    
    if {$t == 0} {
        puts "Error: El tiempo no puede ser 0."
        return
    }
    
    set v [expr {$d / double($t)}]
    set v_formateado [format "%.1f" $v]
    
    puts "Ecuación generada: v = $d ÷ $t"
    puts "Resultado: v = $v_formateado m/s"
}

generar_ecuacion
