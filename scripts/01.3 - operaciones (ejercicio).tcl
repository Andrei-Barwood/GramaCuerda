# Script TCL para Ejercitar Operaciones y Notación Científica

# Función para convertir un número a notación científica (a * 10^b)
# Devuelve una lista {mantisa exponente}
proc to_scientific {num} {
    set num_str [string trim $num]
    if {$num_str eq "0"} {
        return {0 0}
    }

    set sign ""
    if {[string index $num_str 0] eq "-"} {
        set sign "-"
        set num_str [string range $num_str 1 end]
    }

    set exp 0
    set mantisa [string trim $num_str]

    # Convertir a flotante para manejar bien decimales y números grandes
    set val [expr {double($mantisa)}]

    if {$val >= 10.0} {
        while {$val >= 10.0} {
            set val [expr {$val / 10.0}]
            incr exp
        }
    } elseif {$val < 1.0 && $val > 0} {
        while {$val < 1.0} {
            set val [expr {$val * 10.0}]
            incr exp -1
        }
    }
    
    # Redondear la mantisa a 3 decimales para el ejercicio
    set mantisa_formato [format "%.3f" $val]
    # Si la mantisa es 10.000, significa que se pasó un poco, ajustarla
    if {[expr {abs(double($mantisa_formato)) >= 10.0 - 0.00001}] && $exp != 0} {
        set mantisa_formato [format "%.3f" [expr {$val / 10.0}]]
        incr exp 1
    }

    # Construir la mantisa final, incluyendo el signo si existe
    if {$sign eq "-"} {
        set final_mantisa "-$mantisa_formato"
    } else {
        set final_mantisa $mantisa_formato
    }

    # ¡LA CORRECCIÓN ESTÁ AQUÍ! Usa 'list' para asegurar que los VALORES sean devueltos como elementos de la lista
    return [list $final_mantisa $exp]
}

# Formatea el exponente a palabras para mejor legibilidad en terminales
proc format_exponent_as_words {exponent} {
    if {$exponent eq "0"} {
        return "a la cero"
    } elseif {$exponent > 0} {
        return "a la $exponent"
    } else {
        set abs_exponent [string trimleft $exponent "-"]
        return "a la menos $abs_exponent"
    }
}


