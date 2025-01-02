//
//  MenuView.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
       
        NavigationStack{

            List {
                    NavigationLink(destination: IMCView()) {
                        Text("Cálculo IMC APP")
                    }.frame(maxWidth: .infinity) // alignment: .center
                    
                    NavigationLink(destination: SuperHeroBuscador()) {
                        Text("SuperHero APP")
                    } .frame(maxWidth: .infinity, alignment: .center)
                    
                    NavigationLink(destination: {}) {
                        Text("App 3")
                    } .frame(maxWidth: .infinity, alignment: .center)
                
            }
            .frame(width: 300, height: 135)
                .border(.appBackground,width: 3)
                .cornerRadius(5)
                .listStyle(.plain) // Opcional: estilo de lista
         
        }
    }
}

#Preview {
    MenuView()
}
