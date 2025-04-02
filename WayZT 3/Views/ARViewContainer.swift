//
//  ARContainer.swift
//  WayZT 3
//
//  Created by Ultiimate Dog on 01/04/25.
//

import SwiftUI
import ARKit
import SceneKit
import RealityKit

struct ARViewContainer: UIViewRepresentable {
    // MARK: - ATTRIBUTES
    var recogd: ModelData = .shared
    @Binding var enableAR: Bool
    
    // MARK: - UIVIEW
    func makeUIView(context: Context) -> ARView {
        let v = recogd.ARview
        return v
    }
    
    // MARK: - UPDATE
    func updateUIView(_ uiView: ARView, context: Context) {        
        var txt = SCNText()
        
        // let's keep the number of anchors to no more than 1 for this demo
        if recogd.ARview.scene.anchors.count > 0 {
            recogd.ARview.scene.anchors.removeAll()
        }
        
        // create the AR Text to place on the screen
        txt = SCNText(string: recogd.IdentfiedWaste, extrusionDepth: 1)
        let material = SCNMaterial()
        material.diffuse.contents = UIColor.magenta
        txt.materials = [material]
        
        let shader = SimpleMaterial(color: UIColor(red: 0, green: 1, blue: 0, alpha: 1.0), roughness: 1, isMetallic: true)
        let text = MeshResource.generateText(
            enableAR && !recogd.analyzeText ? "\(recogd.IdentfiedWaste)" : "",
            extrusionDepth: 0.05,
            font: .init(name: "Helvetica", size: 0.05)!,
            alignment: .center
        )
        
        let textEntity = ModelEntity(mesh: text, materials: [shader])
        
        let transform = recogd.ARview.cameraTransform
        
        // set the transform (the 3d location) of the text to be near the center of the camera, and 1/2 meter away
        let trans = transform.matrix
        let anchEntity = AnchorEntity(world: trans)
        textEntity.position.z -= 0.5 // place the text 1/2 meter away from the camera along the Z axis
        
        // find the width of the entity in order to have the text appear in the center
        let minX = text.bounds.min.x
        let maxX = text.bounds.max.x
        let width = maxX - minX
        let xPos = width / 2
        
        textEntity.position.x = transform.translation.x - xPos
        
        anchEntity.addChild(textEntity)
        
        // add this anchor entity to the scene
        recogd.ARview.scene.addAnchor(anchEntity)
    }
        
}


