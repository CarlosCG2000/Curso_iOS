//
//  CustomDialog.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 3/1/25.
//

import SwiftUI

struct CustomDialog<Content:View>: View {
    
    let closeDialog:()->Void // recibe una funcion lambda, mucho mas personalizable, pudiendo recibir cualquier cosa no solo una variable de un tipo
    let onDismissOutside:Bool // sirve paraopulsar fuera del dialogo y cerrarlo
    let content:Content // va a ser la vista que se va arecibir por parámetro
    
    var body: some View {
        
        ZStack{
            Rectangle().fill(.gray.opacity(0.7))
                .ignoresSafeArea()
                .onTapGesture { // se va a controlar cuando se pulsa a la vista
                    if onDismissOutside { // si esta habilitado el pulsar para salir desde fuera
                        withAnimation {
                            closeDialog()
                        }
                    }
                }
            
            content.frame(
                width: UIScreen.main.bounds.size.width-100, // -100 para que no toque los bordes
                height: 300
               ).padding()
                .background(.white)
                .cornerRadius(16)
                .overlay(alignment: .topTrailing){ // para crear contenido encima de la propia vista, 'topTrailing' para que me lo alinee en la parte de arriba
                    Button(
                        action: {
                            withAnimation {
                                closeDialog()
                            }
                        },
                        label: {
                            Image(systemName: "xmark.circle")
                        }
                    ).foregroundStyle(.gray)
                        .padding(16)
                    
                }.ignoresSafeArea() // es el area de seguridad la parte de abajo y de arriba
                .frame(width: UIScreen.main.bounds.width,
                       height: UIView.layoutFittingCompressedSize.height, // para obtener el tamaño exacto de la pantaña
                       alignment: .center)
        }
    }
}


/**
 #Preview {
 CustomDialog(closeDialog: <#() -> Void#>, onDismissOutside: <#Bool#>, content: <#_#>)
 }
 */