# Función principal del ejercicio
proc ejercitar_notacion_cientifica {} {
    puts "---"
    puts "## ¡Desafío Matemático: Operaciones con Potencias de Diez!"
    puts "---"
    puts "¡Hola! Hoy vamos a practicar sumas y restas combinando números grandes y pequeños."
    puts "El reto es que elijas la opción que exprese el resultado **correctamente como potencia de diez**."
    puts "¡Prepara tu mente para los números y las exponenciales!"
    puts ""

    # Lista de ejercicios: {operación_en_texto} {operacion_para_expr} {explicacion_extra}
    set ejercicios {
        {"4200 + 6.800.000" "4200 + 6800000" "¡Buena observación! El resultado de 6.800.000 + 4200 es 6.804.200. Para expresarlo en notación científica, movemos el punto decimal imaginario desde el final hasta que solo quede **un dígito diferente de cero antes del punto**. En este caso, el número 6.804.200 se convierte en 6.8042. Como movimos el punto 6 posiciones a la izquierda, el exponente es **10 a la 6**."}
        {"9 * 10^4 + 3.6 * 10^3" "9e4 + 3.6e3" "Aquí sumamos dos números ya en notación científica. Una estrategia es convertirlos a la misma potencia de diez o a su valor decimal completo. 9 x 10^4 es 90.000 y 3.6 x 10^3 es 3.600. La suma es 93.600. Para la notación científica, lo reescribimos como 9.36 x 10.000, lo que significa **9.36 x 10 a la 4**. Fíjate cómo movimos el punto para tener un solo dígito antes de él."}
        {"0.5 * 10^-3 - 6 * 10^-5" "0.5e-3 - 6e-5" "Una resta de números pequeños. 0.5 x 10^-3 es 0.0005 y 6 x 10^-5 es 0.00006. La resta da 0.00044. Para expresarlo en notación científica estándar, movemos el punto decimal a la derecha hasta que el primer dígito significativo quede **justo antes del punto**. En 0.00044, movemos el punto 4 posiciones a la derecha para obtener 4.4. Como movimos el punto a la derecha, el exponente es negativo: **10 a la menos 4**."}
        {"1.2 * 10^3 + 50000 * 10^-3 - 0.006 * 10^5" "1.2e3 + 50000e-3 - 0.006e5" "¡Este es el desafío final! Convertimos cada término a su valor decimal: 1.2 x 10^3 = 1200; 50000 x 10^-3 = 50; 0.006 x 10^5 = 600. La operación es 1200 + 50 - 600 = 650. Para 650 en notación científica, movemos el punto decimal imaginario (al final del 650) **dos posiciones a la izquierda** para tener 6.50. Esto nos da un exponente de **10 a la 2**."}
    }

    set contador_correctas 0
    set total_ejercicios [llength $ejercicios]

    foreach ejercicio $ejercicios {
        set operacion_texto [lindex $ejercicio 0]
        set operacion_expr [lindex $ejercicio 1]
        set explicacion_extra [lindex $ejercicio 2]

        puts "--------------------------------------------------"
        puts ">> ¡Calcula el resultado de la siguiente operación!"
        puts "   Operación: **$operacion_texto**"
        puts ""
        puts "Elige la opción que expresa el resultado correctamente en notación científica:"
        puts ""

        # Calcular el resultado correcto
        set resultado_decimal [expr $operacion_expr]
        set cientifico_correcto [to_scientific $resultado_decimal]
        
        set mantisa_correcta [lindex $cientifico_correcto 0]
        set exponente_correcto [lindex $cientifico_correcto 1]
        
        set exponente_palabras [format_exponent_as_words $exponente_correcto]
        set opcion_correcta_str "${mantisa_correcta} x 10 ${exponente_palabras}"

        # Generar una opción incorrecta
        set opciones_generadas {}
        lappend opciones_generadas $opcion_correcta_str

        set tipo_error [expr {int(rand() * 2)}]

        if {$tipo_error == 0} {
            set opcion_incorrecta_str [format "%.5f" $resultado_decimal]
            if {$opcion_incorrecta_str eq $opcion_correcta_str} {
                set opcion_incorrecta_str [format "%.4e" [expr {$resultado_decimal * 1.001}]]
            }
        } else {
            set exponente_incorrecto [expr {$exponente_correcto + (int(rand() * 2) * 2 - 1) * (1 + int(rand() * 2))}]
            set mantisa_incorrecta_val [expr {double($mantisa_correcta) * (1 + (rand() - 0.5) * 0.2)}]
            set mantisa_incorrecta [format "%.3f" $mantisa_incorrecta_val]
            
            if {[expr {abs($mantisa_incorrecta_val) < 0.001}] && $resultado_decimal != 0} {
                 set mantisa_incorrecta [format "%.3f" [expr {double($mantisa_correcta) * (1 + 0.1)}]]
            }
            
            set exponente_incorrecto_palabras [format_exponent_as_words $exponente_incorrecto]
            set opcion_incorrecta_str "${mantisa_incorrecta} x 10 ${exponente_incorrecto_palabras}"
            if {$opcion_incorrecta_str eq $opcion_correcta_str} {
                 set opcion_incorrecta_str [format "%.4e" [expr {$resultado_decimal * 1.001}]]
            }
        }
        
        lappend opciones_generadas $opcion_incorrecta_str

        set opciones_mezcladas $opciones_generadas

        set i 1
        foreach opcion $opciones_mezcladas {
            puts "  $i) $opcion"
            incr i
        }
        puts ""

        set intento_valido 0
        while {$intento_valido == 0} {
            puts -nonewline "Tu elección (1 o 2): "
            gets stdin respuesta_usuario
            if {[string is integer $respuesta_usuario] && $respuesta_usuario >= 1 && $respuesta_usuario <= 2} {
                set intento_valido 1
            } else {
                puts "❌ ¡Uhm, esa no es una opción válida! Por favor, solo ingresa 1 o 2."
            }
        }

        set eleccion_usuario [lindex $opciones_mezcladas [expr {$respuesta_usuario - 1}]]

        if {$eleccion_usuario eq $opcion_correcta_str} {
            puts "🎉 ¡BRAVO! Tu respuesta es completamente **correcta**."
            puts "El resultado de **$operacion_texto** es **$opcion_correcta_str**."
            puts "¡Excelente manejo de las potencias de diez!"
            incr contador_correctas
        } else {
            puts "😕 ¡No es la opción correcta esta vez!"
            puts "El resultado de **$operacion_texto** es **$opcion_correcta_str**."
            puts "Veamos por qué:"
            puts "$explicacion_extra" ;# Ahora $explicacion_extra contiene la explicación detallada
            puts "💡 **Recuerda:** La regla de oro en notación científica es tener **un solo dígito distinto de cero antes del punto decimal**. El exponente te dice cuántas veces y en qué dirección moviste el punto para lograrlo."
            puts ""
        }
        puts ""
    }

    puts "---"
    puts "## ¡Resultados de tus Operaciones!"
    puts "---"
    puts "Has resuelto correctamente $contador_correctas de $total_ejercicios operaciones."
    puts "¡Sigue practicando para convertirte en un maestro de la notación científica!"
    puts "---"
}

# Llama a la función principal para iniciar el script
ejercitar_notacion_cientifica