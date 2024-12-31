//
//  ImageEjemplo.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

struct ImageEjemplo: View {
    var body: some View {
        Image("youtube")
            .resizable()
            .scaledToFit() //.scaletFill
            .frame(width: 200, height: 200)
            .cornerRadius(20)
        
        Image(systemName: "microphone") // Icono de SF
            .resizable()
            .scaledToFit()
            .frame(width: 50, height: 100)
    }
}

#Preview {
    ImageEjemplo()
}
