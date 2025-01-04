//
//  IMCView.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 1/1/25.
//

import SwiftUI

// Vista principal: IMCView
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
                ToogleButton(text:"Hombre", imageName: "figure.stand", genero: 0, selectedGenero: $genero) // 1_Vista Secundaria
                ToogleButton(text:"Mujer", imageName: "figure.stand.dress", genero: 1, selectedGenero: $genero) // 1_Vista Secundaria
            }
            
            CalculadorAltura(selectedAltura: $altura) // 3_Vista Secundaria
            
            HStack{
                ContadorParametro(textTitle: "Edad", contador: $contadorEdad) // 5_Vista Secundaria
                ContadorParametro(textTitle: "Peso", contador: $contadorPeso) // 5_Vista Secundaria
            }
            
            BotonFinal(peso: Double(contadorPeso), altura: altura) // 7_Vista Secundaria
            
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

// 1_Vista Secundaria (1 sección con un toogle personalizado con dos botones para elegir entre hombre y mujer)
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
                
                InformationText(text: text) // 2_Vista Secundaria
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(color) //variable: dependiendo si ha sido seleccionado o no
        //.border(Color.purple, width: 4)
    }
}

// 2_Vista Secundaria (todos los textos de los nombres personalizados para no tenerlo que repetir)
struct InformationText:View {
    
    let text:String
    
    var body:some View {
        Text(text)
            .font(.largeTitle)
            .bold()
            .foregroundColor(.white)
    }
}

// 3_Vista Secundaria (2 sección con el slider con la altura)
struct CalculadorAltura:View {
    
    @Binding var selectedAltura:Double
    
    var body: some View {
        
        VStack {
            TitleText(text: "Altura")  // 4_Vista Secundaria
            InformationText(text: "\(Int(selectedAltura)) cm") // 2_Vista Secundaria
            Slider(value: $selectedAltura, in: 100...230, step: 2)
                .accentColor(Color.purple)
                .padding(.horizontal, 20)
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.componentBackground)
    }
}

// 4_Vista Secundaria (todos los textos de los secundarios personalizados para no tenerlo que repetir)
struct TitleText:View {
    
    let text:String
    
    var body: some View {
        Text(text)
            .font(.title2)
            .foregroundColor(Color.gray)
    }
}

// 5_Vista Secundaria (sección 3 y 4, son iguales con distinta información, son contadores con dos botones)
struct ContadorParametro:View{
    
    let textTitle:String
    @Binding var contador:Int
    
    var body: some View {
        VStack{
            TitleText(text: textTitle) // 4_Vista Secundaria
            InformationText(text:"\(contador)") // 2_Vista Secundaria
            
            HStack{
                BotonContador(icono: "minus", contador: $contador) // 6_Vista Secundaria
                BotonContador(icono: "plus", contador: $contador)  // 6_Vista Secundaria
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.componentBackground)
        
    }
}

// 6_Vista Secundaria (botón contador, estilo a los botones que se van a encontrar en los contadores 'sect 3 y 4')
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

// 7_Vista Secundaria (sección 7, muestra el boton para finalziar y navegar a la siguiente pantalla pasando parámetros)
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
