//
//  ModelData.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI
import RealityKit
import CoreML
import Vision
import SceneKit
import ARKit
import Observation

// create and observable object that structs can access
@Observable class ModelData {
    private init() { }
    var recognizedText: String? = nil
    var ocr = OCR()
    static let shared = ModelData()
    
    var ARview = ARView()
    // Creates a default profile
    var profile = Profile.default
    var IdentfiedWaste = "Not found"
    var showTutorial = true
    
    // instantiate the core ML model
    var model  = try! VNCoreMLModel(for: WasteClassification_v3(configuration: .init()).model)
    
    // call the continuouslyUpdate function every half second
    var timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
        continuouslyUpdate()
    })
}

struct ColorPalette {
    let c1 = Color.init(red: 251/255, green: 251/255, blue: 251/255)
    let c2 = Color.init(red: 162/255, green: 229/255, blue: 164/255)
    let c3 = Color.init(red: 95/255, green: 223/255, blue: 119/255)
    let c4 = Color.init(red: 221/255, green: 246/255, blue: 226/255)
    let c5 = Color.init(red: 119/255, green: 220/255, blue: 137/255)
    let c6 = Color.init(red: 3/255, green: 54/255, blue: 49/255)
    let c7 = Color.init(red: 226/255, green: 245/255, blue: 226/255)
}

// MARK: - GRAB FRAMES
func continuouslyUpdate() {
    let modelData: ModelData = .shared
    
    // access what we need from the observed object
    let v = modelData.ARview
    let sess = v.session
    let mod = modelData.model
    
    // access the current frame as an image
    let tempImage: CVPixelBuffer? = sess.currentFrame?.capturedImage
    
    //get the current camera frame from the live AR session
    if tempImage == nil {
        return
    }
    
    let tempciImage = CIImage(cvPixelBuffer: tempImage!)
    
    // create a reqeust to the Vision Core ML Model
    let request = VNCoreMLRequest(model: mod) { (request, error) in }
    
    //crop just the center of the captured camera frame to send to the ML model
    request.imageCropAndScaleOption = .centerCrop
    
    // perform the request
    let handler = VNImageRequestHandler(ciImage: tempciImage, orientation: .right)
    
    do {
        //send the request to the model
        try handler.perform([request])
    } catch {
        print(error)
    }
    
    guard let observations = request.results as? [VNClassificationObservation] else { return}
    
    // only proceed if the model prediction's confidence in the first result is greater than 90%
    modelData.IdentfiedWaste = "Not found"
    if observations[0].confidence < 0.7  { return }
    
    // the model returns predictions in descending order of confidence
    // we want to select the first prediction, which has the higest confidence
    let topLabelObservation = observations[0].identifier
    
    let firstWord = topLabelObservation.components(separatedBy: [","])[0]
        
    if modelData.IdentfiedWaste != firstWord {
        DispatchQueue.main.async {
            modelData.IdentfiedWaste = firstWord
        }
    }
}
