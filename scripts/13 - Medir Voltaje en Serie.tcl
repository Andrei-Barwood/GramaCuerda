# Script TCL: Medición de Voltaje con Multitester en el microreactor MARVEL

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

proc mostrarDescripcion {} {
    puts "📘 INTRODUCCIÓN AL MICROREACTOR MARVEL"
    puts "--------------------------------------"
    puts "MARVEL (Microreactor Application Research Validation and Evaluation) es un microreactor nuclear desarrollado por el INL (Idaho National Laboratory)."
    puts ""
    puts "Su objetivo es validar tecnologías nucleares avanzadas a pequeña escala. Funciona mediante fusión de uranio hidruro en 36 barras de combustible dentro de un núcleo moderado por hidrógeno y reflejado con berilio."
    puts ""
    puts "El calor generado se transfiere a un bucle primario de sodio-potasio (NaK) por circulación natural. Luego pasa a un lazo secundario de metal líquido eutéctico (eGaInSn), y alimenta motores Stirling que generan hasta 20 kWe."
    puts ""
    puts "No requiere bombas, ni mecanismos forzados para mover refrigerante. Usa tambores de control con BeO/B4C para regular la reactividad y un eje CIA (Central Insurance Absorber) para apagado rápido del reactor."
    esperar
}

proc mostrarEjemplo {num} {
    switch $num {
        1 {
            puts "\nEjemplo 1: Medición de sensores térmicos en el núcleo"
            puts "  🔸 Instalación: Los sensores están montados directamente sobre los canales del núcleo que contienen las barras de combustible. Se alimentan en serie desde un bus principal."
            puts "  🔸 Funcionamiento: Detectan el aumento de temperatura en el NaK y envían señales analógicas a sistemas de control."
            puts "  🔌 Voltaje estimado: 12.0 V"
        }
        2 {
            puts "\nEjemplo 2: Caída de tensión en resistencia shunt (IHX)"
            puts "  🔸 Instalación: La resistencia shunt está soldada en serie a un termopar colocado cerca del intercambiador de calor intermedio (IHX)."
            puts "  🔸 Funcionamiento: Permite medir la corriente generada por la variación térmica en el IHX, ayudando a calcular flujo térmico."
            puts "  🔌 Voltaje estimado: 0.6 V"
        }
        3 {
            puts "\nEjemplo 3: Tensión en bobina del tambor de control (BeO + B4C)"
            puts "  🔸 Instalación: La bobina está integrada al sistema electromecánico que rota los tambores de moderación/reflexión alrededor del núcleo."
            puts "  🔸 Funcionamiento: La corriente en la bobina permite el ajuste de posición de los tambores para regular la reactividad nuclear."
            puts "  🔌 Voltaje estimado: 24.0 V"
        }
        4 {
            puts "\nEjemplo 4: Voltaje del actuador del CIA (absorbedor central)"
            puts "  🔸 Instalación: El CIA está montado verticalmente en el centro del núcleo y conectado a un actuador electromecánico en serie con el panel de seguridad."
            puts "  🔸 Funcionamiento: Al energizar el actuador, el CIA puede ser insertado rápidamente para detener la reacción nuclear."
            puts "  🔌 Voltaje estimado: 48.0 V"
        }
        5 {
            puts "\nEjemplo 5: Diodo de protección en monitoreo eGaInSn"
            puts "  🔸 Instalación: Un diodo térmico está montado en serie con sensores de monitoreo en las tuberías de metal líquido del lazo secundario."
            puts "  🔸 Funcionamiento: Protege la instrumentación de sobrecargas térmicas; su caída de voltaje indica si está conduciendo adecuadamente."
            puts "  🔌 Voltaje estimado: 1.1 V"
        }
        6 {
            puts "\nEjemplo 6: Verificación de tensión en un motor Stirling"
            puts "  🔸 Instalación: Cada uno de los 4 motores Stirling está conectado a un lazo secundario y se alimenta desde un controlador de carga DC."
            puts "  🔸 Funcionamiento: Convierte el calor del eGaInSn en energía eléctrica entre 5–7 kWe por unidad."
            puts "  🔌 Voltaje estimado: 28.0 V"
        }
        7 {
            puts "\nEjemplo 7: Voltaje en sistema de sensores redundantes (emergencia)"
            puts "  🔸 Instalación: Los sensores pasivos de seguridad están alimentados por una red redundante de baterías conectadas en serie."
            puts "  🔸 Funcionamiento: Se activan automáticamente en caso de pérdida de energía principal, para asegurar monitoreo continuo del reactor."
            puts "  🔌 Voltaje estimado: 12.0 V"
        }
        default {
            puts "⚠️ Opción no válida. Intenta de nuevo."
        }
    }
    esperar
}

proc mostrarConexionMultitester {} {
    puts "\n📐 GUÍA: Cómo medir voltaje con un multitester en un circuito en serie"
    puts "-----------------------------------------------------------------------"
    puts "⚠️ IMPORTANTE: El voltaje se mide conectando el multitester EN PARALELO al componente, incluso si el circuito completo está conectado en SERIE."
    esperar
    puts "🔹 Paso 1: Verifica que el circuito esté energizado (activo). El multitester no medirá voltaje si no hay diferencia de potencial."
    esperar
    puts "🔹 Paso 2: Ajusta el multitester al modo de voltaje DC (V⎓). Usa el rango más alto si no conoces el valor aproximado."
    esperar
    puts "🔹 Paso 3: Identifica el componente donde deseas medir el voltaje (ej: sensor térmico, motor, resistencia shunt, etc)."
    esperar
    puts "🔹 Paso 4: Conecta la punta NEGRA (COM) del multitester a un punto de referencia del circuito, generalmente tierra o el polo negativo de la fuente."
    esperar
    puts "🔹 Paso 5: Conecta la punta ROJA a la terminal positiva del componente que quieres medir. Así estás en paralelo con dicho componente."
    esperar
    puts "🔹 Paso 6: Lee el valor en la pantalla del multitester. Representa la caída de tensión a través del componente."
    esperar
    puts "✅ Al estar conectado en paralelo, el multitester detecta la diferencia de potencial ENTRE los dos extremos del componente sin alterar el flujo de corriente del circuito."
    esperar
}


# Menú principal
proc menuPrincipal {} {
    set continuar 1
    while {$continuar} {
        puts "\n📊 MENÚ DE EJEMPLOS DE MEDICIÓN EN MARVEL:"
        puts "  1. Sensores térmicos del núcleo"
        puts "  2. Shunt y termopar en IHX"
        puts "  3. Bobina del tambor de control"
        puts "  4. Actuador del CIA (apagado de emergencia)"
        puts "  5. Diodo en monitoreo del lazo eGaInSn"
        puts "  6. Motor Stirling"
        puts "  7. Sistema de sensores redundantes"
        puts "  0. Salir"
        puts -nonewline "\nSelecciona un ejemplo (0-7): "
        flush stdout
        gets stdin opcion

        if {$opcion == 0} {
            set continuar 0
            puts "\n🔚 Gracias por usar la guía MARVEL. Sigue los protocolos de seguridad."
        } else {
            mostrarEjemplo $opcion
        }
    }
}

# Inicio del programa
mostrarDescripcion
instruccion "A continuación veamos cómo medir voltaje en serie usando un multitester."
instruccion "Recuerda que el multitester debe estar en modo voltímetro, y siempre se conecta en paralelo con el componente, aunque esté en un circuito serie."
mostrarConexionMultitester
menuPrincipal
