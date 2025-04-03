//
//  MapProgress.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 01/03/24.
//

import SwiftUI

struct MapProgress: View {
    // MARK: - ATTRIBUTE
    var modelData: ModelData = .shared
    
    // MARK: - BODY
    var body: some View {
        HStack {
            WasteProgressBar()
            
            VStack {
                ForEach(modelData.categories, id:\.self.id) { category in
                    HStack {
                        Text(category.name)
                            .font(.title3)
                            .bold()
                            .foregroundStyle(.second)
                        Image(systemName: category.systemImage)
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.accent)
                            .fontWeight(.semibold)
                    }
                    
                    // MARK: - PROGRESS BAR
                    HStack {
                        Text(String(category.waste))
                            .font(.footnote)
                            .foregroundStyle(.second)
                            .bold()
                        ProgressView(value: Float(category.waste), total: Float(category.goal))
                            .tint(Color.green)
                        Text(String(category.goal))
                            .font(.footnote)
                            .foregroundStyle(.second)
                            .bold()
                    }
                }
            }
            .padding(.vertical, 10)
            .padding(.trailing, 10)
        }//: HSTACK
        .frame(height: 250)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.mainBackground)
        )
    }
}

// MARK: - WASTE CATEGORY
struct WasteCategory: Identifiable {
    let id = UUID()
    let name: String
    let systemImage: String
    let waste: Int
    let goal: Int
    var size: CGFloat = 0
}

// MARK: - PROGRESS BAR
struct WasteProgressBar: View {
    // MARK: - ATTRIBUTE
    var modelData: ModelData = .shared
    @State private var anim = false
    
    // MARK: - BODY
    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                Rectangle()
                    .fill(
                        LinearGradient(colors: [.accent.opacity(0.3), .accent],
                                       startPoint: .top, endPoint: .init(x: 0.5, y: 0.8))
                    )
                    .frame(height: 200 * Double(modelData.profile.currentWaste) / Double(modelData.profile.wasteGoal))
                    .background(.white)
            }
        }
        .frame(height: 230)
        .frame(maxWidth: 140)
        .overlay {
            Image("planet")
                .resizable()
                .scaledToFit()
                .frame(width: 90)
                .scaleEffect(anim ? 1.1 : 1)
                .onAppear {
                    withAnimation(.easeInOut(duration: 1).repeatForever(autoreverses: true)) {
                        anim.toggle()
                    }
                }
        }
        .clipShape(RoundedRectangle(cornerRadius: 15))
        .padding(.all, 5)
        .padding(.leading, 5)
    }
}

#Preview {
    MapProgress()
}
