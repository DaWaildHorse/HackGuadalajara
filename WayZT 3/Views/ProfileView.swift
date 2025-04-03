import SwiftUI
import PhotosUI

struct ProfileView: View {
    // MARK: - ATTRIBUTE
    var modelData: ModelData = .shared

    @State private var anim = false
    @State var changePic = false
    @State private var isPresented: Bool = false

    // MARK: - BODY
    var body: some View {
        ZStack(alignment: .top) {
            notiButton()
                .transaction { $0.animation = nil }
                .offset(y: -15)
                .blur(radius: changePic ? 2 : 0)
                .padding(.top, 10)

            // Wrap the entire content in a ScrollView
            ScrollView {
                VStack {
                    UserProfile(changePic: $changePic)
                    
                    ProgressBars()
                        .frame(maxWidth: 350, maxHeight: 300)
                        .padding(.bottom, 10)
                        .padding(.top, 40)
                        .blur(radius: changePic ? 2 : 0)
                    
                    Spacer()
                    
                    UserAchievements()
                        .frame(maxWidth: 350, maxHeight: 300)
                        .padding(.top, 30)
                        .padding(.bottom, 40)
                        .blur(radius: changePic ? 2 : 0)

                    
                    Spacer()
                }
            }
            .scrollIndicators(.hidden)
            .padding([.top, .leading, .trailing])
            .padding(.top, 30)
            .background {
                Color.second.ignoresSafeArea().opacity(0.1)
                
                if isPresented {
                    Image(.pine)
                        .scaleEffect(0.65)
                        .ignoresSafeArea()
                        .offset(x: -160, y: 150)
                        .transition(.offset(x: -50, y: 100))
                        .blur(radius: changePic ? 2 : 0)
                    
                    
                }
            }//: BACKGROUND
            // MARK: - ANIMS
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
    }
    
    // MARK: - TOP BAR
    func notiButton() -> some View {
        HStack {
            Button {
                //
            } label: {
                Image(systemName: "gearshape.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 35)
                    .foregroundStyle(.accent)
            }
            Spacer()
            NavigationLink {
                ArticlesView()
            } label: {
                Image(systemName: "newspaper.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 30)
                    .foregroundStyle(.accent)
            }
        }
        .padding(.horizontal, 17)
    }
    
    func addFriends(){
        
    }
    
}

#Preview {
    ProfileView()
}
