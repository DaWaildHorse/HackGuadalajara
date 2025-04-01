//
//  MapView.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI

struct MapView: View {
    // MARK: - ATTRIBUTES
    let dWidth: Double = 300
    let dHeight: Double = 300
   
    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.second)
                .ignoresSafeArea()
                .opacity(0.3)
            
            VStack(spacing: 10) {
                SearchBar(placeholderText: "Busca un servicio")
                    .padding(.bottom, 5)
                
                MapProgress()
                
                // MARK: - GROUP
                HStack(spacing: 10) {
                    NavigationLink {
                        RecycleMap()
                    } label: {
                        TypeWasteButton(i: 0)
                    }
                    NavigationLink {
                        OrganicMap()
                    } label: {
                        TypeWasteButton(i: 1)
                    }
                }
                HStack(spacing: 10) {
                    NavigationLink {
                        GlassMap()
                    } label: {
                        TypeWasteButton(i: 2)
                    }
                    NavigationLink {
                        ElectronicsMap()
                    } label: {
                        TypeWasteButton(i: 3)
                    }
                }
            }
            .padding(.horizontal, 10)
            .padding(.bottom, dWidth / 5 + 10)
        }
    }
}

#Preview {
    MapView()
}
