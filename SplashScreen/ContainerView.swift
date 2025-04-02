//
//  ContainerView.swift
//  SlidingIntro
//
//  Created by Rod Espiritu Berra on 07/03/24.
//

import SwiftUI

struct ContainerView: View {
    @State private var isSplashScreenViewPresented = true
    @State var gotoApp = false
    var body: some View {
        if gotoApp {
            NavigationBarView()
                .ignoresSafeArea()
        } else {
            if !isSplashScreenViewPresented {
                CView(gotoApp: $gotoApp)
                .ignoresSafeArea()
            } else {
                SplashScreenView(isPresented: $isSplashScreenViewPresented)
                .ignoresSafeArea()
            }
        }
    }
}

#Preview {
    ContainerView()
}
