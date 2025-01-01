//
//  __Curso_iOSApp.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 31/12/24.
//

import SwiftUI

@main
struct __Curso_iOSApp: App {
    
    // CONFIGURACION DEL TOOLBAR PARA TODOS LOS COMPONENTES
    init() {
        let appearance = UINavigationBarAppearance() // para la barra superior (toolbar)
        
        // Configuración del título en la barra de navegación (toolbar)
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 17) // Texto en negrita, tamaño 17
        ]
        
        /**
         appearance.buttonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white
         ] // Color del botón "Back"
        */
        
        // Aplicar la apariencia a UINavigationBar
        UINavigationBar.appearance().tintColor = UIColor.purple // Cambiar el color de la flecha de "Back" ❌
        UINavigationBar.appearance().standardAppearance = appearance
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
    
}
