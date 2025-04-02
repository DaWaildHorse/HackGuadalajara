//
//  PageView.swift
//  SlidingIntro
//
//  Created by Rod Espiritu Berra on 05/03/24.
//

import SwiftUI

struct PageView: View {
    var page: Page
    @State private var isPresented = false

    func getBackgroundImage(for tag: Int) -> String {
        switch tag {
        case 1:
            return "Leafs"
            //leafs_2 no funciona
        case 2:
            return "Leafs"
        default:
            return "Pine"
        }
    }

    var body: some View {
        ZStack {
            if page.tag == 0 {
                Image("Pine")
                    .resizable()
                    .frame(width: 700, height: 700)
                    .offset(x: 100, y: isPresented ? 280 : 700)
                    .opacity(isPresented ? 1 : 0)
                    .animation(.easeInOut(duration: 1), value: isPresented)

                Image("Pine")
                    .resizable()
                    .scaledToFit()
                    .offset(x: -100, y: isPresented ? 350 : 700)
                    .opacity(isPresented ? 1 : 0)
                    .animation(.easeInOut(duration: 1), value: isPresented)
            } else {
                Image(getBackgroundImage(for: page.tag))
                    .resizable()
                    .scaledToFill()
                    .offset(x: 100, y: isPresented ? 280 : 400)
                    .opacity(isPresented ? 1 : 0)
                    .animation(.easeInOut(duration: 1), value: isPresented)
            }

            VStack(spacing: 20) {
                Text(page.name)
                    .font(.system(size: 35, weight: .bold))
                    .foregroundColor(.second)
                    .multilineTextAlignment(.center)
                    .padding(.top, 50)

                Image(page.imageUrl)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .cornerRadius(10)

                Text(page.description)
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.second)
                    .shadow(color: .mainBackground.opacity(1), radius: 4, x: 0, y: 0)
                    .multilineTextAlignment(.center)
                    .frame(width: 300)
                    
            }
            .opacity(isPresented ? 1 : 0)
            .animation(.easeInOut(duration: 1), value: isPresented)
            .frame(maxHeight: .infinity, alignment: .top)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isPresented = true
            }
        }
    }
}



struct PageView_Previews: PreviewProvider {
    static var previews: some View {
        PageView(page: Page.samplePage)
    }
}
