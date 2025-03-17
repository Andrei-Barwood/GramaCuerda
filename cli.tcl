#!/usr/bin/env tclsh

# Directorio donde están los scripts de funcionalidades
set scripts_dir "scripts"

# Función para mostrar ayuda
proc mostrar_ayuda {} {
    puts "Uso: --tclsh cli.tcl-- seguido del nombre de la opción (sin especificar el asterisco)" 
    puts "Opciones disponibles:"
    puts ""
    puts "Las opciones disponibles que comienzan con un numero por ejemplo la primera comienza con cero-uno espacio guion espacio potencias de diez etcetera"
    puts "se especifican entre comillas, en unix es muy facil asignar espacio a los titulos de los documentos, simplemente especificas el titulo entre comillas y te permite utilizar un formato mas legible"


puts ""

    # Buscar scripts disponibles en la carpeta 'scripts'
    foreach file [glob -nocomplain -type f $::scripts_dir/*.tcl] {
        set name [file rootname [file tail $file]]
        puts "  * $name"
    }
    puts "  -a, --ayuda"
}

# Verifica si hay argumentos
if {$argc == 0 || [string equal [lindex $argv 0] "--ayuda"] || [string equal [lindex $argv 0] "-a"]} {
    mostrar_ayuda
    exit 0
}

# Obtener el nombre del script solicitado
set opcion [lindex $argv 0]
set script_path "$scripts_dir/$opcion.tcl"

# Verificar si el script existe y ejecutarlo
if {[file exists $script_path]} {
    source $script_path
} else {
    puts "❌ Error: La opción '$opcion' no existe. Usa -h para ver las opciones disponibles."
    exit 1
}