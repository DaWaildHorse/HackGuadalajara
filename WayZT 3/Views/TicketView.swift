import SwiftUI

struct TicketView: View {
    var modelData = ModelData.shared
    
    @Environment(\.presentationMode) var presentationMode // To access the presentation mode
    
    // State to track if the content is ready to be shown
    @State private var isContentVisible = false
    
    // Delay time
    private let delayTime: TimeInterval = 1.0
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.ignoresSafeArea() // Fullscreen background
                Image(.leafs) // Adjusted to ensure the image name is correct
                    .resizable()
                    .scaledToFill()
                    .scaleEffect(0.7)
                    .ignoresSafeArea()
                    .opacity(0.8)
                    .offset(x: 160, y: 200)
                    .transition(.offset(x: -50, y: 200))
                
                VStack {
                    Text("Ticket Transcript")
                        .font(.title)
                        .bold()
                    
                    if isContentVisible {
                        if let recognizedText = modelData.recognizedText, !recognizedText.isEmpty {
                            VStack {
                                Text(recognizedText)
                                    .font(.body)
                                    .foregroundColor(.white)
                            }
                            .frame(maxWidth: .infinity, maxHeight: 16)
                            .cornerRadius(10)
                        } else {
                            Text("Processing ticket...")
                                .font(.headline)
                                .foregroundColor(.white)
                        }
                    } else {
                        Text("Please wait...")
                            .font(.headline)
                            .foregroundColor(.white)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.all)
            }
            .onAppear {
                // Trigger the delay when the view appears
                DispatchQueue.main.asyncAfter(deadline: .now() + delayTime) {
                    // Update the state after the delay
                    isContentVisible = true
                }
            }
        }
    }
}

#Preview {
    TicketView()
}
