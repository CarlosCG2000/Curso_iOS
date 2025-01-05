//
//  SuperHeroDetails.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 2/1/25.
//

import SwiftUI
import SDWebImageSwiftUI
import Charts

// VISTA SECUNDARIO: SuperHeroDetails
struct SuperHeroDetails: View {
    
    // VARIABLES
    let id:String
    @State var superHeroe:ApiNetwork.SuperHeroComplete? = nil // al principio vacio
    @State var loading:Bool = true
    
    var body: some View {
        
        VStack { // VStack principal
            
            if loading { // hasta que carge la API
                ProgressView().tint(.white)
                
            } else if let superHeroe = superHeroe { // si superHeroe no es nil (desempaquetado opcional)
                
                /**
                 WebImage(url: URL(string: superHeroe.image.url))
                 .resizable()
                 .scaledToFill()
                 .frame(height:250)
                 .clipped() // a veces la imagenes no respetan el frame y hay que hacerle un clipped para que lo corten
                */
                
                ZStack { // ZStack principal
                    
                    // 1_Imagen del Superheroe
                    WebImage(url: URL(string: superHeroe.image.url))
                        .resizable()
                        .scaledToFill()
                        .padding(.top, 25)
                        .opacity(0.3)
                    
                    VStack { // VStack secundario
                        
                        Spacer()
                        
                        // 2_Nombre del Superheroe
                        Text(superHeroe.name)
                            .bold()
                            .font(.title)
                            .foregroundStyle(Color.white)
                        
                        // 3_Alias del Superheroe
                        ForEach(superHeroe.biography.aliases, id:\.self) { alias in //'self' el propio objeto sea el id
                            
                            if alias.contains(";") { // el json a veces tiene alias separadas en ; en vez del propio json, culpa de la API
                                let dividedArray = alias // se separan en varias alias un mismo alas con ';'
                                                .split(separator: ";") // divida el string con ';'
                                                .map { String($0) } // Convierte las subsecuencias resultantes (Substring) en String.
                                
                                ForEach(dividedArray, id:\.self){ aliasDelimitado in
                                    
                                    Text(aliasDelimitado) // se muestran los alias
                                        .foregroundStyle(Color.white)
                                        .italic()
                                        .font(.title3)
                                }
                            } else { // si la API lo divide bien  el json los alias direntamente las recorre y muestra
                                Text(alias)
                                    .foregroundStyle(Color.white)
                                    .italic()
                                    .font(.title3)
                            }
                        }
                        
                        Spacer()
                        
                        // 4_Sección de las estadisticas del superheroe en una gráfica (vista secundaria)
                        SuperHeroStats(stats: superHeroe.powerstats)
                        
                    }
                    //... Atributos de la VStack secundario
                    .padding(.bottom, 30)
                }
            }
            
        }
        //... Atributos de la VStack principal
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackground)
        .onAppear{ // cuando aparezca este primer elemento 'VStack' en la pantalla, se va a realizar lo que este dentro como primera función
            Task {
                do {
                    superHeroe = try await ApiNetwork().getHeroeById(id: id)
                } catch {
                    superHeroe = nil
                    print("Error al obtener el heroe: \(error.localizedDescription)")
                }
                
                loading = false // se quita el login de carga
            }
        }
        //... Atributos del onAppear
        .navigationTitle(" #\(id) - Detalles de Superheroe") // titulo del encabezado
        .foregroundStyle(Color.white) // texto en blanco
    }
}

// 2_Sección de las estadisticas del superheroe en una gráfica (vista secundaria)
struct SuperHeroStats:View {
    
    let stats:ApiNetwork.Powestats // se obtienen los poderes del superheroe
    
    var body: some View {
        
        // VARIABLES
        let dicEstatistica:  [Color:Int] = [ // array de diccionario [color:poder]
            .green: Int(stats.combat) ?? 0,
            .brown: Int(stats.speed) ?? 0,
            .red: Int(stats.strength) ?? 0,
            .blue: Int(stats.durability) ?? 0,
            .orange: Int(stats.intelligence) ?? 0
        ]
        
        let totalPoderes:Int = dicEstatistica.values.reduce(0, +)  // Sumar todos los valores de los poderes para el porcentaje
        
        // Array del poder pero para el texto en String y español
        let arrayLeyenda: [String] = ["Combate", "Velocidad", "Fuerza", "Resistencia", "Inteligencia"]
        
        VStack {
            Text("Estadísticas")
                .font(.title2)
                .bold()
                .padding(.horizontal, 15)
                .foregroundStyle(Color.white)
                .padding(.top, 30)
            
            // Grafica del circulo
            Chart {
                ForEach(Array(dicEstatistica.enumerated()), id: \.element.key){ index, element in
                    
                    let poder = element.value
                    let colorSection = element.key
             
                    // Cada sector del circulo
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
            //... Atributos del Chart
            .padding(.bottom, 16)
            .frame(maxWidth: .infinity, maxHeight: 250)
            
            // Leyenda personalizada (las 3 primeras)
            HStack {
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
                
            }
            //... Atributos del HStack dque engloba toda la leyenda
            .frame(maxWidth: 380)
            
            // Leyenda personalizada (las 2 siguientes, que no caben en el largo de la pantalla)
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

#Preview {
    SuperHeroDetails(id:"641")
}
