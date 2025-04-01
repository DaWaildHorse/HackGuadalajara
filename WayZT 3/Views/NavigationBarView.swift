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
                    
                FootprintView()
                    .tag(Tab.Footprint)
                
                ArticlesView()
                    .tag(Tab.Articles)
                    
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
enum Tab: String, CaseIterable, Identifiable {
    internal var id: String { rawValue }
    
    case Profile = "person.fill"
    case Footprint = "shoeprints.fill"
    case Camera = "camera.fill"
    case Maps = "map.fill"
    case Articles = "book.pages.fill"
        
    var tabName: String {
        switch self {
        case .Profile:
            return "Profile"
        case .Footprint:
            return "Footprint"
        case .Camera:
            return "Camera"
        case .Maps:
            return "Map"
        case .Articles:
            return "Articles"
        }
    }
}

#Preview {
    NavigationBarView()
}
