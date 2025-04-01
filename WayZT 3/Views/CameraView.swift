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
    @State var isTicket = false
    
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            ARViewContainer(enableAR: $viewAR, t: $isTicket)
                .ignoresSafeArea()
            
            if isTicket {
                TicketView()
            }else {changeView()}
            
            VStack {
                changeTicket()
                
                // Only shows information if something is recognized
                if isTicket {
                } else {
                    if viewAR {
                        WasteIdentDisplay()
                    } else {
                        WasteIdentDisplay2()
                    }
                }


            }
            
        }//: ZSTACK
    }
    
    // MARK: - CHANGE VIEW
    func changeView() -> some View {
        HStack {
            Button {
                viewAR.toggle()
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
                isTicket.toggle()
            } label: {
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
                    .scaledToFit()
                    .frame(width: 50)
                    .overlay {
                        Image(systemName: isTicket ? "ticket.fill" : "ticket")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 35)
                            .foregroundStyle(isTicket ? .accent : .gray)
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
