# electricidad_renovable.tcl

proc convertir_unidades {valor unidad_origen unidad_destino} {
    array set factores {
        "A" 1 "mA" 1000 "uA" 1000000
        "C" 1 "mC" 1000 "uC" 1000000
        "s" 1 "ms" 1000 "us" 1000000
    }
    return [expr {$valor * $factores($unidad_origen) / $factores($unidad_destino)}]
}

proc generar_ejemplo_renovable {contexto} {
    set Q [expr {rand()*100 + 1}]   ;# carga en C
    set t [expr {rand()*10 + 1}]    ;# tiempo en s
    set I [expr {$Q / $t}]

    set unidades_I {A mA uA}
    set unidades_Q {C mC uC}
    set unidades_t {s ms us}

    set unidad_I [lindex $unidades_I [expr {int(rand()*3)}]]
    set unidad_Q [lindex $unidades_Q [expr {int(rand()*3)}]]
    set unidad_t [lindex $unidades_t [expr {int(rand()*3)}]]

    set I_conv [convertir_unidades $I "A" $unidad_I]
    set Q_conv [convertir_unidades $Q "C" $unidad_Q]
    set t_conv [convertir_unidades $t "s" $unidad_t]

    puts "Caso: $contexto"
    puts "  Ecuación: I = Q / t"
    puts "  Datos: Q = [format %.2f $Q_conv] $unidad_Q, t = [format %.2f $t_conv] $unidad_t"
    puts "  Resultado: I = [format %.2f $I_conv] $unidad_I"
    puts ""
}

set contextos {
    "Panel solar cargando una batería portátil durante el día"
    "Turbina eólica alimentando una lámpara LED en una zona rural"
    "Sistema solar fotovoltaico cargando sensores de riego inteligente"
    "Microhidrogenerador abasteciendo una estación meteorológica"
    "Celdas solares en mochilas solares recargando un teléfono móvil"
    "Turbina de río para alimentar un punto de acceso Wi-Fi rural"
    "Sistema eólico-solar híbrido que alimenta una cámara de seguridad"
}

foreach contexto $contextos {
    generar_ejemplo_renovable $contexto
}
