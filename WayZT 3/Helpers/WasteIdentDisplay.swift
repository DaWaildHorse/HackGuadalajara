//
//  WasteIdentDisplay.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 02/03/24.
//

import SwiftUI

// MARK: - V1
struct WasteIdentDisplay: View {
    var modelData: ModelData = .shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.mainBackground)
                    .frame(height: 55)
                
                HStack {
                    Image("tierra")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45)
                    Spacer()
                    FindMapButton()
                    Spacer()
                    QuantityButton()
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
            }
            .padding(.horizontal, 15)

        }//: NAV STACK
    }
}

// MARK: - V2
struct WasteIdentDisplay2: View {
    var modelData: ModelData = .shared
    
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(height: 110)
                    .foregroundColor(.mainBackground)
                
                VStack {
                    HStack {
                        Image("tierra")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 45)
                        Spacer()
                        Text(modelData.IdentfiedWaste)
                            .font(.title)
                            .foregroundStyle(.second)
                            .bold()
                        Spacer()
                        QuantityButton()
                    }
                    FindMapButton()
                }
                .padding(.horizontal, 15)
                .padding(.vertical, 10)
            }
            .padding(.horizontal, 15)
        }//: NAV STACK
    }
}

// MARK: - QUANTITY
struct QuantityButton: View {
    var modelData: ModelData = .shared
    
    var body: some View {
        Menu {
            Button("Agrega 1", action: Add_1)
            Button("Agrega 2", action: Add_2)
            Button("Agrega 5", action: Add_5)
            Button("Agrega 10", action: Add_10)
        } label: {
            Image(systemName: "trash")
                .resizable()
                .scaledToFit()
                .foregroundStyle(.accent)
                .frame(width: 30)
                .overlay {
                    ZStack {
                        Circle()
                            .frame(width: 23)
                            .foregroundStyle(.mainBackground)
                        Image(systemName: "plus.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundStyle(.accent)
                            .frame(width: 18)
                    }
                    .offset(x: 7, y: -7)
                }
        }
    }
    
    func Add_1() {
        modelData.profile.AddWaste(quantity: 1, type: modelData.IdentfiedWaste)
        return
    }
    func Add_2() {
        modelData.profile.AddWaste(quantity: 2, type: modelData.IdentfiedWaste)
        return
    }
    func Add_5() {
        modelData.profile.AddWaste(quantity: 5, type: modelData.IdentfiedWaste)
        return
    }
    func Add_10() {
        modelData.profile.AddWaste(quantity: 10, type: modelData.IdentfiedWaste)
        return
    }
}

// MARK: - FIND
struct FindMapButton: View {
    var modelData: ModelData = .shared
    
    var body: some View {
        NavigationLink {
            switch modelData.IdentfiedWaste {
            case "Electronic":
                ElectronicsMap()
            case "Recycle":
                RecycleMap()
            case "Organic":
                OrganicMap()
            case "Glass":
                GlassMap()
            default:
                ElectronicsMap()
            }
        } label: {
            RoundedRectangle(cornerRadius: 15)
                .frame(height: 35)
                .foregroundStyle(.second)
                .overlay {
                    Text("Explora lugares")
                        .font(.title3)
                        .bold()
                        .foregroundStyle(.accent)
                }
        }
    }
}


#Preview {
    WasteIdentDisplay2()
}
