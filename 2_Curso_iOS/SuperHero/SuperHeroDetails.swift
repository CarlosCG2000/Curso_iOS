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
                            Text(alias).foregroundStyle(Color.white).italic().font(.title3)
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
        VStack {
            Text("Estadísticas")
                .font(.title2)
                .bold()
                .foregroundStyle(Color.white)
            
            Chart{
                SectorMark(angle: .value("Counter", Int(stats.combat) ?? 0), // el angulo va a ser un valor llamado 'Count' con 'stats.combat' como valor, luego el radio y el angulo serán personalizaciones
                           innerRadius: .ratio(0.5), // el grosor del donutn
                           angularInset: 2 // separacion entre los huecos
                ).cornerRadius(8) // los bordes personalizados
                    // .foregroundStyle(by: .value("Category", "Combate")) // permite meter una referencia de que es cada cosa
                    .foregroundStyle(Color.green)

                SectorMark(angle: .value("Counter", Int(stats.durability) ?? 0), // el angulo va a ser un valor llamado 'Count' con 'stats.combat' como valor, luego el radio y el angulo serán personalizaciones
                           innerRadius: .ratio(0.5), // el grosor del donutn
                           angularInset: 2 // separacion entre los huecos
                ).cornerRadius(8) // los bordes personalizados
               // .foregroundStyle(by: .value("Category", "Durabilidad")) // permite meter una referencia de que es cada cosa
                    .foregroundStyle(Color.blue)
                
                SectorMark(angle: .value("Counter", Int(stats.intelligence) ?? 0), // el angulo va a ser un valor llamado 'Count' con 'stats.combat' como valor, luego el radio y el angulo serán personalizaciones
                           innerRadius: .ratio(0.5), // el grosor del donutn
                           angularInset: 2 // separacion entre los huecos
                ).cornerRadius(8) // los bordes personalizados
            // .foregroundStyle(by: .value("Category", "Inteligencia")) // permite meter una referencia de que es cada cosa
                    .foregroundStyle(Color.orange)
                
                SectorMark(angle: .value("Counter", Int(stats.speed) ?? 0), // el angulo va a ser un valor llamado 'Count' con 'stats.combat' como valor, luego el radio y el angulo serán personalizaciones
                           innerRadius: .ratio(0.5), // el grosor del donutn
                           angularInset: 2 // separacion entre los huecos
                ).cornerRadius(8) // los bordes personalizados
                    //.foregroundStyle(by: .value("Category", "Velocidad")) // permite meter una referencia de que es cada cosa
                    .foregroundStyle(Color.brown)
                
                SectorMark(angle: .value("Counter", Int(stats.strength) ?? 0), // el angulo va a ser un valor llamado 'Count' con 'stats.combat' como valor, luego el radio y el angulo serán personalizaciones
                           innerRadius: .ratio(0.5), // el grosor del donutn
                           angularInset: 2 // separacion entre los huecos
                ).cornerRadius(8) // los bordes personalizados
                   // .foregroundStyle(by: .value("Category", "Fuerza")) // permite meter una referencia de que es cada cosa
                    .foregroundStyle(Color.red)
                
            }
            
        }
        .padding(16)
        .frame(maxWidth: .infinity, maxHeight: 250)
        .padding(32)
        
        // Leyenda personalizada
           HStack {
               Circle()
                   .fill(Color.green) // Color para el combate
                   .frame(width: 10, height: 10)
               Text("Combate")
                   .foregroundColor(.white) // Texto blanco para la leyenda
                   .font(.footnote)
               
               Circle()
                   .fill(Color.blue) // Color para el combate
                   .frame(width: 10, height: 10)
               Text("Durabilidad")
                   .foregroundColor(.white) // Texto blanco para la leyenda
                   .font(.footnote)
               
               Circle()
                   .fill(Color.orange) // Color para el combate
                   .frame(width: 10, height: 10)
               Text("Inteligencia")
                   .foregroundColor(.white) // Texto blanco para la leyenda
                   .font(.footnote)
               
               Circle()
                   .fill(Color.brown) // Color para el combate
                   .frame(width: 10, height: 10)
               Text("Velocidad")
                   .foregroundColor(.white) // Texto blanco para la leyenda
                   .font(.footnote)
           }
        
        HStack {
            Circle()
                .fill(Color.red) // Color para el combate
                .frame(width: 10, height: 10)
            Text("Fuerza")
                .foregroundColor(.white) // Texto blanco para la leyenda
                .font(.footnote)
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
    SuperHeroDetails(id:"44")
}
