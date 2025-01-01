//
//  IMCView.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 1/1/25.
//

import SwiftUI

// PANTALLA PRINCIPAL: ÍNDICE DE MASA CORPORAL
// 1. Cuidado con el orden de los modificadores
// 2. Añadir de forma diferent el color del Toolbar
struct IMCView: View {
    
    @State var genero:Int = 0 // esto se envia al ToogleButton (es como la caña de pescar)
    @State var altura:Double = 150 // esto se envia a CalculadorAltura
    
    @State var contadorEdad:Int = 18 // esto se envia a ContadorParametro
    @State var contadorPeso:Int = 60 // esto se envia a ContadorParametro
    
    var body: some View {
        
        // Contenedor principal
        VStack{
            HStack{
                ToogleButton(text:"Hombre", imageName: "figure.stand", genero: 0, selectedGenero: $genero)
                ToogleButton(text:"Mujer", imageName: "figure.stand.dress", genero: 1, selectedGenero: $genero)
            }
            
            CalculadorAltura(selectedAltura: $altura)
            
            HStack{
                ContadorParametro(textTitle: "Edad", contador: $contadorEdad)
                ContadorParametro(textTitle: "Peso", contador: $contadorPeso)
            }
            
            BotonFinal(peso: Double(contadorPeso), altura: altura)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity) // ocupe toda la vista
            .background(.appBackground) // color del fondo
            .navigationTitle("Índice de masa corporal") // 1 FORMA (personalizado en la APP)
        /**.toolbar { // 2 FORMA (personalizado en el propio componente)
         ToolbarItem(placement: .principal) { // Personaliza el título
         Text("Índice de masa corporal")
         .foregroundColor(.white) // Cambia el color del texto
         .bold()
         }
         }*/
        /**.navigationBarBackButtonHidden(true)  // Quitar el boton de ir para atrás */
        
    }
}

struct ToogleButton:View{
    
    let text:String
    let imageName:String
    let genero:Int
    @Binding var selectedGenero : Int// se recibe del IMCView (es como el anzuelo)
    
    var body:some View{
        
        let color = (genero == selectedGenero) ? Color.selectComponentBackground : Color.componentBackground
        
        Button(action:  {
            selectedGenero = genero
        }
        )
        {
            VStack{
                Image(systemName: imageName) // Icono (por eso systemName)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(height: 100)
                
                InformationText(text: text) // Estrucuta InformationText de texto
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color) //variable: dependiendo si ha sido seleccionado o no
        //.border(Color.purple, width: 4)
    }
}


struct InformationText:View {
    
    let text:String
    
    var body:some View {
        Text(text)
            .font(.largeTitle)
            .bold()
            .foregroundColor(.white)
    }
}

struct CalculadorAltura:View {
    
    @Binding var selectedAltura:Double
    
    var body: some View {
        
        VStack {
            TitleText(text: "Altura")
            InformationText(text: "\(Int(selectedAltura)) cm")
            Slider(value: $selectedAltura, in: 100...230, step: 2)
                .accentColor(Color.purple)
                .padding(.horizontal, 20)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.componentBackground)
    }
}

struct TitleText:View {
    
    let text:String
    
    var body: some View {
        Text(text)
            .font(.title2)
            .foregroundColor(Color.gray)
    }
}

struct ContadorParametro:View{
    
    let textTitle:String
    @Binding var contador:Int
    
    var body: some View {
        VStack{
            TitleText(text: textTitle)
            InformationText(text:"\(contador)")
            
            HStack{
                BotonContador(icono: "minus", contador: $contador)
                BotonContador(icono: "plus", contador: $contador)
            }
            
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.componentBackground)
        
    }
}

struct BotonContador:View{
    
    let icono:String
    @Binding var contador:Int
    
    func actionContador() -> Void {
        if icono == "minus"{
            if  contador > 0{
                contador -= 1
            }
        } else {
            if contador < 140 {
                contador += 1
            }
        }
    }
    
    var body: some View {
        Button(action:actionContador)
        {
            Image(systemName: icono)
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.white)
        }
        .padding(15)
        .background(.purple)
        .clipShape(Circle()) // Hace que el botón sea completamente redondo
        
    }
}

struct BotonFinal: View {
    
    let peso:Double
    let altura: Double
    
    var body: some View {
        
        NavigationStack
        {
            NavigationLink(destination: {IMCResult(pesoUsuario:peso, alturaUsuario:altura)})
            {
                Text("Finalizar")
                    .foregroundColor(Color.purple)
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: 70)
                    .background(Color.componentBackground)
            }
        }
    }
}

#Preview {
    IMCView()
}
