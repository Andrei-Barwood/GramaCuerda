# Función para convertir notación científica a ingenieril
proc ingenieril {valor} {
    set magnitudes {Ω nΩ µΩ mΩ Ω kΩ MΩ GΩ}
    set exponente [expr {int(floor(log10($valor) / 3) * 3)}]
    set indice [expr {($exponente / 3) + 3}]

    if {$indice < 0} {set indice 0}
    if {$indice >= [llength $magnitudes]} {set indice [expr {[llength $magnitudes] - 1}]}

    set factor [expr {pow(10, $exponente)}]
    return "[format "%.3f" [expr {$valor / $factor}]] [lindex $magnitudes $indice]"
}

# Función para calcular la resistencia
proc calcular_resistencia {p L A} {
    set A [expr {$A / 1000000.0}] ;# Convertir mm² a m²
    return [expr {$p * $L / $A}]
}

# Lista de escenarios industriales con notación ingenieril
set escenarios {
    { "Cables de alta tensión en una planta de energía" 16.8nΩ·m 100 50 }
    { "Motores eléctricos en una fábrica" 28.2nΩ·m 5 10 }
    { "Líneas de transmisión ferroviaria" 17.2nΩ·m 500 150 }
    { "Circuitos de control en una planta de manufactura" 26.5nΩ·m 2 5 }
    { "Sistemas de distribución de energía en un rascacielos" 17.2nΩ·m 200 75 }
}

# Preguntar al usuario si quiere ingresar valores manualmente o generar aleatorio
puts "¿Quieres ingresar los valores manualmente o generar una ecuación aleatoria? (Escribe 'manual' o 'aleatorio')"
set opcion [string tolower [gets stdin]] 

if {$opcion == "manual"} {
    # Entrada manual
    puts "Introduce la resistividad (p) en ohmios * metro (ejemplo: 17.2e-9 para 17.2 nΩ·m):"
    set p [gets stdin]

    puts "Introduce la longitud (L) en metros:"
    set L [gets stdin]

    puts "Introduce el grosor del cable (A) en milímetros cuadrados:"
    set A [gets stdin]

    # Calcular resistencia con valores ingresados
    set R [calcular_resistencia $p $L $A]

    # Mostrar resultados con notación ingenieril
    puts "\n=== Cálculo Manual ==="
    puts "Resistividad (p): [ingenieril $p]"
    puts "Longitud (L): $L m"
    puts "Área transversal (A): $A mm²"
    puts "Resistencia calculada: [ingenieril $R]"

} elseif {$opcion == "aleatorio"} {
    # Seleccionar un caso aleatorio
    set caso [lindex $escenarios [expr {int(rand() * [llength $escenarios])}]]

    # Extraer valores del caso
    set descripcion [lindex $caso 0]
    set p [lindex $caso 1]
    set L [lindex $caso 2]
    set A [lindex $caso 3]

    # Convertir p a su equivalente numérico
    set p_valor [scan $p "%fnΩ·m" p_valor]
    set p_valor [expr {$p_valor * 1e-9}]

    # Calcular resistencia
    set R [calcular_resistencia $p_valor $L $A]

    # Imprimir el resultado y la explicación
    puts "\n=== Escenario Industrial ==="
    puts "$descripcion"
    puts "----------------------------"
    puts "Valores utilizados:"
    puts "  Resistividad (p): $p"
    puts "  Longitud (L): $L m"
    puts "  Área transversal (A): $A mm²"
    puts "----------------------------"
    puts "Cálculo de la resistencia:"
    puts "  R = p * (L / A)"
    puts "  R = $p * ($L / $A)"
    puts "  R = [ingenieril $R]"
    puts "----------------------------"
    puts "Explicación del caso:"
    switch $descripcion {
        "Cables de alta tensión en una planta de energía" {
            puts "Los cables de alta tensión transportan grandes cantidades de corriente a largas distancias. Un área transversal grande ayuda a reducir la resistencia y la pérdida de energía."
        }
        "Motores eléctricos en una fábrica" {
            puts "En motores eléctricos, la resistencia de los bobinados afecta la eficiencia y el calor generado. Se utilizan cables con baja resistividad para reducir pérdidas."
        }
        "Líneas de transmisión ferroviaria" {
            puts "Los trenes eléctricos dependen de líneas de transmisión eficientes. Menos resistencia significa menos pérdida de energía y menor caída de voltaje en el trayecto."
        }
        "Circuitos de control en una planta de manufactura" {
            puts "Los sistemas de control industrial usan cables delgados, pero deben mantener baja resistencia para señales eléctricas precisas y sin interferencias."
        }
        "Sistemas de distribución de energía en un rascacielos" {
            puts "Los edificios altos necesitan cables de baja resistencia para distribuir electricidad a cada piso sin grandes pérdidas de voltaje."
        }
    }
} else {
    puts "Opción no válida. Por favor, ejecuta el programa nuevamente y escribe 'manual' o 'aleatorio'."
}
