# Script TCL para imprimir una tabla de unidades de medida y calcular V, W y Q

# Función para imprimir la tabla de unidades
proc print_table {} {
    puts "--------------------------------------------------------------------"
    puts "| Prefijo |  Símbolo | Potencia de 10 | Exponente (Múltiplo de 3) |"
    puts "--------------------------------------------------------------------"
    set units {
        {24 Y Yotta}
        {21 Z Zetta}
        {18 E Exa}
        {15 P Peta}
        {12 T Tera}
        {9 G Giga}
        {6 M Mega}
        {3 k Kilo}
        {0 "" Unidad}
        {-3 m Mili}
        {-6 u Micro}
        {-9 n Nano}
        {-12 p Pico}
        {-15 f Femto}
        {-18 a Atto}
        {-21 z Zepto}
        {-24 y Yocto}
    }
    
    foreach unit $units {
        lassign $unit exponent symbol name
        puts [format "| %-7s | %-7s | 10^%2d       | %9d            |" $name $symbol $exponent $exponent]
    }
    puts "--------------------------------------------------------------------"
}

# Función para validar entrada numérica
proc validate_number {value} {
    if {[string is double -strict $value]} {
        return 1
    }
    return 0
}

# Función para solicitar entrada numérica validada
proc get_valid_number {message} {
    while {1} {
        puts $message
        gets stdin value
        if {[validate_number $value]} {
            return $value
        } else {
            puts "Entrada no válida. Ingrese un número válido."
        }
    }
}

# Función para solicitar cantidad de decimales
proc get_precision {} {
    puts "Ingrese la cantidad de decimales deseada en los resultados:"
    gets stdin precision
    if {[string is integer -strict $precision] && $precision >= 0} {
        return $precision
    } else {
        puts "Entrada no válida. Se usará la precisión predeterminada de 2 decimales."
        return 2
    }
}

# Función para formatear resultados
proc format_result {value precision} {
    return [format "%.*f" $precision $value]
}

# Función para calcular voltios (V = W / Q)
proc calc_volts {W Q precision} {
    if {$Q == 0} {
        return "Error: División por cero"
    }
    return [format_result [expr {$W / $Q}] $precision]
}

# Función para calcular julios (W = V * Q)
proc calc_joules {V Q precision} {
    return [format_result [expr {$V * $Q}] $precision]
}

# Función para calcular culombios (Q = W / V)
proc calc_coulombs {W V precision} {
    if {$V == 0} {
        return "Error: División por cero"
    }
    return [format_result [expr {$W / $V}] $precision]
}

# Llamamos a la función para imprimir la tabla
print_table

# Obtener precisión del usuario
set precision [get_precision]

# Función para interactuar con el usuario
proc user_prompt {} {
    while {1} {
        puts "\n¿Qué desea calcular? (voltaje, joules, coulombs, salir)"
        gets stdin choice
        
        if {$choice == "salir"} {
            puts "Saliendo del programa..."
            break
        }
        
        switch -exact $choice {
            "voltaje" {
                set Q [get_valid_number "Ingrese la carga en coulombs (Q):"]
                set expQ [get_valid_number "Ingrese el exponente para los coulombs (múltiplo de 3):"]
                set V [get_valid_number "Ingrese el voltaje en volts (V):"]
                set expV [get_valid_number "Ingrese el exponente para el voltaje (múltiplo de 3):"]
                
                set Q [expr {$Q * pow(10, $expQ)}]
                set V [expr {$V * pow(10, $expV)}]
                set W [calc_joules $V $Q $::precision]
                
                puts "\nExplicación: En ingeniería eléctrica, el trabajo (energía en julios) se calcula multiplicando el voltaje por la carga eléctrica."
                puts "El cálculo realizado fue: W = $V * $Q = $W J"
            }
            "joules" {
                set Q [get_valid_number "Ingrese la carga en coulombs (Q):"]
                set expQ [get_valid_number "Ingrese el exponente para los coulombs (múltiplo de 3):"]
                set V [get_valid_number "Ingrese el voltaje en volts (V):"]
                set expV [get_valid_number "Ingrese el exponente para el voltaje (múltiplo de 3):"]
                
                set Q [expr {$Q * pow(10, $expQ)}]
                set V [expr {$V * pow(10, $expV)}]
                set W [calc_joules $V $Q $::precision]
                
                puts "\nExplicación: La energía en julios se calcula como la cantidad de carga transportada multiplicada por el voltaje aplicado."
                puts "El cálculo realizado fue: W = $V * $Q = $W J"
            }
            "coulombs" {
                set W [get_valid_number "Ingrese la carga en julios (W):"]
                set expW [get_valid_number "Ingrese el exponente para los julios (múltiplo de 3):"]
                set V [get_valid_number "Ingrese el voltaje en volts (V):"]
                set expV [get_valid_number "Ingrese el exponente para el voltaje (múltiplo de 3):"]
                
                set W [expr {$W * pow(10, $expW)}]
                set V [expr {$V * pow(10, $expV)}]
                set Q [calc_coulombs $W $V $::precision]
                
                puts "\nExplicación: La carga eléctrica en culombios se obtiene dividiendo la energía en julios entre el voltaje aplicado."
                puts "El cálculo realizado fue: Q = $W / $V = $Q C"
            }
            default {
                puts "Opción no válida. Inténtelo de nuevo."
            }
        }
    }
}

# Ejecutar la función de interacción con el usuario
user_prompt
