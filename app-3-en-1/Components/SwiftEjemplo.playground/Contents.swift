import UIKit

/**
 PARTE SWIFT
 https://www.youtube.com/watch?v=f6WtmTBFNGM&t=9732s
 MIN 0:00 a 2:42:30
 */

// 1. VAR y LET y PRIVATE
var varGreeting = "Hello, playground"

let letName = "Carlos" // es inmutable los 'let'
print("Me llamo \(letName)")

/* privade */ var privateName = "Carlos"
print("Mi nombre es \(privateName)")

// 2. VARIABLES
// CHAR (solo un caracter), STRING, INTEGER, FLOAT, DOUBLE, BOOL, OPERACIONES
var varSimbol:Character = "✅"
print("Mi simbolo es \(varSimbol)")

var varString:String = "Hola, mi nombre es Carlos"
print("Mi string es \(varString)")

var varInteger:Int = 10
varInteger = 20
print("Mi numero es \(varInteger)")

var varFloat:Float = 10.1293270959049274934
print("Mi numero es \(varFloat)")

var varDouble:Double = 4.1293270959049274934
print("Mi numero es \(varDouble)")

var varBoolean:Bool = true
varBoolean = varDouble == 7
print("Mi boolean es \(varBoolean)")

var varOperacion:Float = Float(varInteger) + varFloat - Float(varDouble)
print("El resultado de la operacion es \(varOperacion)")

var varMultiDiv:Float = (varOperacion/Float(varInteger)) + Float(varDouble)
print("El resultado es \(varMultiDiv)")

var varReducida = 5
varReducida /= 2 // cociente
varReducida *= 2 // multiplicación
varReducida -= 2 // resta
varReducida += 2 // suma
varReducida %= 2 // módulo

// 3. CONVERSIONES
let varSuperString = String(varDouble) + String(letName) + String(varInteger)
print("Mi super string es \(varSuperString)")

let varIntString = "Pepito"
// print("Mi string es \(Int(varIntString))") // nil

// EJERCICIO #1 (muy sencillo solo realizar esas operaciones)
let letAsistencia:Float = 4 // si no ponemos float luego la división nos truncaria para convertirlo a entero
let letTotalClase:Float = 25
let letPorcentaje = (letAsistencia / letTotalClase) * 100
print("El porcentaje final es de \(letPorcentaje)")

// 4. FUNCIONES
func showMyCustomName(nombre:String = "Pepito", edad:Int, _ pais:String) -> Int{
    print("Función: Mi nombre es \(nombre), tengo \(edad) años y soy de \(pais)")
    return edad
}

showMyCustomName(nombre: "Carlos", edad: 24, "El Cabaco")

let letEdad = showMyCustomName(edad: 24, "El Cabaco") // por de fectoy sin necesidad de poner el nombre.
print("Retorno la edad: \(letEdad)")

// 5. CONDICIONALES (Y PUERTAS LÓGICAS)
// IF
if((varBoolean == false || varInteger != 20) && varSimbol == "✅" && !varSuperString.isEmpty)
{
    print("Mi condicion es verdadera")
} else if letEdad >= 18 { // no es obligatorio el parentesis
    print("Soy mayor de edad")
} else {
    print("Mi condicion es falsa")
}

print ("Mi condicion es \(varBoolean ? "verdadera" : "falsa")") // operación ternaria

// SWITCH
func calcularMes(_ mes:Int){
    switch mes{
    case 1: print("Enero")
    case 2: print("Febrero")
    case 3: print("Marzo")
    case 4: print("Mayo")
    case 5: print("Junio")
    case 6: print("Julio")
    case 7: print("Agosto")
    case 8: print("Septiembre")
    case 9, 10, 11, 12: print("Invierno") // Varios números
    case 13...31: print("Mes del año") // Rango de números
    default: print("Ningun mes principal")
    }
}

calcularMes(5)

// EJERCICIO #2 Calcular el area de un circulo en una función
func areaCirculo(_ radio:Double) -> Double{
    return Double.pi * radio * radio
}

print ("El area del circulo es \(areaCirculo(5))")

// EJERCICIO #3 Pintar si es positivo negativo o cero (if y switch)
func tipoNumero(_ num: Int) -> Void{
    if num > 0 {
        print("El numero es positivo")
    } else if num < 0 {
        print("El numero es negativo")
    } else {
        print("El numero es cero")
    }
}

tipoNumero(-5)

let numero: Int = 8

switch numero {
case let x where x > 0: print("El numero es positivo")
case let x where x < 0: print("El numero es negativo")
default : print("El numero es cero")
}

