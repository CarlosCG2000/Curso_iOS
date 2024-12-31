//
//  ContentView.swift
//  02_CursoiOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack { // Vista 1
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            Text("Hello, world!").bold().background(Color.green).foregroundColor(.pink)
            
            Button( action: { print("Pulsado el botón") },
                    label: { Text("Boton") }
            )
            
        }
        .padding()
    }
}

// Para visualizar la vista
#Preview {
    ContentView()
}
