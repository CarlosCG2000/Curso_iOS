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
            NavigationLink(destination: MenuView()) {
                Text("IMC Calculator")
            }

            Text("App 2")
            Text("App 3")
            Text("App 4")
            
        }
    }
}

#Preview {
    MenuView()
}