// 6. ARRAY
var varNameArray: [String] = ["Carlos", "Pedro", "Ismael"]
print("El primer nombre es \(varNameArray[0])")
print("El ultimo nombre es \(varNameArray[varNameArray.count - 1])")

varNameArray.remove(at: 2) // borrar un elemento del array
print("El ultimo nombre actualizado es \(varNameArray[varNameArray.count - 1])")

varNameArray.append("Juan")
print("El ultimo valor es: \(varNameArray[varNameArray.count - 1])")

// 7. BUCLES
// FOR (cuando sabes cuantas veces se quieren iterar
for i in 0..<varNameArray.count { // por indice como un for)
    print("For \(i)")
}

for name in varNameArray { // por valor (como un foreach)
    print("For \(name)")
}

for (i, name) in varNameArray.enumerated() { // por indice y valor (MEJOR con '.enumerated()')
    print("For \(i) \(name)")
}

// WHILE (no se las vueltas, hasta que s ecumpla una condicion
var count = 0

while count < 5 {
    print("While \(count)")
    count += 1
}

// WHILE REPEAT (se repite al menos una vez (como un do while)
count = 0

repeat{
    print("REPEAT \(count)")
    count += 1
} while count > 2

// EJERCICIO #4 Función que reciba un número y crea su tabla de multiplicar del 1 al 10
func tablaMult(_ numero: Int) -> Void {
    print("========= Tabla de multiplicar del \(numero) =========")
    for i in 1...10 {
        print("\(i) por \(numero) = \(i * numero)")
    }
}

tablaMult(5)

// EJERCICIO #5 Calcular la suma de todos los números pares del 1 al 100 y mostrar el resultado
func sumaPares()-> Int {
    var suma:Int = 0
    
    for i in 1...100 {
        if i % 2 == 0 {
            suma += i
        }
    }
    
    return suma
}

print("Resultado de la suma de los pares es \(sumaPares())")

// EJERCICIO #6 Vocales de una frase
let frase = "Hola me llAmo CarlOs"
var numVoc = 0
for palabra in frase.lowercased() {
    // for letra in palabra {
    switch palabra {
    case "a", "e", "i", "o", "u": numVoc += 1
    default : break
    }
    // }
}

print("\(frase) en total tiene \(numVoc)")

// 8. TUPLAS Y DICCIONARIOS
// Tupla: como un array [] pero acepta culaquier variable en ()
var tupla = (1, "Hola", true, 4.565)

print("La posición número 3 de la tuplate es \(tupla.3)")

// Diccionario: contiene clave y valor
var diccionario: [String: Any] = [:]
diccionario["Hola"] = 1
diccionario["Mr"] = "Senior"
diccionario["Pedro"] = "3"
diccionario["Pica"] = false
diccionario["Piedras"] = 5
diccionario["Adios"] = 6.349

print("El diccionario es \(diccionario)")

if let conversionString = diccionario["Pedro"] as? String, var entero = Int(conversionString){
    print("Conversion de string a int es \(entero)")
} else {
    print("No se pudo convertir el valor a Int")
}

for (key,value) in diccionario {
    print("\(key) : \(value)")
}

// 9. OPCIONAL (opcional '?', puede ser nulo)
var stringReal:String? = "Hola"
var stringNulo:String? = nil // valor nulo (null)

print("\(stringReal ?? "No tiene valor")")
print("\(stringNulo ?? "No tiene valor")")

func ejemploNil(_ text:String) {
    // lo que sea
}

ejemploNil(stringReal!) // si estoy seguro que de tiene valor, se puede poner el !
ejemploNil(stringNulo ?? "No tiene valor") // se puede poner si es nil que devuelva otro cosa

func ejemploNil2(_ text:String?){
    if(text != nil){
        print("\(text!)")
    }
    
    guard let text2 = text else { // el guard es que si se da la suituacion deje de continuar
        print("No tiene valor")
        return // te obliga a poner un return
    }
    
    /** Extructura guard:
     guard condición else {
     // Código a ejecutar si la condición NO se cumple
     // Normalmente incluye return, break, continue o throw
     }
     */
    
    print("Sigue ejecuntado")
}

// 10. CLASES Y STRUCT
class PersonaClass{
    var name:String
    var age: Int
    
    // Programación orientada a objetos: constructor
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func saludar(){
        print("Soy \(name) y tengo \(age) años")
    }
    
}

var p1:PersonaClass = PersonaClass(name: "Ignacio", age: 32)
var p2:PersonaClass = PersonaClass(name: "Ramiro", age: 50)

p1.saludar()
print("Soy \(p2.name) y tengo \(p2.age) años")

struct PersonaStruct{
    var name:String
    var age:Int
}

var p3:PersonaStruct = PersonaStruct(name: "Javier", age: 19)


