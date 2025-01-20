//
//  DB_UserDefaults.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 3/1/25.
//

import Foundation

// =========================== ESTO SERIA EN EL FICHERO DEL 'REPOSITORIO' (CON LA LÓGICA) ===========================
// es una extension, que obtienen todos las variables y funciones del la vista `SitiosFavoritos`, pero al ponerlas aqui es mas escalable y más limpio
extension SitiosFavoritos { // estamos conectados a todo lo de 'SitiosFavoritos', como puede ser la variable 'Place', pero asi esta mas escalable al no ponerlo todo en el mismo archivo
    
    func guardarPlaces() {
        if let encodeData = try? JSONEncoder().encode(places) { // si funciona la variable encodeData entrará a en el if: vas a convertir el listado de places en un JSON
            
            UserDefaults.standard.set(encodeData, forKey: "places") // va a guardar la informacion de encodeData en "places"
        }
        
    }
    
    func cargarPlaces() {
        if let decodeData = UserDefaults.standard.data(forKey: "places") { // vas a buscar los datos que contenga "places"
            let decodePlaces = try? JSONDecoder().decode([Place].self, from: decodeData) // decodifica para obtener los datos que van a ser un array de Place ([Place])
            
            // si todo funciona, le damos al valor de places definido en SitiosFavoritos, los valores guardado en esta BD (UserDefaults)
            places = decodePlaces ?? []
        }
    }

}
