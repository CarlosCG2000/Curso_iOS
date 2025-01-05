//
//  ApiNetwork.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 2/1/25.
//

import Foundation

class ApiNetwork {
    
    let apiKey = "ab9e879023c702cc77af432687850fc2"
    
    // 1_La estructura Wrapper que se recibe en el json de la API (tiene que ser Codable), ¡importante poner los mismos nombres que en JSON, (los que se quieran usar)!
    struct Wrapper: Codable { // parsear la información del JSON: Codable,
        let response:String
        let results:[SuperHero] // creo un clase para el SuperHero, en un array de json
        
        init(response: String, results: [SuperHero]) {
            self.response = response
            self.results = results
        }
    }
    
    // 1.1_La estructura SuperHero, los datos que recogemos para formar un superheroe en json (recordar poner los mismos nombres que en JSON)
    struct SuperHero: Codable, Identifiable { // parsear la información del JSON: Codable, Identifiable porque lo voy a tener wue recorrer en un ForEach
        let id:String
        let name:String
        let image:ImageSuperHero // es otro json dentro del json
    }
    
    // 1.2_La estructura ImageSuperHero de la imagen del json
    struct ImageSuperHero:Codable {
        let url:String
    }
    
    // 2_La estructura de SuperHeroComplete, es otra llamada a la API que devuelve otro json (recordar poner los mismos nombres que en JSON)
    struct SuperHeroComplete:Codable {
        let id:String
        let name:String
        let image:ImageSuperHero // otro json dentro del json
        let powerstats: Powestats // otro json dentro del json
        let biography:Biograph // otro json dentro del json
    }
    
    // 2.1_La estructura de Powestats, con los poderes (recordar poner los mismos nombres que en JSON)
    struct Powestats:Codable {
        let strength:String
        let intelligence:String
        let speed:String
        let durability:String
        let power:String
        let combat:String
    }
    
    // 2.2_La estructura de Powestats, con la biografia (problema con la etiqueta full-name en json que no se puede poner igual aqui en el script) (recordar poner los mismos nombres que en JSON)
    struct Biograph:Codable{
        let fullName:String // en la API es full-name, pero no se acepta el '-'
        let publisher:String
        let alignment: String
        let aliases: [String]
        
        // Para que sepa que no existe 'fullName' y por ello que en la API se busque por 'full-name'
        enum CodingKeys: String, CodingKey {
            case fullName = "full-name"
            case publisher
            case alignment
            case aliases
        }
    }
    
    // 1_Función para obtener todos los heroes a través de un string
    func getHeroesByQuery(query: String) async throws -> Wrapper { // de forma 'async' al ser una llamada externa a un API, 'throws' significa que pueden dar un error no tinene porque solo devolver el Wrapper

        // guard: en Swift es una forma de controlar errores o condiciones que deben cumplirse antes de que una función o un bloque de código pueda continuar su ejecución. Es como una "puerta de seguridad": si la condición no se cumple, se ejecuta un bloque alternativo, y la función o el bloque actual termina temprano.
        guard let url = URL(string: "https://www.superheroapi.com/api.php/\(apiKey)/search/\(query)") else {
            print("URL inválida")
            return Wrapper(response: "", results: []) // Devuelve un Wrapper vacío en caso de URL inválida
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url) // obtener los datos de la API
                
            // Intenta decodificar los datos en un Wrapper
            let wrapper = try JSONDecoder().decode(Wrapper.self, from: data) // convertir a la clase Wrapper
            return wrapper
            
        } catch { // si no existe ningun superheroe con ese texto
            print("Error al obtener o decodificar los datos: \(error.localizedDescription)")
            return Wrapper(response: "", results: []) // Devuelve un Wrapper vacío en caso de error
        }
        
    }
    
    // 2_Función para obtener un heroe en particular
    func getHeroeById(id:String) async throws -> SuperHeroComplete? {
        
        guard let url = URL(string: "https://www.superheroapi.com/api/\(apiKey)/\(id)") else {
            print("URL inválida")
            return nil
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let superHeroItem = try JSONDecoder().decode(SuperHeroComplete.self, from: data) // convertir a la clase SuperHeroComplete
            return superHeroItem
            
        } catch { // si no existe ese superheroe
            print("Error al obtener o decodificar los datos: \(error.localizedDescription)")
            return nil
        }
    }
}

