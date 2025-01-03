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
                }.mapStyle(.hybrid(elevation: .realistic, showsTraffic: true)) //Tipos de mapas: standar, hybrid, imagery - showsTraffic: true --> el estado de las carreteras, etc
                .onTapGesture { coord in
                
                    if let coordinates = proxy.convert(coord, from: .local)
                    {
                        showPopUp = coordinates
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
                                
                    if showError {
                        HStack {
                            Text("El nombre no puede estar vacío.")
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
                            showError = true // Muestra el mensaje de error
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
            
        }.background(.appBackground)
    }
    
    // Función guardar (dentro de la estructura porque es para ella)
    func savePlace(name:String, fav: Bool, coordinates: CLLocationCoordinate2D){
        if name == "" {
            return
        }
        
        let place = Place(name: name, coordinates: coordinates,  fav: fav)
        places.append(place)
    }
    
    // Función para limpiar el formulario y cerrar el Pop Up, una vez guardado
    func clearForm() {
        name = ""
        fav = false
        showPopUp = nil
        
    }
}

#Preview {
    SitiosFavoritos()
}
