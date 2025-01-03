//
//  Place.swift
//  2_Curso_iOS
//
//  Created by Carlos C on 3/1/25.
//

import Foundation
import MapKit

struct Place:Identifiable {
    let id:UUID = UUID()
    var name:String
    var coordinates:CLLocationCoordinate2D
    var fab:Bool
}
