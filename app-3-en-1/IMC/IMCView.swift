//
//  IMCView.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 1/1/25.
//

import SwiftUI

// VISTA PRINCIPAL: IMCView
// (Cuidado con el orden de los modificadores)
struct IMCView: View {
    
    // VARIABLES
    //(@State --> para que se reflejen los cambios de las vistas secundarias (@Binding), añadir si se modifica en esta vista principal el '$')
    @State var btValorGenero:Int = 0 // esto se envia al ToogleButton (con el @State como la caña de pescar)
    
    @State var sliValorAltura:Double = 170 // esto se envia a CalculadorAltura
    
    @State var contValorEdad:Int = 18 // esto se envia a ContadorParametro
    @State var contValorPeso:Int = 60 // esto se envia a ContadorParametro
    
    // VISTA
    var body: some View {
        
        VStack{ // VStack principal (contenido vertical)
            
            HStack{ // HStack (contenido horizontal)
                // Sección botón personalizado (vista secundaria) (2)
                // Al colocarse 2, hacen el efecto de un Toogle personalizado al colocarse juntos
                ToogleButton(text:"Hombre", imageName: "figure.stand", genero: 0, selectedGenero: $btValorGenero)
                ToogleButton(text:"Mujer", imageName: "figure.stand.dress", genero: 1, selectedGenero: $btValorGenero)
            }
            
            // Sección con Slider personalizado (vista secundaria)
            CalculadorAltura(selectedAltura: $sliValorAltura)
            
            HStack{ // HStack (contenido horizontal)
                // Sección de un contador con dos botones (vista secundaria)
                ContadorParametro(textTitle: "Edad", contador: $contValorEdad)
                ContadorParametro(textTitle: "Peso", contador: $contValorPeso)
            }
            
            // Sección con el boton para finalizar y navegar a la siguiente pantalla pasando parámetros (vista secundaria)
            BotonFinal(peso: Double(contValorPeso), altura: sliValorAltura, genero: btValorGenero , edad: contValorEdad) // Sección con el boton para finalizar y navegar a la siguiente pantalla pasando parámetros (vista secundaria)
            
        }
        //... Atributos de la VStack principal
        .frame(maxWidth: .infinity, maxHeight: .infinity) // tamaño de VStack
            .background(.appBackGround) // color del fondo personalizado
            .navigationTitle("Índice de masa corporal") // Nombre de la Toolbar (1 forma - personalizado en _Curso:iOSApp)
            /**.toolbar {  // Nombre de la Toolbar (2 forma - personalizado en aquí)
                 ToolbarItem(placement: .principal) { // Personaliza el título
                    Text("Índice de masa corporal")
                         .foregroundColor(.white) // Cambia el color del texto
                         .bold()
                 }
             }*/
            /**.navigationBarBackButtonHidden(true)  // Eliminar el boton de ir para atrás */
    }
}

// 1_Texto personalizado
struct InformationText:View {
    
    // Variable
    let text:String
    
    var body:some View {
        Text(text)
            //... Atributos del texto
            .font(.largeTitle) // tamaño
            .bold() // grosor
            .foregroundColor(.white) // color de letras
    }
}

// 2_Sección botón personalizado (vista secundaria)
struct ToogleButton:View{
    
    // Variables
    let text:String
    let imageName:String
    let genero:Int
    @Binding var selectedGenero:Int // se recibe del IMCView (es como el anzuelo), es clave para que los cambios en 'selectedGenero' se reflejen en la vista principal en la variable '@State var genero', que es la que se recibe.
    
    var body: some View {
        
        // variable dinámica dependiendo si coincide el 'genero' con boton pulsado variable 'selectedGenero'
        let color = (genero == selectedGenero) ? Color.selectComponentBackground : Color.componentBackground
        
        Button(action:  { // la acción del boton
            selectedGenero = genero
            }
        )
        { // el aspecto del boton
            VStack {
                Image(systemName: imageName) // icono de SF (por eso systemName)
                    //... Atributos de la imagen
                    .resizable() // que se reescale bien
                    .scaledToFit() // o scaledToFill()
                    .frame(height: 100) // dimensiones
                    .foregroundColor(.white) // fondo
                   
                InformationText(text: text) // 1_Texto personalizado
            }
        }
        //... Atributos de la boton
        .frame(maxWidth: .infinity, maxHeight: .infinity) // dimensiones
        .background(color) //fondo de color dinamico dependiendo si ha sido seleccionado o no

    }
}

// 3_Texto personalizado 2
struct TitleText:View {
    
    let text:String
    
    var body: some View {
        Text(text)
        //... Atributos del Text
            .font(.title2)
            .foregroundColor(Color.gray)
    }
}

// 4_Sección con Slider personalizado (vista secundaria)
struct CalculadorAltura:View {
    
    @Binding var selectedAltura:Double // valor del slider
    
    var body: some View {
        
        VStack { // VStack unico
            TitleText(text: "Altura")  //3_Texto personalizado 2
            
            InformationText(text: "\(Int(selectedAltura)) cm") // 1_Texto personalizado
            
            Slider(value: $selectedAltura, in: 100...230, step: 2) // valor, rangos, variables del valor
                //... Atributos del Slider
                .accentColor(Color.purple) // color
                .padding(.horizontal, 20) // padding
            
        }
        //... Atributos del VStack unico
        .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.componentBackground)
    }
}


// 5_Botón contador
struct BotonContador:View{
    
    // Variables
    let icono:String
    @Binding var contador:Int
    
    // Función contador segun el icono recibido
    func actionContador() -> Void {
        if icono == "minus" {
            if  contador > 0 {
                contador -= 1
            }
        } else {
            if contador < 140 {
                contador += 1
            }
        }
    }
    
    var body: some View {
        Button(action:actionContador) // accion boton
        { // aspecto boton
            Image(systemName: icono)
            //... Atributos del Imagen
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .foregroundColor(Color.white)
        }
        //... Atributos del boton
        .padding(15)
        .background(.purple)
        .clipShape(Circle()) // Hace que el botón sea completamente redondo
        
    }
}

// 6_Sección de un contador con dos botones (vista secundaria)
struct ContadorParametro:View{
    
    // Variables
    let textTitle:String
    @Binding var contador:Int
    
    var body: some View {
        
        VStack{
            TitleText(text: textTitle) // 3_Texto Personalizado 2
            InformationText(text:"\(contador)") // 1_Texto Personalizado
            
            HStack{
                // Botones
                BotonContador(icono: "minus", contador: $contador) // 5_Botón contador
                BotonContador(icono: "plus", contador: $contador)  // 5_Botón contador
            }
            
        }
        //... Atributos del VStack
        .frame(maxWidth: .infinity, maxHeight: .infinity) // dimensiones
            .background(.componentBackground) // fondo de color
        
    }
}

// 7_Sección con el boton para finalizar y navegar a la siguiente pantalla pasando parámetros (vista secundaria)
struct BotonFinal: View {
    
    // Variables
    let peso:Double
    let altura: Double
    let genero:Int
    let edad:Int
    
    func generoNombre() -> String {
        return genero == 0 ? "Hombre" : "Mujer"
    }
    
    var body: some View {
        
        NavigationStack // contenedor de navegación
        {
            NavigationLink(destination: {IMCResult(pesoUsuario:peso, alturaUsuario:altura, generoUsuario: generoNombre(), edadUsuario: edad)}) // Link navegación al IMCResult
            {
                Text("Finalizar")
                    // Atributos del Text
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
