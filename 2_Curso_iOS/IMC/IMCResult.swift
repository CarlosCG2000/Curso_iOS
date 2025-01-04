//
//  IMCResult.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 1/1/25.
//

import SwiftUI

// Vista principal: IMCResult
struct IMCResult: View {
    let pesoUsuario: Double
    let alturaUsuario: Double
    
    var body: some View {
        
        let result = calcularIMC(peso: pesoUsuario, altura: alturaUsuario)
        
        VStack{
            Text("Tu resultado").font(.title)
                .bold()
                .foregroundColor(Color.white)
            
            InformationView(result: result) // 1_Vista Secundaria
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
    }
}

// 1_Vista Secundaria (con todos los datos: estado (con color variante), resultado y descripcióm
struct InformationView:View{
    
    let result:Double
    
    var body: some View {
        let (estado, descripcion, color) = formatoResultado(result: result)
        
        VStack{
            Spacer()
            Text(estado).foregroundColor(color)
                .font(.title).bold()
            Spacer()
            Text("\(Int(result))").foregroundColor(.white)
                .font(.system(size:60)).bold()
            Spacer()
            Text(descripcion).font(.system(size:20))
                .foregroundStyle(Color.white)
                .multilineTextAlignment(.center) // Alinea el texto centrado en todas las líneas
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.componentBackground).cornerRadius(20).padding(16)
    }
}

// 2_Función calcular el IMC (a partir de peso y altura)
func calcularIMC(peso:Double, altura:Double) -> Double{
    return peso/((altura/100)*(altura/100))
}

func formatoResultado(result:Double) -> (String, String, Color){
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

#Preview {
    IMCResult(pesoUsuario:10, alturaUsuario:10)
}
