proc convertir_unidades {valor unidad_origen exponente_origen unidad_destino exponente_destino} {
    array set factores {
        "A" 1 "mA" 1000 "uA" 1000000
        "C" 1 "mC" 1000 "uC" 1000000
        "s" 1 "ms" 1000 "us" 1000000
    }

    # Check if the origin unit exists in the array before attempting to access it.
    if {![info exists factores($unidad_origen)]} {
        puts "Error: Unidad de origen '$unidad_origen' no válida."
        return -code error "Unidad de origen no válida"
    }

    # Check if the destination unit exists in the array before attempting to access it.
    if {![info exists factores($unidad_destino)]} {
        puts "Error: Unidad de destino '$unidad_destino' no válida."
        return -code error "Unidad de destino no válida"
    }

    # Calculate the factor for the unit conversion based on the exponents
    set factor_conversion [expr {($factores($unidad_destino) / $factores($unidad_origen)) * pow(10.0, [expr {$exponente_origen - $exponente_destino}])}]

    return [expr {$valor * $factor_conversion}]
}

proc es_numero {valor} {
    return [regexp {^[0-9]+(\.[0-9]+)?$} $valor]
}

proc solicitar_valor {mensaje} {
    while {1} {
        puts $mensaje
        gets stdin valor
        if {[es_numero $valor]} {
            return $valor
        } else {
            puts "Error: Debes ingresar un número válido."
        }
    }
}

proc solicitar_exponente {mensaje} {
    while {1} {
        puts $mensaje
        gets stdin exponente
        if {[regexp {^[-+]?[0-9]+$} $exponente]} {
            # Asegurarse de que el exponente es múltiplo de 3
            if {[expr {$exponente % 3 == 0}]} {
                return $exponente
            } else {
                puts "Error: El exponente debe ser un múltiplo de 3."
            }
        } else {
            puts "Error: Debes ingresar un número válido."
        }
    }
}

proc format_engineering {value} {
    if {$value == 0} {
        return "0"
    }

    set abs_value [expr {abs($value)}]
    set exponent 0

    while {$abs_value >= 1000.0} {
        set abs_value [expr {$abs_value / 1000.0}]
        incr exponent 3
    }

    while {$abs_value < 1.0 && $abs_value > 0} {
        set abs_value [expr {$abs_value * 1000.0}]
        incr exponent -3
    }

    set mantissa [format "%.3f" $abs_value]
    set sign ""
    if {$value < 0} {
        set sign "-"
    }

    switch $exponent {
        -18 {set prefix "a"}
        -15 {set prefix "f"}
        -12 {set prefix "p"}
        -9  {set prefix "n"}
        -6  {set prefix "u"}
        -3  {set prefix "m"}
        0   {set prefix ""}
        3   {set prefix "k"}
        6   {set prefix "M"}
        9   {set prefix "G"}
        12 {set prefix "T"}
        15 {set prefix "P"}
        18 {set prefix "E"}
        default { set prefix "*10^$exponent"}
    }

    return "$sign$mantissa$prefix"
}

proc generar_ecuacion {opcion modo} {
    switch [string toupper $opcion] {
        A {
            if {$modo == "M"} {
                set Q [solicitar_valor "Ingresa la carga en Coulombs:"]
                set t [solicitar_valor "Ingresa el tiempo en segundos:"]
                if {$t == 0} {
                    puts "Error: El tiempo no puede ser 0."
                    return ""
                }
            } else {
                set Q [expr {int(rand()*100) + 1}]
                set t [expr {int(rand()*10) + 1}]
            }
            set I [expr {$Q / $t}] ;# Remove double, it was redundant
            puts "Ecuación usada: I = $Q / $t"
            set ecuacion "I = Q / t"
        }
        C {
            if {$modo == "M"} {
                set I [solicitar_valor "Ingresa la intensidad en Amperes:"]
                set t [solicitar_valor "Ingresa el tiempo en segundos:"]
            } else {
                set I [expr {int(rand()*10) + 1}]
                set t [expr {int(rand()*10) + 1}]
            }
            set Q [expr {$I * $t}]
            puts "Ecuación usada: Q = $I * $t"
            set ecuacion "Q = I * t"
        }
        T {
            if {$modo == "M"} {
                set Q [solicitar_valor "Ingresa la carga en Coulombs:"]
                set I [solicitar_valor "Ingresa la intensidad en Amperes:"]
                if {$I == 0} {
                    puts "Error: La intensidad no puede ser 0."
                    return ""
                }
            } else {
                set Q [expr {int(rand()*100) + 1}]
                set I [expr {int(rand()*10) + 1}]
            }
            set t [expr {$Q / $I}]; # Remove double, it was redundant
            puts "Ecuación usada: t = $Q / $I"
            set ecuacion "t = Q / I"
        }
        default {
            puts "Opción no válida. Usa A, C o T."
            return ""
        }
    }
    return [list I $I Q $Q t $t ecuacion $ecuacion]
}

