//
//  NavigationBar.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI

struct NavigationBarView: View {
    // MARK: - ATTRIBUTES
    @State var currentTab: Tab = .Profile
    
    // Hide native bar
    init () {
        UITabBar.appearance().isHidden = true
    }
        
    var body: some View {
        NavigationStack {
            TabView(selection: $currentTab) {
                CameraView()
                    .tag(Tab.Camera)
                    
                ProfileView()
                    .tag(Tab.Profile)
                
                MapView()
                    .tag(Tab.Maps)
                    
            }
            .overlay(alignment: .bottom) {
                NavTabBar(selected: $currentTab)
            }
            .ignoresSafeArea()
        }//: NAV STACK
    }
}

// MARK: - TABS
enum Tab: Int, CaseIterable, Identifiable {
    static func < (lhs: Tab, rhs: Tab) -> Bool {
        lhs.rawValue < rhs.rawValue
    }
    
    internal var id: Int { rawValue }
    
    case Profile
    case Camera
    case Maps
        
    var tabName: String {
        switch self {
        case .Profile:
            return "Mi viejo"
        case .Camera:
            return "Camaron"
        case .Maps:
            return "Mapaches"
        }
    }
    
    var image: String {
        switch self {
        case .Maps:
            return "map.fill"
        case .Camera:
            return "camera.fill"
        case .Profile:
            return "person.fill"
        }
    }
}

#Preview {
    NavigationBarView()
}
