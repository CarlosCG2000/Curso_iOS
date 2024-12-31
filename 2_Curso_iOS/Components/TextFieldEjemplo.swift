//
//  TextFieldEjemplo.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

struct TextFieldEjemplo: View {
    
    @State private var email:String = ""
    @State private var password:String = ""
    @State private var isPasswordVisible: Bool = false

    
    var body: some View {
        
        VStack(alignment: .leading) {
            TextField("Escribe tu email", text: $email)
                .keyboardType(.emailAddress)
                .frame(width: 280)
                .padding(16)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(16)
                .padding(.horizontal, 32)
                .onChange(of: email) { oldValue, newValue in
                    if newValue.isEmpty {
                        password = ""
                    } else {
                        print("El antiguo valor: \(oldValue) y el nuevo valor es: \(newValue)")
                    }
                }
            
            HStack {
                   if isPasswordVisible {
                       TextField("Escribe tu contraseña", text: $password)
                           .autocapitalization(.none)
                           .frame(width: 280)
                           .disableAutocorrection(true)
                           .padding(16)
                           .background(Color.gray.opacity(0.2))
                           .cornerRadius(16)
                   } else {
                       SecureField("Escribe tu contraseña", text: $password)
                           .frame(width: 300)
                           .autocapitalization(.none)
                           .disableAutocorrection(true)
                           .padding(16)
                           .background(Color.gray.opacity(0.2))
                           .cornerRadius(16)
                   }
                   
                   Button(action: {
                       isPasswordVisible.toggle()
                   }) {
                       Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                           .foregroundColor(.gray)
                   }
                   .padding(.trailing, 8) // margen derecho, el izquierdo es leading
               }
               .padding(.horizontal, 32)
            
            
        }
        
    }
}

#Preview {
    TextFieldEjemplo()
}
