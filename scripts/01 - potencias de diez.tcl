#!/usr/bin/env tclsh

# Función para verificar si un valor es un número entero positivo
proc es_entero_positivo {valor} {
    return [regexp {^[1-9][0-9]*$} $valor]
}

# Función para describir el tipo de fracción en base al exponente
proc explicar_exponente {exponente} {
    if {$exponente == 1} {
        return "décima (0.1)"
    } elseif {$exponente == 2} {
        return "centésima (0.01)"
    } elseif {$exponente == 3} {
        return "milésima (0.001)"
    } elseif {$exponente == 4} {
        return "diezmilésima (0.0001)"
    } elseif {$exponente == 5} {
        return "centésima de diezmilésima (0.00001)"
    } elseif {$exponente == 6} {
        return "millonesima (0.000001)"
    } elseif {$exponente == -1} {
        return "décima (10)"
    } elseif {$exponente == -2} {
        return "centésima (100)"
    } elseif {$exponente == -3} {
        return "milésima (1000)"
    } elseif {$exponente == -4} {
        return "diezmilésima (10000)"
    } elseif {$exponente == -5} {
        return "centésima de diezmilésima (100000)"
    } elseif {$exponente == -6} {
        return "millonesima (1000000)"
    } else {
        return "No hay una descripción estándar para este exponente."
    }
}

# Pedir al usuario que ingrese un exponente
puts "🔢 Ingresa el exponente de la potencia de 10 (o presiona Enter para elegir uno aleatorio):"
gets stdin exponente

# Si el usuario no ingresa nada, generar un exponente aleatorio (1 a 6)
if {$exponente eq "" || ![es_entero_positivo $exponente]} {
    set exponente [expr {int(rand() * 6) + 1}]
    puts "⚡ Se ha generado un exponente aleatorio: $exponente"
}

# Construcción de la ecuación en dos formas
set fraccion "1/10^$exponente"
set exponente_negativo "10^-$exponente"

# Obtener la descripción de la fracción
set descripcion [explicar_exponente $exponente]

# Mostrar resultados al usuario
puts "\n🌟 Ecuación generada:"
puts "   $fraccion = $exponente_negativo"
puts "\n📌 Regla: Cuando movemos una potencia del denominador al numerador, cambiamos el signo del exponente."

# Explicar el tipo de fracción
puts "\n🔍 Explicación:"
puts "   La fracción $fraccion representa una fracción de tipo: $descripcion"
