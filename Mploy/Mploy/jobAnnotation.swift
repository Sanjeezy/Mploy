//
//  jobAnnotation.swift
//  Mploy
//
//  Created by Sanjay Tamizharasu on 4/15/17.
//  Copyright © 2017 SanjayTamizharasu. All rights reserved.
//

import Foundation
import MapKit

class jobAnnotation: NSObject, MKAnnotation {
    let title: String?
    let location: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, location: String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.location = location
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return location
    }

}
