# Script TCL: Cómo medir resistencia en un circuito en serie con multitester
# Aplicado a energías renovables no convencionales (ERNC)

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
    puts "📗 GUÍA: Medición de Resistencia en Circuitos en Serie"
    puts "------------------------------------------------------"
    puts "Esta guía explica cómo medir la resistencia total o parcial en un circuito en serie,"
    puts "muy útil para diagnósticos en sistemas de energías renovables no convencionales."
    esperar
}

proc mostrarAdvertencias {} {
    puts "⚠️ ADVERTENCIAS IMPORTANTES:"
    puts "-----------------------------"
    instruccion "1. ¡Apaga y desconecta el circuito antes de medir resistencia para evitar daños y lecturas erróneas!"
    instruccion "2. Cuando mides resistencia en serie, el valor es la suma de las resistencias individuales."
    instruccion "3. No midas resistencia con el circuito energizado."
    instruccion "4. Desconecta componentes en paralelo para obtener mediciones precisas en serie."
    instruccion "5. Asegúrate de buen contacto y limpia terminales antes de medir."
}

proc mostrarGuiaConexion {} {
    puts "🧰 PASOS PARA MEDIR RESISTENCIA EN CIRCUITOS EN SERIE:"
    puts "-----------------------------------------------------"
    instruccion "1. Apaga y desconecta completamente el circuito."
    instruccion "2. Identifica la sección del circuito en serie que quieres medir."
    instruccion "3. Si hay ramas en paralelo, desconéctalas para aislar el tramo."
    instruccion "4. Gira la perilla del multitester a la escala de ohmios (Ω)."
    instruccion "5. Conecta la punta negra al puerto COM y la roja al puerto Ω."
    instruccion "6. Coloca las puntas en los dos extremos del tramo en serie seleccionado."
    instruccion "7. Lee el valor mostrado, que corresponde a la suma de resistencias en ese tramo."
    instruccion "8. Compara con los valores esperados para detectar anomalías."
}

proc mostrarEjemplo {num} {
    switch $num {
        1 {
            puts "\nEjemplo 1: Resistencia total en serie en panel solar con módulos conectados"
            puts "  🔸 Se mide resistencia desde la entrada del primer módulo hasta salida del último."
            puts "  🔸 Detecta problemas de conexión o degradación en módulos."
            puts "  🔸 Valor esperado: suma de resistencias individuales, típicamente algunos ohmios."
        }
        2 {
            puts "\nEjemplo 2: Medición en serie de bobinas de freno regenerativo en aerogenerador"
            puts "  🔸 Mide resistencia total entre terminales en serie del sistema de frenado."
            puts "  🔸 Valor esperado: suma de resistencias entre 3 y 15 Ω."
        }
        3 {
            puts "\nEjemplo 3: Medición de resistencia total en cableado serie en campo solar"
            puts "  🔸 Mide resistencia del cableado que conecta varios paneles en serie."
            puts "  🔸 Valores bajos indican buen estado del cableado."
            puts "  🔸 Valores altos pueden indicar daños o corrosión."
        }
        4 {
            puts "\nEjemplo 4: Medición en serie de resistencias térmicas en sensores para sistemas solares"
            puts "  🔸 Se mide resistencia total de sensores conectados en serie para monitoreo térmico."
            puts "  🔸 Valores esperados dependen de la suma de termistores o RTDs."
        }
        5 {
            puts "\nEjemplo 5: Resistencia en serie de devanados de motor brushless hidráulico"
            puts "  🔸 Mide resistencia total combinada en devanados en serie para diagnosticar daños."
            puts "  🔸 Valores consistentes indican buen estado."
        }
        6 {
            puts "\nEjemplo 6: Medición en serie de resistencias de cargas resistivas solares"
            puts "  🔸 Se mide resistencia total del banco de cargas conectadas en serie."
            puts "  🔸 Permite verificar uniformidad y estado del banco."
        }
        7 {
            puts "\nEjemplo 7: Medición en serie de fusibles solares conectados para protección"
            puts "  🔸 Mide resistencia total de fusibles en serie."
            puts "  🔸 Valores cercanos a cero indican fusibles intactos."
            puts "  🔸 Valores altos o abiertos indican fusibles fundidos."
        }
        default {
            puts "⚠️ Opción inválida. Intenta de nuevo."
        }
    }
    esperar
}

proc menuPrincipal {} {
    set continuar 1
    while {$continuar} {
        puts "\n📋 MENÚ DE EJEMPLOS: Medición de Resistencia en Circuitos en Serie (ERNC)"
        puts "  1. Panel solar (módulos en serie)"
        puts "  2. Bobinas de freno regenerativo"
        puts "  3. Cableado serie en campo solar"
        puts "  4. Sensores térmicos en serie"
        puts "  5. Devanados motor brushless hidráulico"
        puts "  6. Cargas resistivas solares"
        puts "  7. Fusibles solares en serie"
        puts "  0. Salir"
        puts -nonewline "\nSelecciona un ejemplo (0-7): "
        flush stdout
        gets stdin opcion

        if {$opcion == 0} {
            set continuar 0
            puts "\n✅ Gracias por usar la guía para medir resistencia en serie. Mantén siempre la seguridad."
        } else {
            mostrarEjemplo $opcion
        }
    }
}

# Ejecución principal
mostrarIntroduccion
mostrarAdvertencias
mostrarGuiaConexion
menuPrincipal
