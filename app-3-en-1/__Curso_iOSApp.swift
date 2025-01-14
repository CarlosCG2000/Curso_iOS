//
//  __Curso_iOSApp.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

// PUNTO DE ENTRADA DEL PROYECTO (APP)
@main
struct __Curso_iOSApp: App { // APP
    
    // Configuración general del proyecto
    // _________ Init es el contructor en la inicialización _________
    init() {
        // Configurar la barra superior (Toolbar)
        let appearance = UINavigationBarAppearance()
        
        // * Configuración del título de la barra de navegación (toolbar)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white, // Defecto: UIColor.blue,
            .font: UIFont.boldSystemFont(ofSize: 20) // Texto en negrita, tamaño 20
        ]
    
        // * Configuración del texto "Back" del boton para ir hacia atrás
         appearance.buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white, // Defecto: UIColor.blue,
         ]
        
        // * Configuración del icono del botón para ir hacia atrás se realiza en el 'MenuView' (primera vista funcional de proyecto)
        
        // Aplicar la apariencia a UINavigationBar
        UINavigationBar.appearance().standardAppearance = appearance
    }
    // ____________________________________
    
    // Lo que se va a enviar ('some Scene': define la estructura principal de la interfaz de usuario de tu aplicación.)
    var body: some Scene {
        WindowGroup {   // WindowGroup: es un contenedor en SwiftUI que organiza una o más ventanas para una aplicación.
            MainView()  // fichero MainView es la primera y unica ventana que se muestra inicialmente cuando se inicia la aplicación.
        }
    }
    
}
