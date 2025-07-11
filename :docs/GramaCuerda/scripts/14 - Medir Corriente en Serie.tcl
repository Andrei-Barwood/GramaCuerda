# Script TCL: Cómo medir corriente con un multitester en un circuito en serie (ERNC)

proc esperar {} {
    puts ""
    puts "Presiona ENTER para continuar..."
    gets stdin
    puts ""
}

proc instruccion {texto} {
    puts "🔹 $texto"
    esperar
}

proc mostrarIntroduccion {} {
    puts "📘 GUÍA: Medición de Corriente con Multitester"
    puts "------------------------------------------------"
    puts "Este programa te enseña cómo medir la corriente eléctrica en un circuito en serie usando un multitester."
    puts ""
    puts "⚡ Importante: Para medir corriente, el multitester debe conectarse EN SERIE, interrumpiendo el circuito."
    puts "Usar mal el instrumento puede dañarlo o provocar accidentes."
    esperar
}

proc mostrarAdvertencias {} {
    puts "⚠️ ADVERTENCIAS:"
    puts "----------------"
    puts "1. NUNCA midas corriente si no sabes cuánto circula por el circuito. Consulta el manual técnico o usa una pinza amperimétrica si no puedes interrumpir el flujo."
    puts "2. Configura SIEMPRE el multitester correctamente. Muchos testers tienen puertos separados para corriente (A) y tensión (V)."
    puts "3. Asegúrate de interrumpir el circuito ANTES de colocar el tester para evitar cortocircuitos."
    puts "4. Verifica el fusible del tester si después de una medición incorrecta deja de funcionar."
    esperar
}

proc mostrarGuiaConexion {} {
    puts "🔧 PASOS PARA MEDIR CORRIENTE EN SERIE:"
    puts "--------------------------------------"
    instruccion "1. Apaga el circuito antes de conectarte."
    instruccion "2. Coloca la punta negra (COM) en el puerto común del tester."
    instruccion "3. Coloca la punta roja en el puerto marcado como 'A' o '10A', según el rango de corriente estimado."
    instruccion "4. Selecciona el modo de corriente (A⎓ para DC o A~ para AC)."
    instruccion "5. Interrumpe el circuito donde quieres medir la corriente."
    instruccion "6. Conecta el tester entre los dos extremos del corte, como si fuera parte del cable."
    instruccion "7. Enciende el circuito y lee la corriente que circula por ese punto."
}

proc mostrarEjemplo {num} {
    switch $num {
        1 {
            puts "\nEjemplo 1: Corriente en un panel solar aislado de 300 W"
            puts "  🔸 Instalación: Circuito serie desde el panel hacia un regulador de carga."
            puts "  🔸 Funcionamiento: Mide la corriente entregada a carga directa al mediodía."
            puts "  🔌 Corriente estimada: 8.2 A (24 V nominal)"
        }
        2 {
            puts "\nEjemplo 2: Corriente en un aerogenerador de eje vertical doméstico"
            puts "  🔸 Instalación: El tester se coloca entre la salida del generador y el controlador de carga."
            puts "  🔸 Funcionamiento: Mide el amperaje cuando el viento alcanza los 20 km/h."
            puts "  🔌 Corriente estimada: 5.6 A (DC)"
        }
        3 {
            puts "\nEjemplo 3: Corriente en banco de supercondensadores"
            puts "  🔸 Instalación: Circuito serie de carga rápida desde fuente auxiliar de respaldo."
            puts "  🔸 Funcionamiento: Mide la corriente de entrada en la fase de carga inicial."
            puts "  🔌 Corriente estimada: 12.0 A"
        }
        4 {
            puts "\nEjemplo 4: Corriente de arranque de una bomba de agua alimentada por solar"
            puts "  🔸 Instalación: Tester entre inversor y bomba de pozo."
            puts "  🔸 Funcionamiento: Mide corriente durante el impulso inicial del motor."
            puts "  🔌 Corriente estimada: 15.0 A (pico)"
        }
        5 {
            puts "\nEjemplo 5: Corriente en luminaria LED de 48 V alimentada por microturbina hidráulica"
            puts "  🔸 Instalación: Tester se coloca en serie con el circuito de iluminación de emergencia."
            puts "  🔸 Funcionamiento: Mide consumo continuo nocturno en sistema off-grid."
            puts "  🔌 Corriente estimada: 1.5 A"
        }
        6 {
            puts "\nEjemplo 6: Corriente en sistema de carga para vehículo eléctrico (microgrid)"
            puts "  🔸 Instalación: Tester entre salida del controlador solar y entrada del cargador."
            puts "  🔸 Funcionamiento: Evalúa flujo de corriente bajo condiciones máximas de insolación."
            puts "  🔌 Corriente estimada: 10.0 A"
        }
        7 {
            puts "\nEjemplo 7: Corriente generada por celda Peltier en estación remota"
            puts "  🔸 Instalación: Tester en serie con carga de bajo consumo en sistema de refrigeración térmica pasiva."
            puts "  🔸 Funcionamiento: Mide corriente térmica generada desde gradiente de calor solar."
            puts "  🔌 Corriente estimada: 0.7 A"
        }
        default {
            puts "⚠️ Opción no válida. Intenta de nuevo."
        }
    }
    esperar
}

# Menú principal
proc menuPrincipal {} {
    set continuar 1
    while {$continuar} {
        puts "\n📊 MENÚ DE EJEMPLOS EN ENERGÍAS RENOVABLES:"
        puts "  1. Panel solar aislado"
        puts "  2. Aerogenerador doméstico"
        puts "  3. Banco de supercondensadores"
        puts "  4. Bomba de agua solar"
        puts "  5. Luminaria LED por microturbina"
        puts "  6. Carga de vehículo eléctrico"
        puts "  7. Celda Peltier (refrigeración pasiva)"
        puts "  0. Salir"
        puts -nonewline "\nSelecciona un ejemplo (0-7): "
        flush stdout
        gets stdin opcion

        if {$opcion == 0} {
            set continuar 0
            puts "\n🔚 Gracias por seguir la guía. Recuerda respetar siempre las normas de seguridad eléctrica."
        } else {
            mostrarEjemplo $opcion
        }
    }
}

# Ejecutar todas las secciones
mostrarIntroduccion
mostrarAdvertencias
mostrarGuiaConexion
menuPrincipal
