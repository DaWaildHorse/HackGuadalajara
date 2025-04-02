//
//  CameraView.swift
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

struct CameraView: View {
    // MARK: - ATTRIBUTES
    var modelData: ModelData = .shared
    @State var viewAR = true
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            ARViewContainer(enableAR: $viewAR)
                .ignoresSafeArea()
            if !modelData.analyzeText {
                changeView()
            }
            
            VStack {
                // Only shows information if something is recognized
                if !modelData.analyzeText {
                    if viewAR {
                        WasteIdentDisplay()
                            .transition(.move(edge: .leading))
                    } else {
                        WasteIdentDisplay2()
                            .transition(.move(edge: .trailing))
                    }
                } else {
                    TicketView()
                        .clipShape(RoundedRectangle(cornerRadius: 25))
                        .padding()
                        .padding(.bottom, 50)
                        .transition(.move(edge: .bottom))
                }

            }//: VSTACK
            .padding(.top, 55)
            
            changeTicket()
        }//: ZSTACK
        
    }
    
    // MARK: - CHANGE VIEW
    func changeView() -> some View {
        HStack {
            Button {
                withAnimation() {
                    viewAR.toggle()
                }
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .scaledToFit()
                    .frame(width: 50)
                    .overlay {
                        Image(systemName: viewAR ? "arkit" : "arkit.badge.xmark")
                            .resizable()
                            .scaledToFit()
                            .frame(width: viewAR ? 30 : 38)
                            .padding(.leading, viewAR ? 0 : 6)
                            .foregroundStyle(viewAR ? .accent : .gray)
                            .contentTransition(.symbolEffect(.replace))
                            .symbolRenderingMode(.multicolor)
                    }
            }
            .padding(.horizontal, 25)
            Spacer()
        }//: HSTACK
    }
    
    // MARK: - CHANGE TICKET
    func changeTicket() -> some View {
        HStack {
            Spacer()
            Button {
                withAnimation() {
                    modelData.analyzeText.toggle()
                }
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .scaledToFit()
                    .frame(width: 50)
                    .overlay {
                        Image(systemName: modelData.analyzeText ? "ticket.fill" : "ticket")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35)
                            .foregroundStyle(modelData.analyzeText ? .accent : .gray)
                            .contentTransition(.symbolEffect(.replace))
                    }
            }
            .padding(.horizontal, 25)
        }//: HSTACK
    }
}


#Preview {
    CameraView()
}
