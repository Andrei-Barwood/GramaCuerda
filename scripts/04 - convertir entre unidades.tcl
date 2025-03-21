# Tabla de unidades de ingeniería eléctrica
dict set unidades "yotta" 24
        dict set unidades "zetta" 21
        dict set unidades "exa" 18
        dict set unidades "peta" 15
        dict set unidades "tera" 12
        dict set unidades "giga" 9
        dict set unidades "mega" 6
        dict set unidades "kilo" 3
        dict set unidades "hecto" 2
        dict set unidades "deca" 1
        dict set unidades "unidad" 0
        dict set unidades "deci" -1
        dict set unidades "centi" -2
        dict set unidades "mili" -3
        dict set unidades "micro" -6
        dict set unidades "nano" -9
        dict set unidades "pico" -12
        dict set unidades "femto" -15
        dict set unidades "atto" -18
        dict set unidades "zepto" -21
        dict set unidades "yocto" -24

# Imprimir la tabla de unidades
puts "Unidades de ingeniería eléctrica:"
dict for {nombre exponente} $unidades {
    puts "$nombre -> 10^$exponente"
}

# Función para leer entrada numérica
proc to_number {input} {
    if {[string is double -strict $input]} {
        return $input
    } else {
        puts "Error: Entrada inválida. Debe ser un número."
        exit 1
    }
}

# Solicitar entrada al usuario
puts "Ingrese la cantidad a convertir:"
gets stdin cantidad
set cantidad [to_number $cantidad]

puts "Ingrese el exponente de la cantidad (potencia de 10):"
gets stdin exp_origen
set exp_origen [to_number $exp_origen]

puts "Ingrese el exponente de la unidad destino (potencia de 10):"
gets stdin exp_destino
set exp_destino [to_number $exp_destino]

# Calcular conversión
set resultado [expr {$cantidad * pow(10, $exp_origen - $exp_destino)}]

# Mostrar resultado
puts "El resultado de la conversión es: $resultado"
