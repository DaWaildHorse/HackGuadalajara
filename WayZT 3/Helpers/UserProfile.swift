import SwiftUI
import _PhotosUI_SwiftUI

struct UserProfile: View {
    // MARK: - ATTRIBUTES
    var modelData: ModelData = .shared
    @Binding var changePic: Bool
    @State private var avatarItem: PhotosPickerItem?

    // MARK: - BODY
    var body: some View {
        VStack(spacing: 20) {
            // MARK: - PROFILE
            HStack(spacing: 16) {
                profilePic()
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(modelData.profile.username)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.second)

                    HStack(spacing: 20) {
                        HStack(spacing: 5) {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.orange)
                            Text("15")
                                .foregroundColor(.second)
                                .fontWeight(.bold)
                        }

                        HStack(spacing: 5) {
                            Image(systemName: "person.fill")
                                .foregroundColor(.accent)
                            Text("4")
                                .foregroundColor(.second)
                                .fontWeight(.bold)
                        }
                    }
                }
                .blur(radius: changePic ? 2 : 0)


                Spacer(minLength: 10)

                ZStack {
                    Circle()
                        .trim(from: 0, to: 1)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 10)

                    Circle()
                        .trim(from: 0, to: 67.0 / 170.0)
                        .stroke(.accent, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .rotationEffect(.degrees(-90))

                    VStack {
                        Text("67")
                            .font(.title2)
                            .bold()
                            .foregroundStyle(.second)
                        Text("kg / Co2")
                            .font(.caption2)
                            .foregroundStyle(.gray)
                    }
                }
                .frame(width: 75, height: 75)
                .blur(radius: changePic ? 2 : 0)

            }

            // MARK: - ADD FRIENDS
            HStack {
                Spacer()
                Button(action: {}) {
                    HStack {
                        Text("Agregar amigos")
                            .fontWeight(.bold)
                            .foregroundStyle(.second)
                        Image(systemName: "person.badge.plus")
                            .bold()
                            .font(.title3)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.accent, lineWidth: 2)
                    )
                }
                .foregroundStyle(.second)
                .padding(.horizontal)

                // Botón de compartir
                Button(action: {}) {
                    RoundedRectangle(cornerRadius: 15)
                        .frame(width: 45, height: 45)
                        .foregroundColor(.accent)
                        .overlay(
                            Image(systemName: "square.and.arrow.up")
                                .foregroundColor(.white)
                                .font(.title2)
                                .bold()
                                .offset(y: -2)
                        )
                }
                .padding(.trailing)
            }
            .blur(radius: changePic ? 2 : 0)

        }//: VSTACK
        .padding(.horizontal, 10)
        .padding(.top, changePic ? 10 : 0)
    }
    
    // MARK: - PIC
    func profilePic() -> some View {
        Image(uiImage: modelData.profile.profilePic)
            .resizable()
            .scaledToFill()
            .frame(width: 100, height: 100)
            .clipShape(Circle())
            .overlay(Circle().stroke(.accent, lineWidth: 2))
            .scaleEffect(x: changePic ? 1.1 : 1, y: changePic ? 1.1 : 1)
            .onLongPressGesture(minimumDuration: 0.5) {
                withAnimation() {
                    changePic = true
                }
            }
        // MARK: - CHANEG PHOTO
            .popover(isPresented: $changePic) {
                HStack {
                    Spacer()
                    PhotosPicker("Cambiar foto de perfil", selection: $avatarItem, matching: .images)
                        .presentationCompactAdaptation(.popover)
                    Spacer()
                }
                .presentationCompactAdaptation(.popover)
                .onChange(of: avatarItem) {
                    Task {
                        if let loaded = try? await avatarItem?.loadTransferable(type: Data.self) {
                            modelData.profile.profilePic = UIImage(data: loaded) ?? modelData.profile.profilePic
                        } else {
                            print("Failed")
                        }
                    }
                }
            }
        
    }
}


#Preview {
    UserProfile(changePic: .constant(true))
}
