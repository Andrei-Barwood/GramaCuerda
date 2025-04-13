# electricidad_renovable.tcl

proc imprimir_tabla_conversion {} {
    puts "Tabla de Conversión de Unidades (Notación Ingenieril):"
    puts "-----------------------------------------------------"
    puts "Intensidad (Corriente - Amperes):"
    puts "  1 pA  = 10^-12 A  (picoamperio)"
    puts "  1 nA  = 10^-9  A  (nanoamperio)"
    puts "  1 µA  = 10^-6  A  (microamperio)"
    puts "  1 mA  = 10^-3  A  (miliamperio)"
    puts "  1 A   = 10^0   A  (amperio)"
    puts "  1 kA  = 10^3   A  (kiloamperio)"
    puts "  1 MA  = 10^6   A  (megaamperio)"
    puts "  1 GA  = 10^9   A  (gigaamperio)"
    puts "  1 TA  = 10^12  A  (teraamperio)"
    puts ""
    puts "Carga Eléctrica (Coulombs):"
    puts "  1 pC  = 10^-12 C  (picocoulomb)"
    puts "  1 nC  = 10^-9  C  (nanocoulomb)"
    puts "  1 µC  = 10^-6  C  (microcoulomb)"
    puts "  1 mC  = 10^-3  C  (milicoulomb)"
    puts "  1 C   = 10^0   C  (coulomb)"
    puts "  1 kC  = 10^3   C  (kilocoulomb)"
    puts "  1 MC  = 10^6   C  (megacoulomb)"
    puts "  1 GC  = 10^9   C  (gigacoulomb)"
    puts "  1 TC  = 10^12  C  (teracoulomb)"
    puts ""
    puts "Tiempo (Segundos):"
    puts "  1 ps  = 10^-12 s  (picosegundo)"
    puts "  1 ns  = 10^-9  s  (nanosegundo)"
    puts "  1 µs  = 10^-6  s  (microsegundo)"
    puts "  1 ms  = 10^-3  s  (milisegundo)"
    puts "  1 s   = 10^0   s  (segundo)"
    puts "  1 ks  = 10^3   s  (kilosegundo)"
    puts "  1 Ms  = 10^6   s  (megasegundo)"
    puts "  1 Gs  = 10^9   s  (gigasegundo)"
    puts "  1 Ts  = 10^12  s  (terasegundo)"
    puts ""
}

proc convertir_unidades {valor unidad_origen unidad_destino} {
    array set factores {
        "A" 1 "mA" 1000 "uA" 1000000
        "C" 1 "mC" 1000 "uC" 1000000
        "s" 1 "ms" 1000 "us" 1000000
    }
    return [expr {$valor * $factores($unidad_origen) / $factores($unidad_destino)}]
}

proc generar_ejemplo_renovable {contexto} {
    set ecuaciones {
        {Q I t {$Q / $I} "t = Q / I"}
        {Q t I {$Q / $t} "I = Q / t"}
        {I t Q {$I * $t} "Q = I * t"}
    }
    set eq [lindex $ecuaciones [expr {int(rand()*3)}]]

    set Q [expr {rand()*100 + 1}]
    set I [expr {rand()*5 + 0.5}]
    set t [expr {rand()*10 + 1}]

    set var1 [lindex $eq 0]
    set var2 [lindex $eq 1]
    set var3 [lindex $eq 2]
    set expr_code [lindex $eq 3]
    set formula [lindex $eq 4]

    set $var3 [eval expr $expr_code]

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
    puts "  Ecuación usada: $formula"
    puts "  Datos: Q = [format %.2f $Q_conv] $unidad_Q, I = [format %.2f $I_conv] $unidad_I, t = [format %.2f $t_conv] $unidad_t"
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

imprimir_tabla_conversion

foreach contexto $contextos {
    generar_ejemplo_renovable $contexto
}
