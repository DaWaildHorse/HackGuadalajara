import SwiftUI
import PhotosUI

struct ProfileView: View {
    // MARK: - ATTRIBUTE
    var modelData: ModelData = .shared

    @State private var anim = false
    @State var changePic = false
    @State private var isPresented: Bool = false
    
    @State private var avatarItem: PhotosPickerItem?

    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            if isPresented {
                Image(.pine)
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(0.9)
                    .ignoresSafeArea()
                    .offset(x: -160, y: 150)
                    .transition(.offset(x: -50, y: 200))
                    .blur(radius: changePic ? 2 : 0)
                
                Image(.pine)
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(1.1)
                    .ignoresSafeArea()
                    .offset(x: 160, y: 130)
                    .transition(.offset(x: 100, y: 300))
                    .blur(radius: changePic ? 2 : 0)
            }
             
            
            notiButton()
                .frame(maxWidth: 380)
                .transaction { $0.animation = nil }
                .blur(radius: changePic ? 2 : 0)
            
            VStack {
                profilePic()
                
                nameAShare()
                    .blur(radius: changePic ? 2 : 0)

            }
            .padding(.horizontal, 10)
            .transaction { $0.animation = nil }
        }
        .onAppear {
            withAnimation(.smooth(duration: 1.0)) {
                isPresented = true
            }
        }
        .onDisappear{
            changePic = false
            isPresented = false
        }
    }
    
    // MARK: - PIC
    func profilePic() -> some View {
        ZStack {
            Circle()
                .fill(
                    RadialGradient(colors: [.accent, Color.clear], center: .center, startRadius: 50, endRadius: 75)
                )
                .frame(width: 210)
                .scaleEffect(x: anim ? 1.5 : 1, y: anim ? 1.5 : 1)
                .onAppear {
                }
            Image(uiImage: modelData.profile.profilePic)
                .resizable()
                .scaledToFill()
                .frame(width: 180, height: 180)
                .background()
                .clipShape(Circle())
                .scaleEffect(x: changePic ? 1.1 : 1, y: changePic ? 1.1 : 1)
                .onLongPressGesture(minimumDuration: 0.5) {
                    withAnimation() {
                        changePic = true
                    }
                }
        }
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
    
    // MARK: - TOP BAR
    func notiButton() -> some View {
        HStack {
            Button {
                //
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                    .foregroundStyle(.second)
            }
            Spacer()
            Button {
                //
            } label: {
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .foregroundStyle(.second)
            }
        }
        .padding(.horizontal, 17)
    }
    
    // MARK: - USERNAME
    func nameAShare() -> some View {
        HStack {
            Text(modelData.profile.username)
                .font(.title)
                .foregroundStyle(.white)
                .bold()
                .foregroundStyle(.second)
                .offset(y: -10)
            Button {
                
            } label: {
                Image(systemName: "square.and.arrow.up")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundStyle(.accent)
                    .offset(y: -15)
            }
        }
    }
}

#Preview {
    ProfileView()
}
