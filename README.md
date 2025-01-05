## 3 APP'S iOS en SWIFT desde CERO con SWIFTUI

![image](./app-ios.png)

## xCode
IDE oficial para Swift.
Creación de folio en blanco sin crear aun un proyecto solo un ‘Playground’ en blanco (un fichero para hacer pruebas y ver resultados).
Comando + d : duplicar la línea

## Swift (fichero pruebas --> no incluido aquí)
* 1. Variables
- Operaciones
- Conversiones
* 2. Funciones
* 3. Sentencias If
* 4. Switch
* 5. Array
* 6. Bucles
* 7. Tuplas y diccionarios
* 8. Nulabilidad
* 9. Clases y Structs

## SwiftUI
Para organizar el código pillamos todo el código (cmd+ a) y pulsamos (ctrl + i)
Para crear un fichero (command + n)

* Componentes principales:
- Componente Text
- Componente Image
- Componente Label
- Componente Button
- States
- Componente TextField

[ HStack, VStack y ZStack ]
[ Navegación básica ]

### 0_Ficheros generales ✅
`Assets`: configuración de colores (AppBackground, ComponentBackground, SelectComponentBackground) e imágenes (youtube) como variables para utilizarlos en el proyecto de forma global.
`_Curso_iOSApp`: es el punto de entrada de la App
`MainView`: es la primera vista (la principal), solo llama a la primera vista funcional que es el menu (MenuView)
`MenuView`: es la primera vista funcional, donde se encuentra el menú para navegar a las aplicaciones (IMC, SuperHeroe, Mis Sitios)

### 1_IMC App
`IMCView`: es la principal vista de esta primera app.
1. IMCView: vista principal
2. InformationText: texto personalizado
3. ToogleButton: sección botón personalizado (vista secundaria)
4. TitleText: texto personalizado 2
5. CalculadorAltura: sección con Slider personalizado (vista secundaria)
6. BotonContador: botón contador
7. ContadorParametro: sección de un contador con dos botones (vista secundaria)
8. BotonFinal: sección con el boton para finalizar y navegar a la siguiente pantalla pasando parámetros (vista secundaria)

`IMCResult`:
1. `IMCResult`: vista principal
2. `calcularIMC`: función calcular el IMC (a partir de peso y altura)
3. `formatoResultado`: función dar formato a una tupla con diversos datos de diferentes tipos según el resultado
4. `InformationView`: Sección con todos los datos: estado (con color variante), resultado y descripción

[ Listas ]

### 2_SuperHeroe App
* API REST: `https://superheroapi.com/`  (KEY: XXXXXXXXX)
- Consumiendo API
- Personalizando listas
- Cargando imágenes desde URL
* Librería: `https://github.com/SDWebImage/SDWebImage`
- Perfilando detalles
- Pantalla detalle
- Gráficas

[ Mapas ]

### 3_Mis Sitios App
- Diálogos
- Guardando places
- Markers
- Componente Sheet
- Listado places
- Persistencia de datos

Con User Defaults (muy básica DB) (para borrar la DB seria borrando la App dentro del Iphone (emulador))

