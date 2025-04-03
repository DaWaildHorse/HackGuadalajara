import SwiftUI

struct UserProfile: View {
    var modelData: ModelData = .shared

    var body: some View {
        VStack(spacing: 20) {
            // Perfil e info
            HStack(spacing: 16) {
                Image(uiImage: modelData.profile.profilePic)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100, height: 100)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.black, lineWidth: 2))
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(modelData.profile.username)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    HStack(spacing: 20) {
                        HStack(spacing: 5) {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.orange)
                            Text("235")
                                .foregroundColor(.white)
                        }

                        HStack(spacing: 5) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.white)
                            Text("4")
                                .foregroundColor(.white)
                        }
                    }
                }

                Spacer(minLength: 10)

                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 10)

                    Circle()
                        .trim(from: 0, to: 67.0 / 170.0)
                        .stroke(Color.white, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))

                    VStack {
                        Text("67")
                            .font(.title2)
                            .bold()
                            .foregroundColor(.white)
                        Text("kg / Co2")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }
                }
                .frame(width: 75, height: 75)
            }

            HStack {
                Spacer()
                Button(action: {}) {
                    HStack {
                        Text("Agregar amigos")
                            .fontWeight(.bold)
                        Image(systemName: "person.badge.plus")
                            .bold()
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.green, lineWidth: 2)
                    )
                }
                .foregroundColor(.white)
                .padding(.horizontal)

                // Botón de compartir
                Button(action: {}) {
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(Color.green)
                        .overlay(
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                        )
                }
                .padding(.trailing)
            }
        }
        .padding()
    }
}


#Preview {
    UserProfile()
}
