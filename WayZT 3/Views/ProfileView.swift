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
            notiButton()
                .transaction { $0.animation = nil }
                .offset(y: -15)
                .blur(radius: changePic ? 2 : 0)
                .background(Color(.systemBackground))
                .zIndex(1) 
            // Wrap the entire content in a ScrollView
            ScrollView {
                VStack {
                    
                    UserProfile()
                        .padding(.top, 65)
                    
                    ProgressBars()
                        .frame(maxWidth: 350, maxHeight: 300)
                        .padding(.bottom, 30)
                        .padding(.top, 40)
                    
                    Spacer()
                    
                    UserAchievements()
                        .frame(maxWidth: 350, maxHeight: 300)
                        .padding(.top, 30)
                        .padding(.bottom, 40)

                    
                    Spacer()
                }
                .padding(.horizontal, 10)
            }
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
                .frame(width: 130, height: 130)
                .clipShape(Circle())
                .background(
                    Circle()
                        .fill(.accent)
                        .frame(width: 130, height: 130)
                )
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
    
    // MARK: - USERNAME
    func nameAShare() -> some View {
        VStack {
            Text(modelData.profile.username)
                .font(.title)
                .bold()
                .foregroundStyle(.second)
                .offset(y: -10)
        
            HStack{
                Image(systemName: "flame.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundStyle(.orange)
                
                Text("27.7")
                    .fontWeight(.heavy)
                    .foregroundStyle(.second)
            }
            .padding(.bottom, 20)
            
            HStack{
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 25)
                    .foregroundStyle(.second)
                
                Text("27.7")
                    .fontWeight(.heavy)
                    .foregroundStyle(.second)
            }
            
            precisionGauge(value: 27.7, color: .second)
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
    
    func precisionGauge(value: Float, color: Color) -> some View {
        ZStack {
            Gauge(value: value, in: 0...16) {
                Image(systemName: "heart.fill")
                    .foregroundColor(.red)
            } currentValueLabel: {
                Text(String(format: "%.2f", value))
                    .fontWeight(.heavy)
                    .foregroundStyle(color)
            } minimumValueLabel: {
                Text("Kg")
                    .fontWeight(.heavy)
                    .foregroundStyle(color)
            } maximumValueLabel: {
                Text("CO")
                    .fontWeight(.heavy)
                    .foregroundStyle(color)
            }
            .scaleEffect(1.5)
            .frame(height: 100)  // Increased height to make the gauge more visible
            .gaugeStyle(AccessoryCircularGaugeStyle())
            .tint(color) // This line changes the color of the gauge ring
        }
    }
    
    func addFriends(){
        
    }
    
}

#Preview {
    ProfileView()
}
