//
//  Place.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 3/1/25.
//

import Foundation
import MapKit

struct Place:Identifiable, Codable { // Codable, antes lo usabamos para la API ahora necesario para deserializar y serializar JSON para la BD (base de datos)
    var id:UUID = UUID()
    var name:String
    var coordinates:CLLocationCoordinate2D
    var fav:Bool
    
    enum CodingKeys:CodingKey {
        case id, name, fav, latitude, longitude // añadido 'latitude, longitude' para decodificar luego 'coordinates' (eliminandolo de aqui)
    }
    
    // constructor normal
    init(id:UUID = UUID(), name: String, coordinates: CLLocationCoordinate2D, fav: Bool) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.fav = fav
    }
    
    // contructor especial: para poder decodear
    init(from decoder: Decoder) throws {
        
        // preparamos el modelo, para atomizarlo
        let container = try decoder.container(keyedBy: CodingKeys.self) // el contenedor lo vamos a poder sacarla de aqui para obtener la longitud y latitud de CLLocationCoordinate2D
        
        // ahora se llama al container y se saca del objeto CLLocationCoordinate2D
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.fav = try container.decode(Bool.self, forKey: .fav)
    }
    
    // funcion especial: para codificar (lo contrario al constructor de decodificar)
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(coordinates.latitude, forKey: .latitude)
        try container.encode(coordinates.longitude, forKey: .longitude)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(fav, forKey: .fav)
    }
}
