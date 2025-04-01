//
//  TypeWasteButton.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 29/02/24.
//

import SwiftUI

struct TypeWasteButton: View {
    // MARK: - ATTRIBUTE
    var modelData: ModelData = .shared
    
    @State private var continueAnim = [false, false]
    let i: Int
    fileprivate let comps: [Components] = [
        Components(text: "Reciclable", image: "waterbottle", size: 80),
        Components(text: "Organica", image: "carrot", size: 80),
        Components(text: "Vidrio", image: "wineglass", size: 80),
        Components(text: "Electronicos", image: "macbook.and.iphone", size: 70)
    ]
    
    // MARK: - BODY
    var body: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(.mainBackground)
            .overlay {
                VStack {
                    Spacer()
                    anim()
                    Spacer()
                    Text(comps[i].text)
                        .font(.title)
                        .bold()
                        .foregroundStyle(.accent)
                }
                .padding(.vertical, 20)
        }
            .onAppear {
                withAnimation(.easeInOut(duration: 1.8).repeatForever(autoreverses: true)) {
                    continueAnim[0].toggle()
                }
                withAnimation(.easeInOut(duration: 2.5).repeatForever(autoreverses: true)) {
                    continueAnim[1].toggle()
                }
            }
    }
    
    // MARK: - ANIMS
    func anim() -> some View {
        let offX: [CGFloat] = [50, 30, -30, -50]
        let offY: [CGFloat] = [-35, -50, 50, 35]
        
        return Image(systemName: comps[i].image)
            .resizable()
            .scaledToFit()
            .frame(height: comps[i].size)
            .foregroundStyle(.accent)
            .padding(.top, 0)
            .overlay {
                ForEach(0..<4, id:\.self) { j in
                    Image(systemName: "sparkle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: j % 2 == 0 ? 25 : 17)
                        .foregroundStyle(.accent)
                        .scaleEffect(x: continueAnim[j % 2] && modelData.profile.anims[i] ? 1 : 0, y: continueAnim[j % 2] && modelData.profile.anims[i] ? 1 : 0)
                        .offset(x: offX[j], y: offY[j])
                }
            }
    }
    
}

fileprivate struct Components {
    let text: String
    let image: String
    let size: Double
}

#Preview {
    TypeWasteButton(i: 1)
}
