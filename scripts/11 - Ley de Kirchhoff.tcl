#!/usr/bin/env tclsh

# Función para redondear a 1 decimal
proc redondear1 {valor} {
    return [format "%.1f" $valor]
}

# Cabecera informativa
puts "
📝 DESCRIPCIÓN DE LAS LEYES DE KIRCHHOFF

1. Ley de Corrientes (Ley de Nodo):
   Esta ley establece que en cualquier nodo o punto de conexión de un circuito eléctrico,
   la suma de las corrientes que entran es igual a la suma de las corrientes que salen.
   Es una manifestación del principio de conservación de la carga eléctrica.

   Ejemplo: Si en un nodo llegan 2 corrientes desde generadores (por ejemplo, geotérmico y solar),
   la suma de estas debe ser igual a la corriente que se dirige hacia los consumidores,
   como centros de datos o estaciones de carga.

   Fórmula: I₁ + I₂ + ... + Iₙ = Iₛₐₗₑₙₜₑₛ

2. Ley de Tensiones (Ley de Malla):
   Esta ley afirma que, al recorrer cualquier lazo cerrado de un circuito,
   la suma algebraica de todas las tensiones (subidas y caídas de voltaje) debe ser igual a cero.
   Refleja la conservación de la energía en el circuito.

   Ejemplo: En un lazo que conecta una turbina, un transformador y una carga térmica,
   la tensión proporcionada por la fuente se reparte entre las caídas de tensión
   en los componentes del lazo.

   Fórmula: ∑ V = 0  →  V_fuente = V₁ + V₂ + ...
"

puts {




╔═════════════════════════════════════════════════════════════════════════════╗
║        LEYES DE KIRCHHOFF – PLANTA GEOTÉRMICA META (NM, USA)                ║
╠═════════════════════════════════════════════════════════════════════════════╣
║ 🌋 Ubicación: Nuevo México, en una zona volcánica estable                   
║ ⚡ Proyecto Meta: integra energía geotérmica a centros de datos              
╠════════════════╦════════════════════════════╦═══════════════════════════════╣
║ Ley de Nodo    ║ Corriente que entra = sale ║ ∑ I_entrantes = ∑ I_salientes ║
║ Ley de Malla   ║ Suma de voltajes = 0       ║ ∑ V_subidas - ∑ V_caídas = 0  ║
╚════════════════╩════════════════════════════╩═══════════════════════════════╝

}

puts "\n🌡️ Simulador: Ley de Kirchhoff aplicada a la Planta Geotérmica Meta 🔁⚡\n"

# Función para ejemplo de Ley de Corrientes (Nodo)
proc ejemplo_corriente {i} {
    set i1 [expr {10 + rand()*90}]
    set i2 [expr {5 + rand()*50}]
    #set i3 [expr {$i1 + $i2 - rand()*20}]
    set i3 [expr {$i1 + $i2}]

    set i1 [redondear1 $i1]
    set i2 [redondear1 $i2]
    set i3 [redondear1 $i3]

    puts "\n🔌 Ejemplo $i – Ley de Corrientes de Kirchhoff"
    puts "En un nodo que distribuye energía desde un generador geotérmico:"
    puts " - Corriente desde el generador hacia el nodo: I1 = $i1 A"
    puts " - Corriente de apoyo desde un inversor solar: I2 = $i2 A"
    puts " - Corriente que sale hacia los centros de datos: I3 = $i3 A"
    set total [redondear1 [expr {$i1 + $i2}]]
    puts "Verificación: I1 + I2 = $i1 + $i2 = $total A"
    puts "Resultado: $total A = I3 → Ley de Corrientes satisfecha.\n"
}

# Función para ejemplo de Ley de Tensiones (Malla)
proc ejemplo_tension {i} {
    set v_fuente [expr {230 + rand()*120}] ;# Tensión industrial ~230–350 V
    set v1 [expr {rand()*$v_fuente}]
    set v2 [expr {$v_fuente - $v1}]

    set v_fuente [redondear1 $v_fuente]
    set v1 [redondear1 $v1]
    set v2 [redondear1 $v2]

    puts "\n🔋 Ejemplo $i – Ley de Tensiones de Kirchhoff"
    puts "En un lazo que conecta turbina → transformador → unidad de enfriamiento:"
    puts " - Fuente de tensión de la turbina geotérmica: V = $v_fuente V"
    puts " - Caída de tensión en el transformador: V1 = $v1 V"
    puts " - Caída de tensión en la unidad de enfriamiento: V2 = $v2 V"
    puts "Verificación: V1 + V2 = $v1 + $v2 = [redondear1 [expr {$v1 + $v2}]] V"
    puts "Resultado: V - (V1 + V2) = 0 → Ley de Tensiones satisfecha.\n"
}

# Alternar entre ejemplos de nodo y malla
set i 1
while {$i <= 6} {
    if {[expr {$i % 2}] == 1} {
        ejemplo_corriente $i
    } else {
        ejemplo_tension $i
    }

    if {$i == 6} {
        puts "\n📘 Has completado todos los ejemplos."
        break
    }

    puts "¿Quieres ver otro ejemplo? (s para sí / n para salir): "
    flush stdout
    gets stdin respuesta
    set respuesta [string tolower $respuesta]

    if {$respuesta ne "s"} {
        puts "\n👋 Programa finalizado. ¡Ejemplo basado planta geotérmica de la empresa Meta"
        break
    }
    incr i
}
