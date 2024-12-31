//
//  LabelEjemplo.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

struct LabelEjemplo: View {
    var body: some View {
        Label("Youtube", image: "youtube") // imagen no se puede editar nada
        
        Label("Youtube", systemImage: "video.fill") // icono no se puede editar pero queda bien
        
        Label( title: { Text("Label") },
               icon: { Image("youtube")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 50, height: 50)
                }
            )
    }
}

#Preview {
    LabelEjemplo()
}
