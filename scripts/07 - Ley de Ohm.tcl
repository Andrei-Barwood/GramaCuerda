# ley_ohm_renovable.tcl

# Definir los 12 ejemplos fijos
set ejemplos {
    "1. Paneles solares residenciales (corriente continua): cálculo de la caída de tensión en cables DC."
    "2. Turbinas eólicas (corriente alterna): estimación de la resistencia de bobinas generadoras."
    "3. Inversores solares (corriente alterna): análisis de voltaje de salida en circuitos de control."
    "4. Baterías solares (corriente continua): verificación de la corriente de carga."
    "5. Microredes solares (corriente continua): monitoreo del flujo de corriente entre nodos."
    "6. Vehículos eléctricos solares (corriente continua): simulación de la resistencia interna de motores."
    "7. Controladores MPPT (corriente continua): ajuste de carga resistiva."
    "8. Sistemas de bombeo solar (corriente alterna): análisis de eficiencia del motor eléctrico."
    "9. Iluminación LED solar (corriente continua): validación del voltaje de operación."
    "10. Estaciones de carga renovables (corriente continua): prueba de corriente de entrada."
    "11. Redes de transmisión solar (corriente alterna): medición de pérdidas resistivas."
    "12. Calentadores solares eléctricos (corriente alterna): cálculo de corriente nominal."
}

# Función para generar número aleatorio decimal
proc randfloat {min max} {
    return [expr {$min + rand() * ($max - $min)}]
}

# Mostrar ejemplos y cálculos
puts "\n===== EJEMPLOS DE USO DE LA LEY DE OHM EN ELECTRICIDAD RENOVABLE =====\n"

foreach ejemplo $ejemplos {
    # Generar valores aleatorios
    set I [format "%.2f" [randfloat 1.0 20.0]]  ;# Corriente en amperios
    set R [format "%.2f" [randfloat 0.1 100.0]] ;# Resistencia en ohmios
    set V [format "%.2f" [expr {$I * $R}]]      ;# Voltaje en voltios

    # Imprimir descripción y ecuación
    puts "$ejemplo"
    puts "  -> Ecuación: V = I * R = $I A * $R Ω = $V V\n"
}

puts ""