proc format_number_with_exponent {value exponent} {
    # Handle the case of zero
    if {$value == 0} {
        return "0"
    }
    
    set number_string [format "%.9f" $value] ;# Increased precision to 9 digits.
    set dot_position [string first "." $number_string]
    if {$dot_position == -1} {
        set number_string "${number_string}."
        set dot_position [string length $number_string]
    }

    # remove the point
    set number_string [string map {. ""} $number_string]
    
    # Apply exponent shift
    if {$exponent > 0} {
        # Shift the decimal point to the left
        set new_dot_position [expr {$dot_position - $exponent}]
        #add n ceros to the left
        if {$new_dot_position <= 0} {
            set zeros [string repeat "0" [expr {-$new_dot_position+1}]]
            set number_string "${zeros}${number_string}"
            set new_dot_position 1
        }
    } elseif {$exponent < 0} {
        # Shift the decimal point to the right
        set new_dot_position [expr {$dot_position - $exponent}]
        #add n ceros to the right
        if {$new_dot_position > [string length $number_string]} {
            set zeros [string repeat "0" [expr {$new_dot_position-[string length $number_string]}]]
            set number_string "${number_string}${zeros}"
        }
         
    } else {
       set new_dot_position $dot_position
    }
    
    # Insert the decimal point
    set result [string range $number_string 0 [expr {$new_dot_position-1}]]. [string range $number_string $new_dot_position end]
    # truncate the result.
    set dot_pos [string first "." $result]
    if {$dot_pos != -1} {
        set decimal_part [string range $result [expr {$dot_pos + 1}] end]
        set truncated_decimal [string range $decimal_part 0 2]
        set result [string range $result 0 $dot_pos].$truncated_decimal
    }
    return $result
}

# New procedure to print the table
proc print_engineering_prefixes {} {
    puts "Tabla de Prefijos de Ingeniería Eléctrica:"
    puts "+-----------------+-----------------+-----------------+"
    puts "| Prefijo         | Símbolo         | Exponente       |"
    puts "+-----------------+-----------------+-----------------+"
    puts "| Exa             | E               | 10^18           |"
    puts "| Peta            | P               | 10^15           |"
    puts "| Tera            | T               | 10^12           |"
    puts "| Giga            | G               | 10^9            |"
    puts "| Mega            | M               | 10^6            |"
    puts "| kilo            | k               | 10^3            |"
    puts "| (unidad base)   | (sin prefijo)   | 10^0            |"
    puts "| mili            | m               | 10^-3           |"
    puts "| micro           | u               | 10^-6           |"
    puts "| nano            | n               | 10^-9           |"
    puts "| pico            | p               | 10^-12          |"
    puts "| femto           | f               | 10^-15          |"
    puts "| atto            | a               | 10^-18          |"
    puts "+-----------------+-----------------+-----------------+"
}

