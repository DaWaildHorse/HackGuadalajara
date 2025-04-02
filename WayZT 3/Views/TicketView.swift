import SwiftUI

struct TicketView: View {
    // MARK: - ATTRIBUTES
    var modelData = ModelData.shared
    @State private var isContentVisible = false
    private let delayTime: TimeInterval = 1.0
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Spacer()
                
                Text("Ticket Transcript")
                    .font(.title)
                    .bold()
                
                if isContentVisible {
                    if let recognizedText = modelData.recognizedText, !recognizedText.isEmpty {
                        VStack {
                            Text(recognizedText)
                                .font(.body)
                                .foregroundStyle(.second)
                        }
                        .frame(maxWidth: .infinity, maxHeight: 16)
                        .cornerRadius(10)
                    } else {
                        Text("Processing ticket...")
                            .font(.headline)
                            .foregroundStyle(.second)
                    }
                } else {
                    Text("Please wait...")
                        .font(.headline)
                        .foregroundStyle(.second)
                }
                
                Spacer()
                Button {
                    modelData.stopRecog.toggle()
                } label: {
                    Image(systemName: modelData.stopRecog ? "play.circle.fill" : "stop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 60)
                        .padding()
                        .symbolEffect(.pulse.wholeSymbol, isActive: !modelData.stopRecog)
                        .contentTransition(.symbolEffect(.replace))
                }
            }//: VSTACK
            
            Spacer()
        }
        // MARK: - BACKGROUND
        .background {
            Color.mainBackground.opacity(0.9)
            
            if isContentVisible {
                Image(.leafs) // Adjusted to ensure the image name is correct
                    .scaleEffect(0.6)
                    .opacity(0.7)
                    .rotationEffect(.degrees(-20))
                    .offset(x: 150, y: 200)
                    .transition(.offset(x: 100, y: 200))
                    .frame(width: 100)
            }
        }
        // MARK: - ON APPEAR
        .onAppear {
            Task {
                try? await Task.sleep(for: .seconds(0.5))
                withAnimation() {
                    isContentVisible = true
                }
            }
        }
    }
}

#Preview {
    TicketView()
}
