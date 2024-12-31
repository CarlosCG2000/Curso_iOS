//
//  TextEjemplo.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

struct TextEjemplo: View {
    var body: some View {
        Text("Hello, World!").font(.largeTitle)
        Text("Custom Font").font(.system(
                                        size:40,
                                        weight: .light,
                                        design: .monospaced))
                            .underline(true)
                            .foregroundStyle(Color.red)
                            .background(Color.cyan)
        Text("aris is a great programmer, he is very good at coding")
            .frame(width:100)
            .lineLimit(10)
            .lineSpacing(10)
}
}

#Preview {
    TextEjemplo()
}
