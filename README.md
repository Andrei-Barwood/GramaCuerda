# ⚡ Cálculos Eléctricos Interactivos

La idea es instalar **Termux** y luego instalar **git** en tu dispositivo.

Termux está disponible en la AppStore y en la PlayStore es un emulador de
terminal que te permite instalar apps que se distribuyen de forma autogestionada
a través de GitHub, una pregunta razonable es la siguiente ¿que es Github?
[haz click aquí para la respuesta](https://en.wikipedia.org/wiki/GitHub)



<p align="center">
  <img src="https://termux.dev/assets/globals/home/vim-main_framed.png" alt="Logo del Proyecto" width="200"/>
</p>


Después de instalar Termux sigue estos pasos, 
abres la app Termux y escribes lo siguiente:


1. Instalar **TCL** y **git** en Termux:

```bash
pkg install tcl
pkg install git
```

2. Clonar el repositorio de **GramaCuerda** desde GitHub:

```bash
git clone https://github.com/Andrei-Barwood/GramaCuerda.git
```

3. Acceder al directorio **GramaCuerda**:

```bash
cd GramaCuerda
```

4. Ejecutar el script en TCL para iniciar la aplicación:

```bash
tclsh cli.tcl "02 - Corriente"
```

debes especificar el titulo de la opcion completo y entre comillas
Te dará la bienvenida y podrás escoger las opciones disponibles. 

Ejemplo, tu escribes lo siguiente:
```bash
tclsh cli.tcl --ayuda
```
Y GramaCuerda te responde lo siguiente:

```bash
Uso: --tclsh cli.tcl-- seguido del nombre de la opción (sin especificar el asterisco)
Opciones disponibles:

Las opciones disponibles que comienzan con un número, por ejemplo, la primera comienza con 'cero-uno espacio guion espacio potencias de diez' etcétera.
Se especifican entre comillas, en Unix es muy fácil asignar espacio a los títulos de los documentos, simplemente especificas el título entre comillas y te permite utilizar un formato más legible.

  * 01 - potencias de diez
  * 02 - Corriente
  * 03 - voltaje
  * 04 - convertir entre unidades
  * 05 - Resistencia
  * 06 - velocidad (unidades de medida)
  * bienvenida
  -a, --ayuda
```



Si tienes alguna duda o problema, no dudes en enviarme un mensaje privado.


Bye

