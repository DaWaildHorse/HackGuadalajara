import SwiftUI

struct WasteItem: Identifiable {
    let id = UUID()
    let name: String
    let isRecyclable: Bool
    var details: [String] // List of details for each item
}

struct TicketView: View {
    // MARK: - ATTRIBUTES
    var modelData = ModelData.shared
    @State private var isContentVisible = false
    @State private var expandedItem: UUID? = nil // Tracks which item is expanded
    private let delayTime: TimeInterval = 1.0
    
    let wasteItems = [
        WasteItem(name: "Takis Fuego", isRecyclable: false, details: ["Not biodegradable", "Contains plastic packaging"]),
        WasteItem(name: "Vasos Plastico", isRecyclable: true, details: ["Reusable", "Can be recycled in plastics bin"]),
        WasteItem(name: "Platano", isRecyclable: true, details: ["Organic waste", "Can be composted"])
    ]
    
    // MARK: - BODY
    var body: some View {
        HStack {
            Spacer()
            
            VStack {
                Spacer()
                
                Text("Huella de Carbono")
                    .font(.title)
                    .bold()
                
                if isContentVisible {
                    if let recognizedText = modelData.recognizedText, !recognizedText.isEmpty {
                        VStack {
                            ScrollView {
                                VStack(alignment: .leading, spacing: 5) {
                                    // Clickable list
                                    ForEach(wasteItems) { item in
                                        VStack(alignment: .leading) {
                                            Button(action: {
                                                withAnimation {
                                                    expandedItem = (expandedItem == item.id) ? nil : item.id
                                                }
                                            }) {
                                                HStack {
                                                    Text(item.name)
                                                        .font(.headline)
                                                        .foregroundColor(.white)
                                                        .padding(.horizontal, 15)
                                                        .padding(.vertical, 8)
                                                        .background(Capsule().fill(item.isRecyclable ? Color.green : Color.red))

                                                    Spacer()
                                                    
                                                    Image(systemName: expandedItem == item.id ? "chevron.up" : "chevron.down")
                                                        .foregroundColor(.white)
                                                }
                                            }

                                            if expandedItem == item.id {
                                                VStack(alignment: .leading, spacing: 3) {
                                                    ForEach(item.details, id: \.self) { detail in
                                                        Text("- \(detail)")
                                                            .font(.subheadline)
                                                            .foregroundColor(.white)
                                                            .padding(.leading, 10)
                                                    }
                                                }
                                                .padding(.top, 5)
                                            }
                                        }
                                        .padding(.vertical, 5)
                                    }
                                }
                            }
                            // Gauges
                            HStack {
                                VStack {
                                    precisionGauge(value: 3.5 , color: .accent)
                                    TextPill("Reciclable", color: .green).offset(y:30)
                                }
                                .offset(x: -25)
                                
                                VStack {
                                    precisionGauge(value: 1.12 , color: .red)
                                    TextPill("No Reciclable", color: .red).offset(y:30)
                                }
                                .offset(x: 25)
                            }
                            .offset(y:-150)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .background(.gray.opacity(1.00))
                            
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: 500)
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
                Image(.leafs)
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
                withAnimation {
                    isContentVisible = true
                }
            }
        }
    }
}

// MARK: - Capsule Text View
func TextPill(_ text: String, color: Color) -> some View {
    Text(text)
        .font(.headline)
        .foregroundColor(.white)
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(Capsule().fill(color))
}

func precisionGauge(value: Float , color : Color) -> some View {
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
            .frame(height: 10)
            .gaugeStyle(AccessoryCircularGaugeStyle())
        }
    }
#Preview {
    TicketView()
}
