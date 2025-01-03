//
//  MapsEjemplo.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 3/1/25.
//

import SwiftUI
import MapKit

struct MapsEjemplo: View {
    
    @State var position = MapCameraPosition.region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 40.4, longitude: -3.87),
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
        )
    )
    
    var body: some View {
        ZStack {
            MapReader{ proxy in
                
                Map(position: $position) {
                    Marker("Restaurante Mauricio", coordinate: CLLocationCoordinate2D(latitude: 40.051752, longitude:  -5.776943)) // crear punto con localización
                    
                    
                    Annotation("Mi casa", coordinate: CLLocationCoordinate2D(latitude: 39.89, longitude: -5.53)){
                        Circle().frame(width: 15, height: 15).foregroundColor(Color.orange)
                    }  // crear punto con localización personalizado
                    
                    
                } .mapStyle(.hybrid(elevation: .realistic, showsTraffic: true)) //Tipos de mapas: standar, hybrid, imagery - showsTraffic: true --> el estado de las carreteras, etc
                /** .onMapCameraChange{ newPosition in // cada vez que se pare en una posicion en el mapa
                 print("Estamos en \(newPosition.region)")
                 } */
                    .onMapCameraChange (frequency: .continuous){ newPosition in // todo el rato te da las posiciones
                        print("Estamos en \(newPosition.region)")
                    }
                    .onTapGesture{ cord in // cada vez que pulsemos se nos ira a la direccion donde epulsemos
                        if let coordinates = proxy.convert(cord, from: .local)
                        {
                            withAnimation {
                                position = MapCameraPosition.region(
                                    MKCoordinateRegion(
                                        center: CLLocationCoordinate2D(latitude: coordinates.latitude, longitude:  coordinates.longitude),
                                        span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                    )
                                )
                            }
                            
                        }
                    }
            }
            
            VStack{
                Spacer()
                HStack{
                    Button("Ir a casa"){
                        withAnimation {
                            position = MapCameraPosition.region(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude: 39.89, longitude: -5.53),
                                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                )
                            )
                        }
                    }.padding(20).background(Color.white).cornerRadius(10).padding(10)
                    
                    Button("Ir al restaurante"){
                        withAnimation {
                            position = MapCameraPosition.region(
                                MKCoordinateRegion(
                                    center: CLLocationCoordinate2D(latitude: 40.051752, longitude:  -5.776943),
                                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                                )
                            )
                        }
                        
                    }.padding(20).background(Color.white).cornerRadius(10).padding(10)
                    
                }
            }
        }
        
    }
}

#Preview {
    MapsEjemplo()
}
