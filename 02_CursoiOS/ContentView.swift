//
//  ContentView.swift
//  02_CursoiOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            
            Button( action: { print("Pulsado el botón") },
                    label: { Text("Boton") }
            )
                
            }
        .padding()
    }
}

#Preview {
    ContentView()
}
