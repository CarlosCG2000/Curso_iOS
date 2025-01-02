//
//  SuperHeroBuscador.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 1/1/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct SuperHeroBuscador: View {
    
    @State var superheroName: String = ""
    @State var wrapper:ApiNetwork.Wrapper? = nil
    @State var loading = false
    
    var body: some View {
        
        VStack{
            TextField("",   text: $superheroName,
                      prompt: Text("Superman, Harry Potter...")
                .font(.title2)
                .bold()
                .foregroundStyle(Color.gray))
            .font(.title2)
            .bold()
            .foregroundStyle(Color.white)
            .padding(16)
            .border(.purple, width: 2)
            .cornerRadius(5)
            .padding(10)
            .autocorrectionDisabled() // de apple que hace el autocompletado deshabilitarlo
            .onSubmit {
                loading = true
                
                Task{
                    do{
                        wrapper = try await ApiNetwork().getHeroesByQuery(query: superheroName)
                    }catch{
                        print("Error: \(error)")
                    }
                    
                    loading = false
                }
            }
            
            if loading{
                ProgressView().tint(Color.white)
            }
            
            NavigationStack{
                List (wrapper?.results ?? []){ superhero in
                    // Text(superhero.name)
                    ZStack{
                        SuperHeroItem(superhero: superhero)
                        
                        NavigationLink(destination: {}){ // ¿porque no meto dentro el  'SuperHeroItem(superhero: superhero)'? Debido a que sino me salidra la flecha de navegación y no quiero que salga
                            EmptyView()
                        }.opacity(0) //lo hace completamente transparete para que no se veala flecha, pero aun asi es clickable
                        
                    }.listRowBackground(Color.componentBackground)
                    
                }.listStyle(.plain)
                //.background(Color.componentBackground)
            }
            
            Spacer()
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.appBackground)
    }
}

struct SuperHeroItem:View {
    
    let superhero: ApiNetwork.SuperHero
    
    var body: some View {
        ZStack{
            // Rectangle()
            WebImage(url: URL(string: superhero.image.url))
                .resizable()
                .indicator(.activity) // un icono para que se vea que se esta cargando las imagenes
                .scaledToFill()
                .frame(height:200)
            
            VStack{
                Spacer()
                Text(superhero.name).foregroundStyle(Color.black)
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.5))
            }
        }.frame(height:200)
            .cornerRadius(25)
        //.listRowBackground(Color.componentBackground)
    }
}

#Preview {
    SuperHeroBuscador()
}
