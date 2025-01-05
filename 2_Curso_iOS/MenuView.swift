//
//  MenuView.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

// MENÚ PARA TODAS LAS APLICACIONES (3)
struct MenuView: View {
    
    var body: some View {
        
        // NavigationStack es el contenedor que organiza las vistas en una pila de navegación.
        NavigationStack {
            // List contiene los elementos (NavigationLink) que actúan como opciones del menú.
            List {
                // NavigationLink (3) contiene los elementos (NavigationLink) que actúan como opciones del menú.
                NavigationLink(destination: IMCView()) { // 1_Navega a IMCView
                    Text("Cálculo IMC (APP)")
                } // .frame(maxWidth: .infinity, alignment: .center)
                
                NavigationLink(destination: SuperHeroBuscador()) { // 2_Navega a SuperHeroBuscador
                    Text("SuperHeroe (APP)")
                }
                
                NavigationLink(destination: SitiosFavoritos()) { // 3_Navega a SitiosFavoritos
                    Text("Mapa Fav (APP)")
                }
            }
            //... Atributos de la List (lista)
            .frame(width: 300, height: 135) // tamaño lista
            .border(.appBackground,width: 3) // bordes color y grosor
            .cornerRadius(5) // bordes definición
            .listStyle(.plain) // opcional: estilo de lista
            
        }
        //... Atributos del NavigationStack (contenedor de la List y enlaces (NavigationLink)
        .tint(.white) // este atributo modifica como se ven los elementos predefinidos de Apple como el icono de ir hacia atrás
    }
}

#Preview {
    MenuView()
}
