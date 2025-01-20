//
//  Place.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 3/1/25.
//

import Foundation
import MapKit

// =========================== ESTO SERIA EN EL FICHERO DEL 'MODELO' ===========================
// Creamos una estructura clase para almacenar los sitios luego en la Db
// Identifiable: Permite usar esta estructura directamente en vistas como List o ForEach al tener una propiedad única id.
// Codable: Combina los protocolos Encodable y Decodable, permitiendo convertir esta estructura desde y hacia JSON.
struct Place:Identifiable, Codable { // Codable, antes lo usabamos para la API ahora necesario para deserializar y serializar JSON para la BD (base de datos)
    var id:UUID = UUID()
    var name:String
    var coordinates:CLLocationCoordinate2D
    var fav:Bool
    
    // 1_Constructor normal
    init(id:UUID = UUID(), name: String, coordinates: CLLocationCoordinate2D, fav: Bool) {
        self.id = id
        self.name = name
        self.coordinates = coordinates
        self.fav = fav
    }
    
    // CodingKeys: Define las claves que se usarán al codificar o decodificar el objeto.
    enum CodingKeys:CodingKey {
        case id, name, fav, latitude, longitude // le ha eliminado 'coordinates' y añadido 'latitude, longitude' para decodificar.
    }
    
    // 2_Contructor especial: para poder decodear (obtiene un contenedor de claves para extraer valores del JSON)
    init(from decoder: Decoder) throws {
        
        // Preparamos el modelo, para atomizarlo
        let container = try decoder.container(keyedBy: CodingKeys.self) // el contenedor lo vamos a poder sacar de aqui para obtener la longitud y latitud de CLLocationCoordinate2D
        
        // Ahora se llama al container y se saca del objeto CLLocationCoordinate2D
        // Se decodifican como CLLocationDegrees (tipo para representar grados geográficos).
        let latitude = try container.decode(CLLocationDegrees.self, forKey: .latitude)
        let longitude = try container.decode(CLLocationDegrees.self, forKey: .longitude)
        
        // Validar las coordenadas
        guard (-90...90).contains(latitude), (-180...180).contains(longitude) else {
            throw DecodingError.dataCorruptedError(forKey: .latitude,
                                                   in: container,
                                                   debugDescription: "Coordenadas inválidas: latitud debe estar entre -90 y 90, longitud entre -180 y 180.")
        }
        
        // Los datos del Place
        self.coordinates = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.fav = try container.decode(Bool.self, forKey: .fav)
    }
    
    // 3_Funcion especial: para codificar (lo contrario al constructor de decodificar) (crea un contenedor para guardar valores en formato JSON)
    func encode(to encoder: any Encoder) throws {
        
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        // Los datos del Place
        //Se dividen en latitude y longitude antes de codificar
        try container.encode(coordinates.latitude, forKey: .latitude)
        try container.encode(coordinates.longitude, forKey: .longitude)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(fav, forKey: .fav)
    }
}
