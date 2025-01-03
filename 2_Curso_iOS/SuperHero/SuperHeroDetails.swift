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
                        
                        Spacer()
                        
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
            }.navigationTitle(" #\(id) - Detalles de Superheroe")
            .foregroundStyle(Color.white)
    }
}

struct SuperHeroStats:View {
    
    let stats:ApiNetwork.Powestats
    
    var body: some View {
        
        let dicEstatistica:  [Color:Int] = [
            .green: Int(stats.combat) ?? 0,
            .brown: Int(stats.speed) ?? 0,
            .red: Int(stats.strength) ?? 0,
            .blue: Int(stats.durability) ?? 0,
            .orange: Int(stats.intelligence) ?? 0
        ]
        
        let totalPoderes:Int = dicEstatistica.values.reduce(0, +)  // Sumar todos los valores
        
        let arrayLeyenda: [String] = ["Combate", "Velocidad", "Fuerza", "Resistencia", "Inteligencia"]
        
        VStack {
            Text("Estadísticas")
                .font(.title2)
                .bold()
                .padding(.horizontal, 15)
                .foregroundStyle(Color.white)
                .padding(.top, 30)
            
            
            Chart{
                ForEach(Array(dicEstatistica.enumerated()), id: \.element.key){ index, element in
                    
                    let poder = element.value
                    let colorSection = element.key
             
                    SectorMark(
                        angle: .value("Counter", poder), // el ángulo va a ser un valor llamado 'Count' con 'stats.combat' como valor, luego el radio y el angulo serán personalizaciones
                        innerRadius: .ratio(0.5), // el grosor del donut
                        angularInset: 2 // Espaciado, separacion entre por sección
                    )
                    .cornerRadius(8)
                    .foregroundStyle(colorSection) // Usa el color dinámico
                    // .foregroundStyle(by: .value("Category", "Combate")) // permite meter una leyenda de esta seccion,comentada porque me saca en otro color y no puedo modificarla
                    
                }
            }
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, maxHeight: 250)
            
            // Leyenda personalizada (las 3 primeras)
            HStack{
                ForEach(Array(dicEstatistica.enumerated()), id: \.element.key){ index, element in // enumerated() para poder obtener tb el index
                    
                    let colorSection:Color = element.key
                    let nombreSection:String = arrayLeyenda[index]
                    let percentage = (Double(element.value) / Double(totalPoderes)) * 100 // Calcular el porcentaje
                    
                    if index < 3 {
                        Circle()
                            .fill(colorSection) // Color para el combate
                            .frame(width: 8, height: 8)
                        Text("\(nombreSection) - \(String(format: "%.1f%%", percentage))") // Texto de la leyenda
                            .foregroundColor(.white) // Texto blanco para la leyenda
                            .font(.footnote)
                            .padding(.trailing, 1)
                    }
                    
                }
                
            }.frame(maxWidth: 380)
            
            // Leyenda personalizada (las 2 siguientes)
            HStack{
                ForEach(Array(dicEstatistica.enumerated()), id: \.element.key){ index, element in // enumerated() para poder obtener tb el index
                    
                    let colorSection:Color = element.key
                    let nombreSection:String = arrayLeyenda[index]
                    let percentage = (Double(element.value) / Double(totalPoderes)) * 100 // Calcular el porcentaje
                    
                    if index > 2 {
                        Circle()
                            .fill(colorSection) // Color para el combate
                            .frame(width: 8, height: 8)
                        Text("\(nombreSection) - \(String(format: "%.1f%%", percentage))") // Texto de la leyenda
                            .foregroundColor(.white) // Texto blanco para la leyenda
                            .font(.footnote)
                            .padding(.trailing, 10)
                    }
                    
                }
                
            }.frame(maxWidth: 380)
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
