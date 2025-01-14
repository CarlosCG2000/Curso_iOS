//
//  ListEjemplo.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 1/1/25.
//

import SwiftUI

let pokemons = [
    Pokemon(id: 1, name: "Pikachu", tipo: "Electrico"),
    Pokemon(id: 2, name: "Charmander", tipo: "Fuego"),
    Pokemon(id: 3, name: "Bulbasaur", tipo: "Planta"),
    Pokemon(id: 4, name: "Raikazard", tipo: "Fuego"),
]

let digimons = [
    Digimon(name: "Digimon 1"),
    Digimon(name: "Digimon 2"),
    Digimon(name: "Digimon 3"),
    Digimon(name: "Digimon 4"),
    Digimon(name: "Digimon 5"),
    Digimon(name: "Digimon 6"),
    Digimon(name: "Digimon 7"),
    
]

struct ListEjemplo: View {
    
    var body: some View {

        // LISTA 1
        List {
            ForEach(pokemons, id: \.id) { pokemon in // importante poner los ID
                Text("\(pokemon.name) - \(pokemon.tipo)")
            }
        }.frame(width: .infinity, height: 200)
        
        // LISTA 2
        List {
            ForEach(digimons){ digimon in // no hace falta importar el ID (porque digimon es Identifiable)
                Text("\(digimon.name)")
            }
        }.frame(width: .infinity, height: 200)
        
        // LISTA 3
        List {
            Section(header: Text("Pokemons")) {
                ForEach(pokemons, id: \.id) { pokemon in
                    Text("\(pokemon.name) - \(pokemon.tipo)")
                }
            }
            
            Section(header: Text("Digimons")) {
                ForEach(digimons) { digimon in
                    Text("\(digimon.name)")
                }
            }
        }.listStyle(.insetGrouped) //.automatic
        
        
    }
}

struct Pokemon  {
    var id: Int
    var name: String
    var tipo: String
}

struct Digimon: Identifiable {
    var id = UUID()
    var name: String
}

#Preview {
    ListEjemplo()
}
