//
//  ProfileView.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 28/02/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    // MARK: - ATTRIBUTE
    var modelData: ModelData = .shared
    let colorP = ColorPalette()
    
    @State private var anim = false
    @State var changePic = false
    
    @State private var avatarItem: PhotosPickerItem?

    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.second)
                .ignoresSafeArea()
                .opacity(0.2)
            
            Rectangle()
                .fill(
                    LinearGradient(colors: [.accent, .accent, .accent],
                                   startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .shadow(color: .accent, radius: 12)
                .frame(height: 150)
                .blur(radius: changePic ? 2 : 0)
                .ignoresSafeArea()
            
            notiButton()
                .blur(radius: changePic ? 2 : 0)
            
            VStack {
                profilePic()
                
                nameAShare()
                    .blur(radius: changePic ? 2 : 0)
            }
            .padding(.horizontal, 10)
        }
        .onDisappear{
            changePic = false
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
                    withAnimation(.easeInOut(duration: 3).repeatForever(autoreverses: true)) {
                        anim.toggle()
                    }
                }
            Image(.frame)
                .resizable()
                .scaledToFit()
                .frame(width: 240)
                .offset(x: -1)
                .rotationEffect(.degrees(anim ? 45 : 0))
                .scaleEffect(x: anim ? 1 : 0.99, y: anim ? 1 : 0.99)
                .blur(radius: changePic ? 2 : 0)
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
                    .foregroundStyle(.mainBackground)
            }
            Spacer()
            Button {
                //
            } label: {
                Image(systemName: "bell.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .foregroundStyle(.mainBackground)
            }
        }
        .padding(.horizontal, 17)
    }
    
    // MARK: - USERNAME
    func nameAShare() -> some View {
        HStack {
            Text(modelData.profile.username)
                .font(.title)
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
