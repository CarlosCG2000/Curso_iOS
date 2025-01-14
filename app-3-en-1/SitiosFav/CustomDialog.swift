//
//  CustomDialog.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 3/1/25.
//

import SwiftUI

struct CustomDialog<Content:View>: View {
    
    // _______________  VARIABLES _______________
    let closeDialog:()->Void // recibe una funcion lambda, mucho mas personalizable, pudiendo recibir cualquier cosa no solo una variable de un tipo. Lo que recibe es la función para cerrar el dialogo
    let onDismissOutside:Bool // sirve para pulsar fuera del dialogo y cerrarlo (de forma opcional si es true o false)
    let content:Content // va a ser la vista que se va a recibir por parámetro
    
    var body: some View {
        
        ZStack{
            // __________ 1_Rectangulo que cubre toda la pantalla y la pone traslucida __________
            Rectangle()
                .fill(.gray.opacity(0.7))
                .ignoresSafeArea()
                .onTapGesture { // se va a controlar cuando se pulsa a la vista
                    if onDismissOutside { // si esta habilitado el pulsar para salir desde fuera
                        withAnimation {
                            closeDialog() // cerrar el dialogo
                        }
                    }
                }
            
            // __________ 2_La vista que pasamos por parámetro (con todos las labels, input, botones, ...) __________
            content
                //... Atributos del Content
                .frame(
                    width: UIScreen.main.bounds.size.width-100, // -100 para que no toque los bordes
                    height: 300
                )
                .padding()
                .background(.white)
                .cornerRadius(16)
                // Se superpone un Boton en la vista (content)
                .overlay(alignment: .topTrailing) { // para crear contenido encima de la propia vista, 'topTrailing' para que me lo alinee en la parte de arriba
                    // 2.1_Botón para poder cerrar con el dialogo (necesario en caso de 'onDismissOutside' sea false)
                    Button (
                        action: {
                            withAnimation {
                                closeDialog()
                            }
                        },
                        label: {
                            Image(systemName: "xmark.circle")
                        }
                    )
                    //... Atributos de Button
                    .foregroundStyle(.gray)
                    .padding(16)
                    
                }
                .ignoresSafeArea() // es el area de seguridad la parte de abajo y de arriba
                .frame(width: UIScreen.main.bounds.width,
                       height: UIView.layoutFittingCompressedSize.height, // para obtener el tamaño exacto de la pantalla
                       alignment: .center)
        }
        // ________________________________________
    }
}


/**
 #Preview {
 CustomDialog(closeDialog: <#() -> Void#>, onDismissOutside: <#Bool#>, content: <#_#>)
 }
 */
