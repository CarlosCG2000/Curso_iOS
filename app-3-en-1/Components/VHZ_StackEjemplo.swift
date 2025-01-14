//
//  ContentView.swift
//  02_CursoiOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

struct Ejercicio1: View {
    var body: some View {
        
        ZStack { // contenido elementos encima (padding)
            VStack{ // contenido elementos verticalemte (fondo rojo)
                HStack{ // contenido elementos horizontalmente
                    Rectangle().fill(Color.blue)
                    Rectangle().fill(Color.orange)
                    Rectangle().fill(Color.yellow)
                }.frame(height: 100)
                
                Rectangle().fill(Color.orange).frame(height: 100)
                
                HStack{ // contenido elementos horizontalmente
                    Circle().fill(Color.green)
                    Rectangle().fill(Color.black).frame(width: 100)
                    Circle().fill(Color.indigo)
                }
                
                Rectangle().fill(Color.orange).frame(height: 100)
                
                HStack{ // contenido elementos horizontalmente
                    Rectangle().fill(Color.blue)
                    Rectangle().fill(Color.orange)
                    Rectangle().fill(Color.yellow)
                }.frame(height: 100)
                
            }.background(.red)
        }.padding(.bottom, 50).padding(.top, 50)
        
        /** VStack { // Vista 1
            
            Rectangle().fill(Color.blue).frame(height: 50).padding(.bottom, 20).padding(.horizontal, 50)
            Rectangle().fill(Color.blue).frame(height: 50)
            Text("Pepe")
            HStack{
                Text("Carlos")
                Text("Sebastian").bold().frame(width: 100, height: 50)
            }
            Text("Pepe")
            
            
             Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Text("Hello, world!").bold().background(Color.green).foregroundColor(.pink)
            
            Button( action: { print("Pulsado el botón") },
                    label: { Text("Boton") }
            )
        }
        .padding() */
    }
}

// Para visualizar la vista
#Preview {
    Ejercicio1()
}

