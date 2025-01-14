//
//  IMCResult.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 1/1/25.
//

import SwiftUI

// VISTA SECUNDARIA: IMCResult
struct IMCResult: View {
    
    // VARIABLES
    // Variables recibidas a través de la pantalla IMCView
    let pesoUsuario: Double
    let alturaUsuario: Double
    let generoUsuario:String
    let edadUsuario:Int
    
    // VISTA
    var body: some View {
        
        // Variable donde se obtiene el resultado de la función
        let result = calcularIMC(peso: pesoUsuario, altura: alturaUsuario) // función calcular el IMC (a partir de peso y altura)
        
        VStack{ // VStack principal
            
            Text("Tu resultado")
                .font(.title)
                .bold()
                .foregroundColor(Color.white)
            
            Text("\(generoUsuario) - \(edadUsuario) años")
                .font(.title3)
                .foregroundColor(Color.gray)
                .padding(.top, 1)
            
            InformationView(result: result) // Sección con todos los datos: estado (con color variante), resultado y descripción
            
        }
        //... Atributos de la VStack principal
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackGround)
    }
}

// 1_Función calcular el IMC (a partir de peso y altura)
func calcularIMC(peso:Double, altura:Double) -> Double{
    return peso/((altura/100)*(altura/100))
}

// 2_Función dar formato a una tupla con diversos datos de diferentes tipos según el resultado
func formatoResultado(result:Double) -> (String, String, Color){
    
    // VARIABLES
    var estado:String = ""
    var descripcion:String = ""
    var color:Color = Color.white
    
    switch result {
    case 0.00...14.99:
        estado = "Muy bajo peso"
        descripcion = "Es un peso muy bajo, debes comer más y actuar con cuidado."
        color = Color.red
        break
    case 15.00...19.99:
        estado = "Bajo peso"
        descripcion = "Es un peso bajo, debes comer más."
        color = Color.orange
        break
    case 20.00...24.99:
        estado = "Normal"
        descripcion = "Es un peso normal, no hay que preocuparse."
        color = Color.green
        break
    case 25.00...29.99:
        estado = "Sobrepeso"
        descripcion = "Es un peso sobrepeso, debes comer menos."
        color = Color.orange
        break
    case 30.00...100:
        estado = "Obesidad"
        descripcion = "Es una obesidad, debes comer menos y actuar con cuidado."
        color = Color.red
        break
    default:
        estado = "Error"
        descripcion = "Error en el calculo"
        color = Color.red
    }
    
    return (estado, descripcion, color)
}

// 3_Sección con todos los datos: estado (con color variante), resultado y descripción
struct InformationView:View{
    
    // VARIABLE
    let result:Double
    
    var body: some View {
        // obtiene
        let (estado, descripcion, color) = formatoResultado(result: result) // Función dar formato devolviendo la tupla
        
        VStack{
            Spacer() // espacio
            
            Text(estado)
                .foregroundColor(color)
                .font(.title)
                .bold()
            
            Spacer()
            
            Text("\(Int(result))")
                .foregroundColor(.white)
                .font(.system(size:60))
                .bold()
            
            Spacer()
            
            Text(descripcion)
                .font(.system(size:20))
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center) // Alinea el texto centrado en todas las líneas
            
            Spacer()
        }
        //... Atributos de la VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.componentBackground)
        .cornerRadius(20)
        .padding(.horizontal, 16)
        .padding(.bottom, 16)
        .padding(.top, 4)
    }
}

#Preview {
    IMCResult(pesoUsuario:10, alturaUsuario:10, generoUsuario: "Hombre", edadUsuario: 25)
}
