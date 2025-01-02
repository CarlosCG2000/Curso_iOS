//
//  ApiNetwork.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 2/1/25.
//

import Foundation

class ApiNetwork {
    
    struct Wrapper:Codable { // parsear la información del JSON: Codable
        let response:String
        let results:[SuperHero]
    }
    
    struct SuperHero:Codable, Identifiable { // parsear la información del JSON: Codable
        let id:String
        let name:String
        let image:ImageSuperHero
    }
    
    struct ImageSuperHero:Codable {
    let url:String
    }
    
    
    func getHeroesByQuery(query: String) async throws -> Wrapper { // de forma 'async' al ser una llamada externa a un API, 'throws' significa que pueden dar un error no tinene porque solo devolver el Wrapper
        
        let apiKey = "ab9e879023c702cc77af432687850fc2"
        let url = URL(string: "https://www.superheroapi.com/api.php/\(apiKey)/search/\(query)")
        
        let (data, _) = try await URLSession.shared.data(from: url!) // obtener los datos de la API
        
        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data) // convertir a la clase Wrapper
        
        return wrapper
    }
}

