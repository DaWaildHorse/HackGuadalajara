import SwiftUI

struct TicketView: View {
    var modelData = ModelData.shared
    
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // Fullscreen background
            
            VStack {
                Text("Ticket Transcript")
                    .font(.title)
                    .bold()
                    .foregroundColor(.white)
                    
                
                if let recognizedText = modelData.recognizedText, !recognizedText.isEmpty {
                    ScrollView {
                        Text(recognizedText)
                            .font(.body)
                            .padding()
                            .foregroundColor(.black)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.white.opacity(0.9))
                    .cornerRadius(10)
                    .padding()
                } else {
                    Text("Processing ticket...")
                        .font(.headline)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .edgesIgnoringSafeArea(.all)
        }
    }
}

#Preview {
    TicketView()
}
