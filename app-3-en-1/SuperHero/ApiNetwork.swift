//
//  ApiNetwork.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 2/1/25.
//

import Foundation

class ApiNetwork {
    
    let apiKey = "ab9e879023c702cc77af432687850fc2"
    
    // =========================== ESTA PARTE SERIA EN EL FICHERO DEL MODELO (DATOS CON MISMA ESTRUCTURA QUE LA API) ===========================
    // 1_La estructura Wrapper (envoltura) que se recibe en el Json de la API (tiene que ser Codable), ¡importante poner los mismos nombres que en JSON, (los que se quieran usar)!
    struct Wrapper: Codable { // parsear la información del JSON: Codable,
        let response:String
        let results:[SuperHero] // creo un clase para el SuperHero, en un array de json
        
        init(response: String, results: [SuperHero]) {
            self.response = response
            self.results = results
        }
    }
    
    // 1.1_MODELO: La estructura SuperHero, los datos que recogemos para formar un superheroe en Json (recordar poner los mismos nombres que en JSON)
    struct SuperHero: Codable, Identifiable { // parsear la información del JSON: Codable, Identifiable porque lo voy a tener wue recorrer en un ForEach
        let id:String
        let name:String
        let image:ImageSuperHero // es otro json dentro del json
    }
    
    // 1.2_La estructura 'ImageSuperHero' de la imagen del json
    struct ImageSuperHero:Codable {
        let url:String
    }
    
    // 2_MODELO: La estructura de 'SuperHeroComplete', es otra llamada a la API que devuelve otro json (recordar poner los mismos nombres que en JSON)
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
    
    // ========== ESTA PARTE SERIA EN EL FICHERO DEL REPOSITORIO (CON LA LÓGICA DE LA LLAMADA AL MÓDELO A TRAVÉS DE UNA API) ==========
    // Listado de superheroes
    // https://www.superheroapi.com/api.php/ab9e879023c702cc77af432687850fc2/search/super

    // 1_Función para obtener todos los heroes a través de un string
    func getHeroesByQuery(query: String) async throws -> Wrapper { // de forma 'async' al ser una llamada externa a un API, 'throws' significa que pueden dar un error no tiene porque solo devolver el Wrapper

        // guard: en Swift es una forma de controlar errores o condiciones que deben cumplirse antes de que una función o un bloque de código pueda continuar su ejecución. Es como una "puerta de seguridad": si la condición no se cumple, se ejecuta un bloque alternativo, y la función o el bloque actual termina temprano.
        guard let url = URL(string: "https://www.superheroapi.com/api.php/\(apiKey)/search/\(query)") else {
            print("URL inválida")
            return Wrapper(response: "", results: []) // Devuelve un Wrapper vacío en caso de URL inválida
        }
        
        // Manejando los errores (es posible no poner el 'do y catch' y transpasar el error al siguiente nivel y que sea en ese siguiente nivel donde se realice el 'do y catch'. Por ejemplo hacerlo ya en la vista para poder mostrar en pantalla los errores directamente.
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
    
    // Superheroe en particular por detalles
    // https://www.superheroapi.com/api.php/ab9e879023c702cc77af432687850fc2/5
    
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
