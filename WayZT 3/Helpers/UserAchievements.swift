//
//  UserAchievements.swift
//  WayZT 3
//
//  Created by Rod Espiritu Berra on 02/04/25.
//
import SwiftUI

struct UserAchievements: View {
    var body: some View {
        VStack {
            Text("\t"+"Logros")
                .font(.title2)
                .foregroundColor(Color(.label))
                .bold()
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.bottom, 10)

            ZStack {
                Rectangle()
                    .fill(Color(.systemBackground))
                    .frame(width: 300, height: 100)
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.accentColor, lineWidth: 2)
                    )

                HStack(alignment: .center, spacing: 5) {
                    ForEach(1...4, id: \.self) { index in
                        Image("Badge\(index)")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 60, height: 60)
                            .aspectRatio(contentMode: .fit)
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
