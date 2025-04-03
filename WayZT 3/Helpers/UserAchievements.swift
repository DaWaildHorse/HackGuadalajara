//
//  UserAchievements.swift
//  WayZT 3
//
//  Created by Rod Espiritu Berra on 02/04/25.
//
import SwiftUI

struct UserAchievements: View {
    // MARK: - ATTRIBUTES
    @State private var rotationAngles: [Int: Double] = [1: 0, 2: 0, 3: 0, 4: 0]
    @State private var shineOffsets: [Int: CGFloat] = [1: 80, 2: 80, 3: 80, 4: 80] // Initial position (below badge)

    
    // MARK: - BODY
    var body: some View {
        VStack {
            Text("\t"+"Logros")
                .font(.title2)
                .foregroundColor(Color(.label))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)

            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.mainBackground)
                    .frame(width: 300, height: 100)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.accent, lineWidth: 2)
                    )

                HStack(alignment: .center, spacing: 5) {
                    ForEach(1...4, id: \.self) { index in
                        Image("Badge\(index)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .rotation3DEffect(.degrees(rotationAngles[index] ?? 0), axis: (x: 0, y: 1, z: 0))
                            .scaleEffect(rotationAngles[index] != 0 ? 1.5 : 1)
                            .overlay{
                                // Shining effect
                                Rectangle()
                                    .fill(LinearGradient(
                                        gradient: Gradient(colors: [Color.clear,
                                                                    Color.white.opacity(0.8),
                                                                    Color.clear]),
                                        startPoint: .top,
                                        endPoint: .bottom
                                    ))
                                    .rotationEffect(.degrees(45))
                                    .blur(radius: 5)
                                    .frame(width: 20, height: 120) // Thin shine
                                    .offset(x: shineOffsets[index] ?? 100)
                                    .mask{
                                        Image("Badge\(index)")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 90, height: 90)
                                    }
                            }
                            .onTapGesture {
                                withAnimation(.easeInOut(duration: 0.8)) {
                                    rotationAngles[index] = (rotationAngles[index] ?? 0) + 360

                                }
                                // Shine animation happens **between** spin and reset
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                    withAnimation(.spring(duration: 1)) {
                                        shineOffsets[index] = -40 // Shine moves through
                                    }
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                    withAnimation(.spring(duration: 1)) {
                                        shineOffsets[index] = 80 // Shine moves through
                                    }
                                }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                                    withAnimation(.easeInOut(duration: 0.8)) {
                                        rotationAngles[index] = 0
                                    }
                                }
                            }
                    }
                }
                .offset(y: 0) 
            }
        }
        .padding()
        .background(
            .thinMaterial
        )
        .clipShape(RoundedRectangle(cornerRadius: 15)) // Reducir el radio del borde
    }
}


#Preview {
    UserAchievements()
}
