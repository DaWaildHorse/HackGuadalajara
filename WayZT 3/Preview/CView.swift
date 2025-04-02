//
//  ContentView.swift
//  SlidingIntro
//
//  Created by Rod Espiritu Berra on 05/03/24.
//

import SwiftUI

struct CView: View {
    @State private var pageIndex = 0 // Creación de la variable para el índice de las páginas
    //View general para el Sliding Intro
    @Binding var gotoApp: Bool
    
    private let pages: [Page] = Page.samplePages //Creación de la variable y llamado de la anterior (PageView)
    private let dotAppearance = UIPageControl.appearance() //Creación del dot debajo para aparecer
    
    var body: some View {
        ZStack {
            Color.second.ignoresSafeArea().opacity(0.1)
            
            VStack {
                TabView(selection: $pageIndex) {
                    ForEach(pages) { page in
                        VStack {
                            Spacer()
                            PageView(page: page)
                            Spacer()
                            
                            if page == pages.last {
                                Button(action: goToHome) {
                                    Image(systemName: "play.circle.fill")
                                        .resizable()
                                        .frame(width: 64, height: 64)
                                        .foregroundStyle(.mainBackground)
                                }
                                .padding(.bottom, 40)
                                
                            } else {
                                Rectangle()
                                    .fill(.mainBackground)
                                    .frame(width: 200, height: 60)
                                    .cornerRadius(30)
                                    .overlay(
                                        Text("Continuar")
                                            .font(.system(size: 20, weight: .bold))
                                            .foregroundStyle(.second)
                                    )
                                    .onTapGesture {
                                        incrementPage() 
                                    }
                                    .padding(.bottom, 20)
                                
                                Spacer()
                            }
                        }
                        .tag(page.tag)
                    }
                }
                .animation(.easeInOut, value: pageIndex)
                .tabViewStyle(.page)
                .indexViewStyle(.page(backgroundDisplayMode: .interactive))
            }
        }
        .onAppear {
            dotAppearance.currentPageIndicatorTintColor = .green
            dotAppearance.pageIndicatorTintColor = .gray
        }
    }
    
    func incrementPage() { // Realiza el incremento para pasar a la siguiente página
        pageIndex += 1
    }
    
    func goToHome() { // Empieza desde 0 debe cambiar a direccionar al home de la App
        gotoApp = true
    }
}
