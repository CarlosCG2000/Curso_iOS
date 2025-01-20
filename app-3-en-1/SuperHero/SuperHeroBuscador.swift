//
//  SuperHeroBuscador.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 1/1/25.
//

import SwiftUI
import SDWebImageSwiftUI

// VISTA PRINCIPAL: SuperHeroBuscador
struct SuperHeroBuscador: View {
    
    // VARIABLES
    @State var superheroName: String = "" // string del texto que se pone en el 'Textfield'
    @State var wrapper:ApiNetwork.Wrapper? = nil // clase personalizada, al obtener el json de la apli de superheroes
    @State var loading = false // para cargar la vista mientras filtra la búsqueda de superheroes en el 'Textfield'
    
    var body: some View {
        
        VStack{ // VStack principal
            // __________ Input de búsqueda para filtrar del listado de superheroes (API) __________
            TextField("", text: $superheroName, prompt: Text("Superman, Harry Potter...")
                                                        .font(.title2)
                                                        .bold()
                                                        .foregroundStyle(Color.gray))
            //... Atributos de la TextField
            .font(.title2)
            .bold()
            .foregroundStyle(Color.white)
            .padding(16)
            .border(.purple, width: 2)
            .cornerRadius(5)
            .padding(10)
            .autocorrectionDisabled() // de apple que hace el autocompletado se deshabilitarlo
            .onSubmit { // cuando pulses el enter
                
                loading = true // se carga la pantalla al principio
                
                Task{ // La tarea permite ejecutar código de forma asincrónica (en segundo plano) sin bloquear el hilo principal, parando solo con el uso de await. Forma parte del modelo de `concurrencia` introducido en `Swift 5.5` y que se usa para ejecutar código de forma `asincrónica` y `concurrente`.
                    do{
                        // Realiza una llamada asincrónica a la API: https://superheroapi.com/
                        // El uso de 'await' pausa la ejecución dentro de esta tarea hasta que la llamada se complete.
                        wrapper = try await ApiNetwork().getHeroesByQuery(query: superheroName) // llamada al fichero ApiNetwork
                        
                    } catch { // Captura y maneja cualquier error que pueda ocurrir durante la llamada asincrónica.
                        print("Error: \(error)")
                    }
                    
                    loading = false // se quita la carga cuando ya estan obtenido el json
                }
            }
            // ___________________________________________________
            
            // _____ Cargar la pantalla _____
            if loading { // mientras sea true
                ProgressView().tint(Color.white)
            }
    
            // _______________ Contenedor con el listado de superheroes  _______________
            // Se denomina desempaquetado opcional (optional unwrapping), y es necesario cuando se trabaja con valores opcionales
            if let results = wrapper?.results { // desempaquetado opcional
                
                if results.isEmpty { // si results = [] (porque ha dado error, declarado ApiNetwork)
                    Spacer()
                    Spacer()
                    Text("No existen superhéroes con ese nombre")
                        .foregroundColor(.red)
                        .font(.headline)
                    Spacer()
                } else {
                    NavigationStack {
                        // results, son los superheroes mostrados [SuperHero]
                        List (results){ superhero in
                            
                            // Para que me salga solo item del superheroe con la navegacion (pero sin aspecto solo con la funcionalidad de navegar)
                            ZStack {
                                
                                // Sección con la información de un Superheroe
                                SuperHeroItem(superhero: superhero)
                                
                                // ¿Porque meto vacio (EmptyView) y transparente (opacity(0)) en la navegación?
                                // Debido a que sino me saldria la flecha de navegación y no quiero que salga
                                NavigationLink(destination: SuperHeroDetails(id: superhero.id)){
                                    EmptyView()
                                }
                                //... Atributos de la NavigationLink
                                .opacity(0) // lo hace completamente transparete para que no se vea la flecha, pero aun asi es clickable
                                
                            }
                            //... Atributos de la ZStack
                            .listRowBackground(Color.componentBackground)
                            
                        }
                        //... Atributos de la lista (list)
                        .listStyle(.plain)
                        //.background(Color.componentBackground)
                    }
                }
            }
            // __________________________________________________________________________
            
            Spacer()
        }
        //... Atributos de la VStack principal
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.appBackGround)
        .navigationTitle("Listado de Superheroes")
        .foregroundStyle(Color.white)
    }
}

// 1_Sección con la información de un Superheroe (vista secundaria)
struct SuperHeroItem:View {
    
    let superhero: ApiNetwork.SuperHero // el superheroe
    
    var body: some View {
        ZStack{
            // Rectangle()
            WebImage(url: URL(string: superhero.image.url)) //imagen
                .resizable()
                .indicator(.activity) // un icono para que se vea que se esta cargando las imagenes
                .scaledToFill()
                .frame(height:200)
            
            VStack{
                Spacer()
                Text(superhero.name) // imagen
                    .foregroundStyle(Color.black)
                    .font(.title)
                    .bold()
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.white.opacity(0.5))
            }
        }
        //... Atributos de la ZStack
        .frame(height:200)
        .cornerRadius(25)
        //.listRowBackground(Color.componentBackground)
    }
}

#Preview {
    SuperHeroBuscador()
}
