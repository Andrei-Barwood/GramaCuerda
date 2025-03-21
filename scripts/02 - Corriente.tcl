proc convertir_unidades {valor unidad_origen unidad_destino} {
    array set factores {
        "A" 1 "mA" 1000 "uA" 1000000
        "C" 1 "mC" 1000 "uC" 1000000
        "s" 1 "ms" 1000 "us" 1000000
    }
    return [expr {$valor * $factores($unidad_origen) / $factores($unidad_destino)}]
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
            set I [expr {$Q / double($t)}]
            puts "Ecuación usada: I = $Q / $t"
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
            set t [expr {$Q / double($I)}]
            puts "Ecuación usada: t = $Q / $I"
        }
        default {
            puts "Opción no válida. Usa A, C o T."
            return ""
        }
    }
    return [list I $I Q $Q t $t]
}

while {1} {
    puts "¿Qué deseas calcular? (A: Amperes, C: Coulombs, T: Segundos)"
    gets stdin opcion

    puts "¿Quieres ingresar los valores manualmente o generarlos aleatoriamente? (M: Manual, A: Aleatorio)"
    gets stdin modo

    set resultado [generar_ecuacion $opcion $modo]
    if {$resultado == ""} {
        continue
    }

    array set valores $resultado

    puts "¿En qué unidad deseas la intensidad? (A, mA, uA)"
    gets stdin unidad_I
    puts "¿En qué unidad deseas la carga? (C, mC, uC)"
    gets stdin unidad_Q
    puts "¿En qué unidad deseas el tiempo? (s, ms, us)"
    gets stdin unidad_t

    set I_convertido [convertir_unidades $valores(I) "A" $unidad_I]
    set Q_convertido [convertir_unidades $valores(Q) "C" $unidad_Q]
    set t_convertido [convertir_unidades $valores(t) "s" $unidad_t]

    puts "Resultado:"
    puts "Intensidad: $I_convertido $unidad_I"
    puts "Carga: $Q_convertido $unidad_Q"
    puts "Tiempo: $t_convertido $unidad_t"

    puts "Explicación: Utilizamos la ecuación correspondiente para calcular el valor deseado."
    
    puts "¿Deseas realizar otro cálculo? (S/N)"
    gets stdin repetir
    if {[string toupper $repetir] ne "S"} {
        break
    }
}
