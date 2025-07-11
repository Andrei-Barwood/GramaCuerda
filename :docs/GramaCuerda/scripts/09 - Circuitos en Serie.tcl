#!/usr/bin/env tclsh

# Función para redondear a 1 decimal
proc redondear1 {valor} {
    return [format "%.1f" $valor]
}

# Función para generar un ejemplo explicativo
proc generar_ejemplo {i} {
    # Generar valores aleatorios
    set corriente [expr {0.5 + rand()*4.5}]
    set r1 [expr {1 + rand()*10}]
    set r2 [expr {1 + rand()*10}]
    set r3 [expr {1 + rand()*10}]

    set rt [expr {$r1 + $r2 + $r3}]
    set v1 [expr {$corriente * $r1}]
    set v2 [expr {$corriente * $r2}]
    set v3 [expr {$corriente * $r3}]
    set vt [expr {$v1 + $v2 + $v3}]

    # Aplicar redondeo
    set corriente [redondear1 $corriente]
    set r1 [redondear1 $r1]
    set r2 [redondear1 $r2]
    set r3 [redondear1 $r3]
    set rt [redondear1 $rt]
    set v1 [redondear1 $v1]
    set v2 [redondear1 $v2]
    set v3 [redondear1 $v3]
    set vt [redondear1 $vt]

    # Explicaciones específicas según ejemplo
    switch $i {
        1 {
            puts "\n📘 Ejemplo $i: Control de ventiladores de tiro en la caldera"
            puts "En una planta a carbón, los ventiladores de tiro se conectan en serie para asegurar que la corriente sea constante y controlar el flujo de aire."
        }
        2 {
            puts "\n📘 Ejemplo $i: Monitoreo de sensores de temperatura en el horno"
            puts "Se conectan varios sensores de temperatura en serie para medir diferentes zonas del horno con una corriente constante."
        }
        3 {
            puts "\n📘 Ejemplo $i: Sistema de alarma para detección de gases"
            puts "Los dispositivos de alarma están conectados en serie para que si uno falla, el circuito se interrumpa y se active una señal de alerta."
        }
        4 {
            puts "\n📘 Ejemplo $i: Control de resistencias calefactoras en el sistema de secado"
            puts "Las resistencias calefactoras están en serie para distribuir uniformemente la corriente que calienta el material en proceso."
        }
        5 {
            puts "\n📘 Ejemplo $i: Circuito de actuadores de válvulas de alimentación"
            puts "Los actuadores que controlan las válvulas están en serie para sincronizar su funcionamiento bajo la misma corriente."
        }
        6 {
            puts "\n📘 Ejemplo $i: Iluminación de emergencia en la sala de control"
            puts "Las lámparas de emergencia están conectadas en serie para asegurar que la corriente sea igual en cada punto durante un fallo eléctrico."
        }
        7 {
            puts "\n📘 Ejemplo $i: Circuito de control de bombas de agua de enfriamiento"
            puts "Las bombas de agua se conectan en serie para controlar su operación de forma sincronizada y mantener el flujo de agua."
        }
        default {
            puts "\n📘 Ejemplo $i: Circuito genérico en planta a carbón"
        }
    }

    puts "La corriente que fluye por el circuito es de $corriente A."
    puts "Las resistencias de los dispositivos son: R1 = $r1 Ω, R2 = $r2 Ω, R3 = $r3 Ω."
    puts "La resistencia total del circuito es: Rt = $rt Ω."
    puts "Como se trata de un circuito en serie, la misma corriente atraviesa todos los dispositivos."
    puts "Por lo tanto, las caídas de tensión en cada uno son:"
    puts " - V1 = I * R1 = $corriente * $r1 = $v1 V"
    puts " - V2 = I * R2 = $corriente * $r2 = $v2 V"
    puts " - V3 = I * R3 = $corriente * $r3 = $v3 V"
    puts "La tensión total entregada por la planta al circuito es: Vt = $vt V."
    puts "Este tipo de configuración se utiliza en sistemas donde es importante que la corriente sea constante en todos los puntos del circuito.\n"
}

# Cabecera del programa
puts ""
puts " Importante recordar tres elementos de un circuito en serie:"
puts "   La corriente es la misma en todos los compoentes"
puts "   El voltaje total es la suma de los voltajes en cada resistencia"
puts "   La resistencia total es la suma de todas las resistencias"
puts ""
puts "🧠 Simulador de ejemplos sobre circuitos en serie en plantas a carbón ⚙️🔥\n"

# Bucle principal
set i 1
while {$i <= 7} {
    generar_ejemplo $i
    if {$i == 7} {
        puts "\n👋 Has visto todos los ejemplos disponibles. ¡Gracias por explorar los circuitos en serie!"
        break
    }
    puts "¿Quieres ver otro ejemplo? (s para sí / n para salir): "
    flush stdout
    gets stdin respuesta
    set respuesta [string tolower $respuesta]

    if {$respuesta ne "s"} {
        puts "\n👋 Programa finalizado. ¡Gracias por explorar los circuitos en serie!"
        break
    }
    incr i
}
