//
//  Mapa.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 02/03/24.
//

import Foundation
import MapKit
import SwiftUI

struct Mapa: Hashable, Identifiable {
    var id = UUID()
    let category: String
    let icon: String
    let color: Color
    let map: MKMapItem
    
    init(map: MKMapItem) {
        let categories = ["Recycle", "Organic", "Electronic", "Glass"]
        let icons = ["waterbottle", "carrot", "macbook.and.iphone", "wineglass"]
        let colors = [Color.green, Color.yellow, Color.orange, Color.blue]
        let rand = Int.random(in: 0...3)
        self.category = categories[rand]
        self.icon = icons[rand]
        self.color = colors[rand]
        self.map = map
    }
}
