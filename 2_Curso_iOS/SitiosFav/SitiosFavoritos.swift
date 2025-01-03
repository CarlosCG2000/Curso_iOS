//
//  SitiosFavoritos.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 3/1/25.
//

import SwiftUI
import MapKit

struct SitiosFavoritos: View {
    
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(center: CLLocationCoordinate2D(latitude:40.41 , longitude:-3.70),
                           span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    )
    
    @State var places:[Place] = []
    
    //@State var showPopUp:Bool = false
    @State var showPopUp:CLLocationCoordinate2D? = nil // que el showPopUp contenga las cordenadas (como si fuera true) o sea null (como si fuera false) y asi no utilizo un booleano y obtengo las coordenadas
    // Dentro del pop up
    @State var name:String = ""
    @State var fav:Bool = false
    
    @State private var showError: Bool = false // Nueva variable para mostrar el error
    @State private var errorMessage: String = "" // Nueva variable para mostrar el mensaje de error
    
    @State var showSheet:Bool = false // para mostrar el listado
    let heightPersonalizada = stride(from: 0.3, through: 0.3, by: 0.1) // tamaño fijo del sheet, donde va a empezar el boton sheet cuando salga, cual va a ser la altura maxima, cuanto sube cuando hacemos scroll
        .map{ PresentationDetent.fraction($0)} // para que calcule el tamaño y no se vuelva loco
    
    var body: some View {
        
        ZStack {
            
            MapReader{ proxy in
                Map(position: $position)
                {
                   // Pintar con un marcador cda posición de los lugares favoritos
                    ForEach(places){ place in
                        // Se crea el marcador
                        Annotation(place.name, coordinate: place.coordinates){
                            let color = place.fav ? Color.orange : Color.red // si esta en favoritos o no cambia el color
                            let icono = place.fav ? "star.fill" : "star.slash.fill"
                            
                            Image(systemName: icono)
                                .foregroundStyle(color)
                                .frame(width:80)
                            
                        }
                    }
                }.mapStyle(.standard) //Tipos de mapas: standard, hybrid, imagery - showsTraffic: true --> el estado de las carreteras, etc
                .onTapGesture { coord in
                
                    if let coordinates = proxy.convert(coord, from: .local)
                    {
                        showPopUp = coordinates
                    }
                
                }
                .overlay { // vista por encima
                    VStack {
                        Button("Show list") {
                            showSheet = true
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(Color.cyan.opacity(0.8))
                        .foregroundStyle(.black)
                        .cornerRadius(16)
                        .padding(16)
                        Spacer()
                    }
                }
                
            }
            
            // Cuando muestre el Pop Up llame al CustomDialog
            if showPopUp != nil {
                
                let view = VStack{
                    Spacer()
                    Text("Añadir localización").font(.title2).bold()
                    Spacer()
                    TextField("Nombre", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle()) // Mejora el estilo del campo
                            .overlay(
                                RoundedRectangle(cornerRadius: 5)
                                    .stroke(showError ? Color.red : Color.clear, lineWidth: 2) // Resaltar borde si hay error
                            )
                          
                    // Si hay error en el input (por dejarlo vacio)
                    if showError {
                        HStack {
                            Text(errorMessage)
                                .font(.caption)
                                .foregroundColor(.red)
                            Spacer() // Agrega espacio después para empujar el texto hacia la izquierda
                        }
                    }
                    
                    Toggle("¿Es un lugar favorito?", isOn: $fav)
                    Spacer()
                    Spacer()
                    Button("Guardar"){ // LA ACCIÓN CUANDO SE DA A GUARDAR
                        if name.isEmpty {
                            errorMessage = "El nombre no puede estar vacío."
                            showError = true
                        } else if name.count <= 3 {
                            errorMessage = "El nombre debe tener más de 3 caracteres."
                            showError = true
                        } else {
                            savePlace(name:name, fav: fav, coordinates: showPopUp!)
                            clearForm() // para que limpie el input y toogle del formulario y que me cierre el Pop up
                        }
                    }
                }
                
                withAnimation {
                    CustomDialog(closeDialog: {
                        showPopUp = nil
                    },          onDismissOutside: true /* si quiero que se pueda cerrar desde fuera o no */,
                                content:view)
                }
            }
           
        // PARA MOSTRAR EL LISTADO
        }.sheet(isPresented: $showSheet){  // ZStack:
            ZStack{
                // CREAR LA LISTA HORIZONTAL DE LOS LUGARES FAVORITOS
                ScrollView(.horizontal){ // scrooll horizontal (por defecto es vertical)
                    LazyHStack{
                        ForEach(places){ place in
                            let color = place.fav ? Color.yellow : Color.red
                            
                            VStack {
                                Text(place.name)
                                    .font(.title)
                                    .bold()
                            }.frame(width: 150, height: 100).overlay {
                                RoundedRectangle(cornerRadius: 20).stroke(color, lineWidth: 2)
                            }
                            .shadow(radius: 10)
                            .padding(.horizontal, 8)
                            .onTapGesture { // podemos controlar el click del elemento para que nos lleve a su dirección
                                animateCamera(coord: place.coordinates)
                                showSheet = false
                            }
                        }
                        
                    }
                }
                
            }.presentationDetents(Set(heightPersonalizada))
            
        }.onAppear(){ // cuando aparezca la vista
            cargarPlaces() // se llamara a la extensión 'BD_UserDefaults' que contiene la funcion cargarPlaces(), para cargar los places guardados
        }
    }
    
    // Función guardar (dentro de la estructura porque es para ella)
    func savePlace(name:String, fav: Bool, coordinates: CLLocationCoordinate2D){
        if name == "" {
            return
        }
        
        let place = Place(name: name, coordinates: coordinates,  fav: fav)
        places.append(place)
        guardarPlaces() // reemplaza y guardarllamando a la extensión 'BD_UserDefaults' los places para tenerlo de manera persistente
    }
    
    // Función para limpiar el formulario y cerrar el Pop Up, una vez guardado
    func clearForm() {
        name = ""
        fav = false
        showPopUp = nil
    }
    
    // Función que a través de unas coordenadas te redirige a la posición en el mapa
    func animateCamera(coord:CLLocationCoordinate2D) {
        withAnimation {
            position = MapCameraPosition.region(
                MKCoordinateRegion(center: coord,
                                   span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
            )
        }
    }
}

#Preview {
    SitiosFavoritos()
}
