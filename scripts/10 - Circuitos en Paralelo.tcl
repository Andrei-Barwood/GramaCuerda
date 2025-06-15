#!/usr/bin/env tclsh

# Función para redondear a 1 decimal
proc redondear1 {valor} {
    return [format "%.1f" $valor]
}

# Función para generar un ejemplo de circuito en paralelo
proc generar_ejemplo {i} {
    # Generar valores aleatorios
    set voltaje [expr {200 + rand()*800}] ;# Voltaje total (grande)
    set r1 [expr {100 + rand()*900}]
    set r2 [expr {100 + rand()*900}]
    set r3 [expr {100 + rand()*900}]

    set i1 [expr {$voltaje / $r1}]
    set i2 [expr {$voltaje / $r2}]
    set i3 [expr {$voltaje / $r3}]
    set itotal [expr {$i1 + $i2 + $i3}]
    set rt [expr {$voltaje / $itotal}]

    # Aplicar redondeo
    set voltaje [redondear1 $voltaje]
    set r1 [redondear1 $r1]
    set r2 [redondear1 $r2]
    set r3 [redondear1 $r3]
    set i1 [redondear1 $i1]
    set i2 [redondear1 $i2]
    set i3 [redondear1 $i3]
    set itotal [redondear1 $itotal]
    set rt [redondear1 $rt]

    # Introducción específica según el ejemplo
    switch $i {
        1 {
            puts "\n🌞 Ejemplo $i: Alimentación de inversores solares en paralelo"
            puts "Los inversores conectados al array de 3.1 millones de paneles operan en paralelo para compartir la carga eléctrica y distribuir el voltaje."
        }
        2 {
            puts "\n🔋 Ejemplo $i: Distribución de corriente a bancos de baterías"
            puts "Las baterías del sistema de almacenamiento (4500 kWh) se cargan en paralelo para recibir el mismo voltaje pero distintas corrientes según su estado."
        }
        3 {
            puts "\n⚙️ Ejemplo $i: Alimentación de estaciones de carga de vehículos eléctricos"
            puts "Las estaciones de carga en el perímetro de la planta se conectan en paralelo, manteniendo el mismo voltaje pero corrientes adaptadas a cada punto."
        }
        4 {
            puts "\n🌐 Ejemplo $i: Red de comunicación de sensores fotovoltaicos"
            puts "Sensores distribuidos por todo el campo solar funcionan en paralelo para asegurar monitoreo independiente y simultáneo."
        }
        5 {
            puts "\n💡 Ejemplo $i: Iluminación perimetral del parque solar"
            puts "Las luminarias LED de seguridad se conectan en paralelo para mantener voltaje constante y una operación confiable incluso si falla una unidad."
        }
        6 {
            puts "\n🔥 Ejemplo $i: Suministro de energía a sistemas de refrigeración de inversores"
            puts "Los ventiladores de enfriamiento trabajan en paralelo, cada uno con su propia resistencia interna, pero compartiendo el voltaje."
        }
        7 {
            puts "\n🛰️ Ejemplo $i: Alimentación de nodos de comunicación satelital"
            puts "Los nodos de telemetría se conectan en paralelo, garantizando que el fallo de un nodo no afecte la transmisión de los demás."
        }
        default {
            puts "\n📘 Ejemplo $i: Aplicación genérica de circuito en paralelo"
        }
    }

    puts "La tensión del sistema es de $voltaje V."
    puts "Las resistencias de los tres dispositivos son: R1 = $r1 Ω, R2 = $r2 Ω, R3 = $r3 Ω."
    puts "Como se trata de un circuito en paralelo, el voltaje es igual en todos los dispositivos."
    puts "La corriente que fluye por cada uno es:"
    puts " - I1 = V / R1 = $voltaje / $r1 = $i1 A"
    puts " - I2 = V / R2 = $voltaje / $r2 = $i2 A"
    puts " - I3 = V / R3 = $voltaje / $r3 = $i3 A"
    puts "La corriente total entregada por el sistema es: Itotal = $itotal A"
    puts "La resistencia equivalente del circuito es: Rt = V / Itotal = $voltaje / $itotal = $rt Ω\n"
}

# Cabecera del programa
puts ""
puts "
╔═════════════════════════════════════════════════════════════════════╗
║        COMPARACIÓN: Circuitos en Serie vs. Circuitos en Paralelo    ║
╠════════════════╦════════════════════════════╦═══════════════════════╣
║ Característica ║ Serie                      ║ Paralelo              ║
╠════════════════╬════════════════════════════╬═══════════════════════╣
║ Corriente      ║ Igual en todos los puntos  ║ Se divide entre ramas ║
║ Voltaje        ║ Se reparte entre elementos ║ Igual en todas ramas  ║
║ Resistencia Rt ║ Rt = R1 + R2 + R3 + ...    ║ 1/Rt = 1/R1 + 1/R2... ║
║ Comportamiento ║ Falla un componente → todo ║ Falla una rama → sigue║
║ Aplicación     ║ Luces en cadena, alarmas   ║ Tomas, paneles solares║
╚════════════════╩════════════════════════════╩═══════════════════════╝

"
puts "⚡ Simulador de ejemplos sobre circuitos en paralelo – Darden Clean Energy Project 🔋🌞\n"
puts "Características de la planta: 1.150 MW, 3.1 millones de paneles solares, 4500 kWh de baterías.\n"

# Bucle principal
set i 1
while {$i <= 7} {
    generar_ejemplo $i
    if {$i == 7} {
        puts "\n👋 Has visto todos los ejemplos disponibles. ¡Gracias por explorar los circuitos en paralelo!"
        break
    }
    puts "¿Quieres ver otro ejemplo? (s para sí / n para salir): "
    flush stdout
    gets stdin respuesta
    set respuesta [string tolower $respuesta]

    if {$respuesta ne "s"} {
        puts "\n👋 Programa finalizado. ¡Gracias por explorar los circuitos en paralelo!"
        break
    }
    incr i
}
