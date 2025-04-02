//
//  PageModel.swift
//  SlidingIntro
//
//  Created by Rod Espiritu Berra on 05/03/24.
//

import Foundation

struct Page : Identifiable, Equatable {
    let id = UUID()
    var name: String
    var description: String
    var imageUrl: String
    var tag: Int //Ubicación de la página creada
    
    
    static var samplePage = Page(name: "Activa el cambio", description: "Test", imageUrl: "reciclar", tag: 0)
    
    static var samplePages : [Page] = [
        Page(name: "Activa el cambio", description: "Empieza tu viaje hacia un mundo más sostenible.", imageUrl: "reciclar", tag: 0),
        Page(name: "Escanea tus compras", description: "Explora la tecnología de clasificación que te ayuda a identificar el tipo de basura que estás reciclando.", imageUrl: "pendiente", tag: 1),
        Page(name: "Descubre y clasifica", description: "Obten información valiosa sobre los lugares donde puedes reciclar y contribuir al bienestar del medio ambiente y tu comunidad.", imageUrl: "pendiente", tag: 2),
        Page(name: "Conéctate con\n el planeta", description: "Aprende a través de artículos y noticias sobre la preservación del planeta y el medio ambiente.", imageUrl: "pendiente", tag: 3)
    ]
}
