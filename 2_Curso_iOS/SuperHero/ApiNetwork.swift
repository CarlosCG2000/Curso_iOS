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
    
    struct SuperHeroComplete:Codable {
        let id:String
        let name:String
        let image:ImageSuperHero
        let powerstats: Powestats
        let biography:Biograph
    }
    
    struct Powestats:Codable {
        let strength:String
        let intelligence:String
        let speed:String
        let durability:String
        let power:String
        let combat:String
    }
    
    struct Biograph:Codable{
        let fullName:String // en la API es full-name, peor no se acepta el '-'
        let publisher:String
        let alignment: String
        let aliases: [String]
        
        // oara que sepa que no existe 'fullName' y por ello que en la API se busque por 'full-name'
        enum CodingKeys: String, CodingKey {
            case fullName = "full-name"
            case publisher
            case alignment
            case aliases
        }
    }
    
    func getHeroesByQuery(query: String) async throws -> Wrapper { // de forma 'async' al ser una llamada externa a un API, 'throws' significa que pueden dar un error no tinene porque solo devolver el Wrapper
        
        let apiKey = "ab9e879023c702cc77af432687850fc2" 
        let url = URL(string: "https://www.superheroapi.com/api.php/\(apiKey)/search/\(query)")
        
        let (data, _) = try await URLSession.shared.data(from: url!) // obtener los datos de la API
        
        let wrapper = try JSONDecoder().decode(Wrapper.self, from: data) // convertir a la clase Wrapper
        
        return wrapper
    }
    
    func getHeroeById(id:String) async throws -> SuperHeroComplete {
        
        let apiKey = "ab9e879023c702cc77af432687850fc2"
        let url = URL(string: "https://www.superheroapi.com/api/\(apiKey)/\(id)")
        
        let (data, _) = try await URLSession.shared.data(from: url!)
        
        let superHeroItem = try JSONDecoder().decode(SuperHeroComplete.self, from: data)
        
        return superHeroItem
        
    }
}

