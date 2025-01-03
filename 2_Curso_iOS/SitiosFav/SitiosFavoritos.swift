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

    var body: some View {
        
        ZStack{
            
            MapReader{ proxy in
                Map(position: $position).onTapGesture {
                    
                    
                }
                
                
            }
            
        }.background(.appBackground)
    }
}

#Preview {
    SitiosFavoritos()
}
