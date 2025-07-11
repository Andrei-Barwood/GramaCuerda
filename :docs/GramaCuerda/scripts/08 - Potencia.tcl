# Script TCL para explicar la Potencia en Ingeniería Eléctrica

proc explicar_potencia {} {
    puts "---"
    puts "## ¿Qué es la Potencia en Ingeniería Eléctrica?"
    puts "---"
    puts "En ingeniería eléctrica, la **potencia** es la cantidad de energía que se consume o se produce por unidad de tiempo."
    puts "Es, en esencia, la rapidez con la que se realiza un trabajo eléctrico o la rapidez con la que se transfiere energía."
    puts "Se mide en **Watts (W)**, que equivale a un Joule por segundo (J/s)."
    puts ""
    puts "### La Ecuación Fundamental de la Potencia"
    puts "La ecuación más básica para la potencia en circuitos de corriente continua (DC) o para la potencia instantánea en corriente alterna (AC) es:"
    puts ""
    puts "  **Potencia (P) = Voltaje (V) x Intensidad (I)**"
    puts ""
    puts "Donde:"
    puts "  * **Potencia (P)** se mide en Watts (W)."
    puts "  * **Voltaje (V)** (también conocido como tensión o diferencia de potencial) se mide en Volts (V)."
    puts "  * **Intensidad (I)** (también conocida como corriente eléctrica) se mide en Amperios (A)."
    puts ""
    puts "Esta ecuación nos dice que si tenemos una tensión alta y una corriente alta, la potencia que se está manejando será considerable."
    puts ""
    puts "---"
    puts "## Ejemplos de Potencia en la Industria de Energías Renovables"
    puts "---"
    puts "Aquí te presento 7 ejemplos concretos donde la potencia es un concepto clave en el sector de las energías renovables, aplicando la ecuación V x I = P:"
    puts ""

    # Ejemplo 1: Panel Solar
    puts "### 1. Panel Solar Fotovoltaico"
    puts "Un panel solar convierte la luz solar en electricidad."
    puts "Si un panel genera un **voltaje de 20V** y una **intensidad de 5A** bajo condiciones óptimas, su potencia de salida es:"
    set V_panel 20
    set I_panel 5
    set P_panel [expr {$V_panel * $I_panel}]
    puts "  P = ${V_panel}V x ${I_panel}A = **${P_panel}W**."
    puts "Esta es la potencia eléctrica que el panel puede entregar a una carga."
    puts ""

    # Ejemplo 2: Aerogenerador (Turbina Eólica)
    puts "### 2. Aerogenerador (Turbina Eólica)"
    puts "Una turbina eólica transforma la energía del viento en energía eléctrica."
    puts "Si el generador de una turbina produce un **voltaje de 690V** y una **intensidad de 1500A** en un momento dado, la potencia generada es:"
    set V_aero 690
    set I_aero 1500
    set P_aero [expr {$V_aero * $I_aero}]
    puts "  P = ${V_aero}V x ${I_aero}A = **${P_aero}W** (o [expr {$P_aero / 1000.0}]kW)."
    puts "Las turbinas grandes pueden generar varios Megawatts (MW)."
    puts ""

    # Ejemplo 3: Sistema de Almacenamiento de Baterías
    puts "### 3. Sistema de Almacenamiento de Baterías"
    puts "Las baterías almacenan y liberan energía. Su potencia de salida determina qué tan rápido pueden entregarla."
    puts "Si un banco de baterías está descargándose con un **voltaje de 48V** y una **corriente de 100A**, la potencia suministrada es:"
    set V_bateria 48
    set I_bateria 100
    set P_bateria [expr {$V_bateria * $I_bateria}]
    puts "  P = ${V_bateria}V x ${I_bateria}A = **${P_bateria}W**."
    puts "Esta es la potencia que puede alimentar una carga o la red."
    puts ""

    # Ejemplo 4: Inversor Fotovoltaico
    puts "### 4. Inversor Fotovoltaico"
    puts "El inversor convierte la corriente continua (DC) de los paneles solares en corriente alterna (AC) para uso doméstico o la red."
    puts "Si un inversor recibe **500V DC** y **10A DC** de los paneles, la potencia DC que procesa es:"
    set V_inversor_dc 500
    set I_inversor_dc 10
    set P_inversor_dc [expr {$V_inversor_dc * $I_inversor_dc}]
    puts "  P (DC) = ${V_inversor_dc}V x ${I_inversor_dc}A = **${P_inversor_dc}W**."
    puts "La potencia de salida AC será ligeramente menor debido a las pérdidas de eficiencia del inversor."
    puts ""

    # Ejemplo 5: Bomba de Agua Solar
    puts "### 5. Bomba de Agua Solar (DC)"
    puts "Pequeños sistemas solares se usan para bombear agua, especialmente en zonas rurales."
    puts "Si una bomba funciona con **24V** y consume una **corriente de 8A**, la potencia que requiere es:"
    set V_bomba 24
    set I_bomba 8
    set P_bomba [expr {$V_bomba * $I_bomba}]
    puts "  P = ${V_bomba}V x ${I_bomba}A = **${P_bomba}W**."
    puts "Esta potencia determina cuánta agua puede mover la bomba en un tiempo dado."
    puts ""

    # Ejemplo 6: Cargador de Vehículo Eléctrico (EV)
    puts "### 6. Cargador de Vehículo Eléctrico (EV) Rápido"
    puts "Los cargadores de vehículos eléctricos transfieren potencia de la red a la batería del coche."
    puts "Un cargador rápido podría operar a **400V AC** (en una fase) y entregar una **corriente de 200A**."
    set V_cargador 400
    set I_cargador 200
    set P_cargador [expr {$V_cargador * $I_cargador}]
    puts "  P = ${V_cargador}V x ${I_cargador}A = **${P_cargador}W** (o [expr {$P_cargador / 1000.0}]kW)."
    puts "Esto muestra la alta potencia necesaria para cargar rápidamente un vehículo."
    puts ""

    # Ejemplo 7: Iluminación LED Alimentada por Energía Solar
    puts "### 7. Iluminación LED Alimentada por Energía Solar"
    puts "Sistemas de iluminación exterior a menudo usan paneles solares pequeños y baterías."
    puts "Si un conjunto de luces LED funciona con **12V** y consume una **corriente total de 2.5A**, la potencia utilizada es:"
    set V_led 12
    set I_led 2.5
    set P_led [expr {$V_led * $I_led}]
    puts "  P = ${V_led}V x ${I_led}A = **${P_led}W**."
    puts "Esto es la potencia que el sistema solar necesita suministrar para mantener las luces encendidas."
    puts ""

    puts "---"
    puts "Entender la potencia es fundamental para diseñar, dimensionar y operar sistemas eléctricos de manera eficiente, especialmente en el creciente campo de las energías renovables."
    puts "---"
}

# Llama a la función para ejecutar la explicación
explicar_potencia