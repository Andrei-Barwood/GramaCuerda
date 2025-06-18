#!/usr/bin/env tclsh

# Función para redondear a 4 decimales (la conductancia suele expresarse con alta precisión)
proc redondear4 {valor} {
    return [format "%.4f" $valor]
}

# Cabecera del programa
puts {
╔════════════════════════════════════════════════════════════════════╗
║    CONDUCTANCIA ELÉCTRICA – PLANTA NUCLEAR SUSQUEHANNA ☢️⚡        
╠════════════════════════════════════════════════════════════════════╣
║ 📍 Ubicación: Pensilvania, Estados Unidos                          
║ 🏭 Proyecto: Suministro de energía nuclear estable a Amazon Web  
║ 🧪 Definición:                                                    
║   La conductancia eléctrica (G) es una medida de qué tan fácil   
║   puede fluir la corriente a través de un componente.            
║   Es el inverso de la resistencia:                               
║                         G = 1 / R                                
║                                                                   
║ 🧮 Unidad de medida: Siemens (S)                                  
╚════════════════════════════════════════════════════════════════════╝

📝 DESCRIPCIÓN:
La conductancia se utiliza para analizar redes eléctricas, eficiencia en materiales
conductores y distribución de corriente. En una planta nuclear como Susquehanna,
la conductancia es clave para asegurar que los sistemas críticos operen con mínima
resistencia eléctrica en cableados, sensores, y equipos de potencia.
}

# Función para generar un ejemplo de conductancia
proc generar_ejemplo {i} {
    # Valores realistas de resistencia en ohmios
    set resistencia [expr {0.1 + rand()*50.0}]
    set conductancia [expr {1.0 / $resistencia}]

    set resistencia [format "%.2f" $resistencia]
    set conductancia [redondear4 $conductancia]

    puts "\n📘 Ejemplo $i:"
    switch -- $i {
        1 {
            puts "En el sistema de control de barras de control, se detecta una resistencia de $resistencia Ω."
            puts "La conductancia del circuito de monitoreo es: G = 1 / $resistencia = $conductancia S."
        }
        2 {
            puts "Un sistema de respaldo para servidores de Amazon mide $resistencia Ω en su línea principal."
            puts "La conductancia de esa línea es: G = $conductancia S."
        }
        3 {
            puts "Un sensor de temperatura en el reactor tiene una resistencia de $resistencia Ω por operación prolongada."
            puts "Su conductancia es: $conductancia S."
        }
        4 {
            puts "Una línea que conecta el generador a la subestación presenta $resistencia Ω."
            puts "Por lo tanto, su conductancia es: $conductancia S."
        }
        5 {
            puts "Durante una inspección de mantenimiento, se encuentra una resistencia de $resistencia Ω en el cableado del sistema de enfriamiento."
            puts "Esto indica una conductancia de $conductancia S."
        }
        6 {
            puts "En uno de los transformadores que alimentan los centros de datos de Amazon, se mide una resistencia de $resistencia Ω."
            puts "Esto implica una conductancia de $conductancia S."
        }
        7 {
            puts "En un módulo de control automático de presión en el circuito primario se detecta $resistencia Ω."
            puts "Su conductancia, por tanto, es $conductancia S."
        }
    }
    puts "Este valor de conductancia ayuda a evaluar cuán eficiente es la conducción de corriente en ese sistema.\n"
}

# Bucle principal
set i 1
while {$i <= 7} {
    generar_ejemplo $i
    if {$i == 7} {
        puts "\n✅ Se han mostrado los 7 ejemplos de conductancia en sistemas de la planta nuclear Susquehanna."
        break
    }

    puts "¿Quieres ver otro ejemplo? (s para sí / n para salir): "
    flush stdout
    gets stdin respuesta
    set respuesta [string tolower $respuesta]

    if {$respuesta ne "s"} {
        puts "\n👋 Programa finalizado. Ejemplo basado en la Planta Nuclear de la empresa Amazon"
        break
    }
    incr i
}