while {1} {
    # Print the table at the beginning of each loop iteration
    print_engineering_prefixes

    puts "¿Qué deseas calcular? (A: Amperes, C: Coulombs, T: Segundos)"
    gets stdin opcion
    set opcion [string toupper $opcion]  ;# Convertir la opción a mayúsculas

    puts "¿Quieres ingresar los valores manualmente o generarlos aleatoriamente? (M: Manual, A: Aleatorio)"
    gets stdin modo
    set modo [string toupper $modo]  ;# Convertir el modo a mayúsculas

    set resultado [generar_ecuacion $opcion $modo]
    if {$resultado == ""} {
        continue
    }

    array set valores $resultado

    # Solicitar exponente para cada unidad.
    puts "¿Qué exponente deseas para la intensidad? (A: 0, mA: -3, uA: -6)"
    set exponente_I [solicitar_exponente "Ingresa el exponente para la intensidad:"]
    puts "¿Qué exponente deseas para la carga? (C: 0, mC: -3, uC: -6)"
    set exponente_Q [solicitar_exponente "Ingresa el exponente para la carga:"]
    puts "¿Qué exponente deseas para el tiempo? (s: 0, ms: -3, us: -6)"
    set exponente_t [solicitar_exponente "Ingresa el exponente para el tiempo:"]

    # Define units based on exponent selection, default to base unit if exponent is not in the option list
    if {$exponente_I == 0} {
        set unidad_I "A"
    } elseif {$exponente_I == -3} {
        set unidad_I "mA"
    } elseif {$exponente_I == -6} {
        set unidad_I "uA"
    } else {
        set unidad_I "A"
    }

    if {$exponente_Q == 0} {
        set unidad_Q "C"
    } elseif {$exponente_Q == -3} {
        set unidad_Q "mC"
    } elseif {$exponente_Q == -6} {
        set unidad_Q "uC"
    } else {
        set unidad_Q "C"
    }

    if {$exponente_t == 0} {
        set unidad_t "s"
    } elseif {$exponente_t == -3} {
        set unidad_t "ms"
    } elseif {$exponente_t == -6} {
        set unidad_t "us"
    } else {
        set unidad_t "s"
    }


    #fixed order of operations in convert_unidades
    set I_convertido [catch {convertir_unidades $valores(I) "A" 0 $unidad_I $exponente_I} error_message]
    if {$I_convertido != 0} {
        puts "Error al convertir la intensidad: $error_message"
        continue
    }
    set Q_convertido [catch {convertir_unidades $valores(Q) "C" 0 $unidad_Q $exponente_Q} error_message]
    if {$Q_convertido != 0} {
        puts "Error al convertir la carga: $error_message"
        continue
    }
    set t_convertido [catch {convertir_unidades $valores(t) "s" 0 $unidad_t $exponente_t} error_message]
    if {$t_convertido != 0} {
        puts "Error al convertir el tiempo: $error_message"
        continue
    }
    #Engineering notation
    set I_engineering [format_engineering $valores(I)]
    set Q_engineering [format_engineering $valores(Q)]
    set t_engineering [format_engineering $valores(t)]
    
    set I_final [format_number_with_exponent $I_convertido $exponente_I]
    set Q_final [format_number_with_exponent $Q_convertido $exponente_Q]
    set t_final [format_number_with_exponent $t_convertido $exponente_t]

    puts "Resultado:"
    puts "Intensidad: $I_final $unidad_I (en base $I_engineering A)"
    puts "Carga: $Q_final $unidad_Q (en base $Q_engineering C)"
    puts "Tiempo: $t_final $unidad_t (en base $t_engineering s)"

    # Detailed explanation
    puts "Explicación:"
    puts "1. Se utilizó la ecuación: $valores(ecuacion)"
    switch $valores(ecuacion) {
        "I = Q / t" {
            puts "2. Donde Q representa la carga en Coulombs y t el tiempo en segundos."
            puts "3. Para calcular la intensidad, se dividió el valor de la carga ($valores(Q)) entre el valor del tiempo ($valores(t))."
            set I_pre_conversion [format_engineering $valores(I)]
            puts "4. El resultado de esta división es $I_pre_conversion Amperes."
        }
        "Q = I * t" {
            puts "2. Donde I representa la intensidad en Amperes y t el tiempo en segundos."
            puts "3. Para calcular la carga, se multiplicó el valor de la intensidad ($valores(I)) por el valor del tiempo ($valores(t))."
            set Q_pre_conversion [format_engineering $valores(Q)]
            puts "4. El resultado de esta multiplicación es $Q_pre_conversion Coulombs."
        }
        "t = Q / I" {
            puts "2. Donde Q representa la carga en Coulombs e I la intensidad en Amperes."
            puts "3. Para calcular el tiempo, se dividió el valor de la carga ($valores(Q)) entre el valor de la intensidad ($valores(I))."
            set t_pre_conversion [format_engineering $valores(t)]
            puts "4. El resultado de esta división es $t_pre_conversion segundos."
        }
    }
    puts "5. Luego se realizaron las conversiones de unidades:"
    puts "   - La intensidad, de Amperes a $unidad_I, aplicando un desplazamiento del punto decimal de $exponente_I unidades."
    puts "   - La carga, de Coulombs a $unidad_Q, aplicando un desplazamiento del punto decimal de $exponente_Q unidades."
    puts "   - El tiempo, de segundos a $unidad_t, aplicando un desplazamiento del punto decimal de $exponente_t unidades."


    puts "¿Deseas realizar otro cálculo? (S/N)"
    gets stdin repetir
    set repetir [string toupper $repetir]  ;# Convertir la respuesta a mayúsculas
    if {[string toupper $repetir] ne "S"} {
        break
    }
}
