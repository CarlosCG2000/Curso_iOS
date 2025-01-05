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

### 1_IMC App ✅
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

### 2_SuperHeroe App ✅
`ApiNetwork`: es una clase (no vista) donde se declara los modelos que se utilizan de la API y se hacen las llamadas a las API
[ API REST: `https://superheroapi.com/`  (KEY: XXXXXXXXX) ]
1. `Wrapper`: la estructura Wrapper que se recibe en el json de la API (tiene que ser Codable), ¡importante poner los mismos nombres que en JSON, (los que se quieran usar)!
2. `SuperHero`: la estructura SuperHero, los datos que recogemos para formar un superheroe en json (recordar poner los mismos nombres que en JSON)
3. `ImageSuperHero`: la estructura ImageSuperHero de la imagen del json
4. `SuperHeroComplete`: la estructura de SuperHeroComplete, es otra llamada a la API que devuelve otro json (recordar poner los mismos nombres que en JSON)
5. `Powestats`: la estructura de Powestats, con los poderes (recordar poner los mismos nombres que en JSON)
6. `Biograph`: la estructura de Powestats, con la biografia (problema con la etiqueta full-name en json que no se puede poner igual aqui en el script) (recordar poner los mismos nombres que en JSON)
7. `getHeroesByQuery`: función para obtener todos los heroes a través de un string
8. `getHeroeById`: función para obtener un heroe en particular

`SuperHeroBuscador`: vista principal
[ LIBRERÍA: `https://github.com/SDWebImage/SDWebImage` (para poner una imagen sacada de una API)]
1. `SuperHeroItem`: sección con la información de un Superheroe (vista secundaria) que se mostrará en el Listado

`SuperHeroDetails`:
1. `SuperHeroStats`: sección de las estadisticas del superheroe en una gráfica (vista secundaria)

[ Mapas ]

### 3_Mis Sitios App
- Diálogos
- Guardando places
- Markers
- Componente Sheet
- Listado places
- Persistencia de datos

Con User Defaults (muy básica DB) (para borrar la DB seria borrando la App dentro del Iphone (emulador))