// Listado de superheroes
// https://www.superheroapi.com/api.php/ab9e879023c702cc77af432687850fc2/search/super
/** {
"response": "success",
"results-for": "super",
"results": [
    {
    "id": "195",
        "name": "Cyborg Superman",
        "powerstats": {
            "intelligence": "75",
            "strength": "93",
            "speed": "92",
            "durability": "100",
            "power": "100",
            "combat": "80"
        },
        "biography": {
            "full-name": "Henry Henshaw",
            "alter-egos": "No alter egos found.",
            "aliases": [
                "Grandmaster of the Manhunters",
                "Herald of the Anti-Monitor",
                "Alpha-Prime of the Alpha Lanterns"
            ],
            "place-of-birth": "-",
            "first-appearance": "Adventures of Superman #466 (May, 1990)",
            "publisher": "DC Comics",
            "alignment": "bad"
        },
        "appearance": {
            "gender": "Male",
            "race": "Cyborg",
            "height": [
                "-",
                "0 cm"
            ],
            "weight": [
                "- lb",
                "0 kg"
            ],
            "eye-color": "Blue",
            "hair-color": "Black"
        },
        "work": {
            "occupation": "-",
            "base": "Warworld, Qward, Antimatter Universe, formerly Biot, Sector 3601"
        },
        "connections": {
            "group-affiliation": "Alpha Lantern Corps, Manhunters, Warworld, formerly Apokolips and Sinestro Corps",
            "relatives": "Terri Henshaw (wife, deceased)"
        },
        "image": {
            "url": "https://www.superherodb.com/pictures2/portraits/10/100/667.jpg"
        }
    },
 {
 "id": "641",
    "name": "Superboy",
    "powerstats": {
    "intelligence": "75",
    "strength": "95",
    "speed": "83",
    "durability": "90",
    "power": "95",
    "combat": "60"
    },
    "biography": {
    "full-name": "Kon-El / Conner Kent",
    "alter-egos": "No alter egos found.",
    "aliases": [
    "Experiment 13; Superman; Project: Superman; Carl Krummett; Project: Lionel Luthor; The Metropolis Kid",
    "Superman"
    ],
    "place-of-birth": "Project Cadmus cloning facility",
    "first-appearance": "Adventures of Superman #500 (June, 1993)",
    "publisher": "DC Comics",
    "alignment": "good"
    },
    "appearance": {
    "gender": "Male",
    "race": "null",
    "height": [
    "5'7",
    "170 cm"
    ],
    "weight": [
    "150 lb",
    "68 kg"
    ],
    "eye-color": "Blue",
    "hair-color": "Black"
    },
    "work": {
    "occupation": "-",
    "base": "San Francisco; Smallville; Formerly Metropolis; Formerly Honolulu"
    },
    "connections": {
    "group-affiliation": "Teen Titans, Legion of Super-Heroes, Team Superman; Formerly Young Justice, Project Cadmus, Ravers",
    "relatives": "Superman (Kryptonian genetic template), Lex Luthor (Human genetic template), Match (clone)"
    },
    "image": {
    "url": "https://www.superherodb.com/pictures2/portraits/10/100/789.jpg"
    }
 }
}*/

/**{
"response": "error",
"error": "character with given name not found"
}*/

// SUPERHEROE POR DETALLES
// https://www.superheroapi.com/api.php/ab9e879023c702cc77af432687850fc2/5

/**
 {
 "response": "success",
 "id": "5",
 "name": "Abraxas",
 "powerstats": {
 "intelligence": "88",
 "strength": "63",
 "speed": "83",
 "durability": "100",
 "power": "100",
 "combat": "55"
 },
 "biography": {
 "full-name": "Abraxas",
 "alter-egos": "No alter egos found.",
 "aliases": [
 "-"
 ],
 "place-of-birth": "Within Eternity",
 "first-appearance": "Fantastic Four Annual #2001",
 "publisher": "Marvel Comics",
 "alignment": "bad"
 },
 "appearance": {
 "gender": "Male",
 "race": "Cosmic Entity",
 "height": [
 "-",
 "0 cm"
 ],
 "weight": [
 "- lb",
 "0 kg"
 ],
 "eye-color": "Blue",
 "hair-color": "Black"
 },
 "work": {
 "occupation": "Dimensional destroyer",
 "base": "-"
 },
 "connections": {
 "group-affiliation": "Cosmic Beings",
 "relatives": "Eternity (\"Father\")"
 },
 "image": {
 "url": "https://www.superherodb.com/pictures2/portraits/10/100/181.jpg"
 }
 }
 */

/**
 {
 "response": "error",
 "error": "invalid id"
 }
 */
