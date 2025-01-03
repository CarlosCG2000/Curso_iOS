//
//  SuperHeroDetails.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 2/1/25.
//

import SwiftUI
import SDWebImageSwiftUI
import Charts

struct SuperHeroDetails: View {
    
    let id:String
    @State var superHeroe:ApiNetwork.SuperHeroComplete? = nil // al principio vacio
    @State var loading:Bool = true
    
    var body: some View {
        VStack{
            if loading {
                ProgressView().tint(.white)
            } else if let superHeroe = superHeroe { // si superHeroe no es nil
                
                /**
                 WebImage(url: URL(string: superHeroe.image.url))
                 .resizable()
                 .scaledToFill()
                 .frame(height:250)
                 .clipped() // a veces la imagenes no respetan el frame y hay que hacerle un clipped para que lo corten
                 */
                
                ZStack{
                    WebImage(url: URL(string: superHeroe.image.url))
                        .resizable()
                        .scaledToFill()
                        .padding(.top, 25)
                        .opacity(0.3)
                    
                    VStack{
                        
                        Spacer()
                        
                        Text(superHeroe.name).bold().font(.title).foregroundStyle(Color.white)
                        
                        ForEach(superHeroe.biography.aliases, id:\.self){ alias in //'self' el propio objeto sea el id
                            
                            if alias.contains(";"){
                                let dividedArray = alias.split(separator: ";") // divida el string con ";"
                                    .map { String($0) } // Convierte las subsecuencias resultantes (Substring) en String.
                                
                                ForEach(dividedArray, id:\.self){ aliasDelimitado in
                                    Text(aliasDelimitado).foregroundStyle(Color.white).italic().font(.title3)
                                }
                            } else {
                                Text(alias).foregroundStyle(Color.white).italic().font(.title3)
                            }
                        }
                        
                        SuperHeroStats(stats: superHeroe.powerstats)
                        
                    }.padding(.bottom, 30)
                    
                }
                
                
            }
            
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
            .onAppear{ // cuando aparezca este primer elemento 'VStack' en la pantalla, se va a realizar lo que este dentro como primera funcion
                Task {
                    do {
                        superHeroe = try await ApiNetwork().getHeroeById(id: id)
                    } catch{
                        superHeroe = nil
                        print("Error al obtener el heroe: \(error.localizedDescription)")
                    }
                    loading = false
                }
            }
    }
}

struct SuperHeroStats:View {
    
    let stats:ApiNetwork.Powestats
    
    var body: some View {
        
        let dicEstatistica: [String: Color] = [
            stats.combat: .green,
            stats.durability: .blue,
            stats.intelligence: .orange,
            stats.speed: .brown,
            stats.strength: .red
        ]
        
        let arrayLeyenda: [String] = ["Combate", "Durabilidad", "Inteligencia", "Velocidad", "Fuerza"]

        VStack {
            Text("Estadísticas")
                .font(.title2)
                .bold()
                .padding(.horizontal, 15)
                .foregroundStyle(Color.white)
            
            Chart{
                ForEach(Array(dicEstatistica.keys), id: \.self){ key in
                    
                    let poder = Int(key)
                    let colorSection = dicEstatistica[key] ?? Color.black
                    
                    SectorMark(
                        angle: .value("Counter", poder ?? 0), // el ángulo va a ser un valor llamado 'Count' con 'stats.combat' como valor, luego el radio y el angulo serán personalizaciones
                        innerRadius: .ratio(0.5), // el grosor del donut
                        angularInset: 2 // Espaciado, separacion entre por sección
                    )
                    .cornerRadius(8)
                    .foregroundStyle(colorSection) // Usa el color dinámico
                    // .foregroundStyle(by: .value("Category", "Combate")) // permite meter una leyenda de esta seccion,comentada porque me saca en otro color y no puedo modificarla
                }
            }
            .padding(16)
            .frame(maxWidth: .infinity, maxHeight: 250)
            .padding(32)
            
            // Leyenda personalizada
            let columns = [GridItem(.flexible(), spacing: 16), GridItem(.flexible(), spacing: 16)] // Dos columnas flexibles

            LazyVGrid(columns: columns, spacing: 16) { // Espaciado entre filas
               
                ForEach(Array(dicEstatistica.values.enumerated()), id: \.element){  index, value in // enumerated() para poder obtener tb el index
                    
                    let colorSection:Color = value
                    let nombreSection:String = arrayLeyenda[index]
                    
                    Circle()
                        .fill(colorSection) // Color para el combate
                        .frame(width: 10, height: 10)
                    Text(nombreSection) // Texto de la leyenda
                        .foregroundColor(.white) // Texto blanco para la leyenda
                        .font(.footnote)
                }
    
            }.padding(.horizontal, 16) // Márgenes laterales para todo el contenedor
            
         
        }
    }
    
}

struct leyendaTexto: View {
    let texto:String
    
    var body: some View {
        Text(texto).foregroundStyle(Color.white)
    }
}

#Preview {
    SuperHeroDetails(id:"641")
}
