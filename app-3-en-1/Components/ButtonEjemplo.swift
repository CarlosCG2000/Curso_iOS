//
//  ButtonEjemplo.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

struct ButtonEjemplo: View {
    
    var body: some View {
        Button("Presionar") {
            print("Presionado")
        }
        
        Button(action: { print("Presionado boton personalizado")},
               label: {
            Text("Presionar boton personalizado")
                .frame(width: 200, height: 80)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            
        })
    }
}

struct Counter:View {
    
    @State var num = 0 // se necesita poner el @State

    var body: some View {
        
        Button(action: {
            print("Presionado \(num)")
            num += 1
        },
            label: {
            Text("Contador \(num)")
                .font(.title)
                .bold()
                .frame(width: 200, height: 80)
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(10)
            
        })
    }
}


#Preview {
    Counter()
}
