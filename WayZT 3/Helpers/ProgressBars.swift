 //
 //  ProgressBars.swift
 //  WayZT 3
 //
 //  Created by Ultiimate Dog on 02/04/25.
 //

 import SwiftUI

 struct ProgressBars: View {
     // MARK: - ATTRIBUTES
     var modelData: ModelData = .shared
     @State private var size: CGSize = .zero
     @State private var isExpanded: Bool = false
     
     // MARK: - BODY
     var body: some View {
         VStack(spacing: 0) {
             
             Text("Reciclaje")
                 .font(.title)
                 .foregroundColor(Color(.label))
                 .bold()
                 .frame(maxWidth: .infinity, alignment: .leading)
                 .padding(.bottom, 10)
             
             ForEach(modelData.categories) { cat in
                 Text(cat.name)
                     .fontWeight(.semibold)
                     .foregroundStyle(.second)
                 
                 HStack() {
                     Image(systemName: cat.systemImage)
                         .resizable()
                         .scaledToFit()
                         .foregroundStyle(.second)
                         .fontWeight(.semibold)
                         .frame(width: cat.size)
                         .frame(width: 50)
                     
                     if isExpanded {
                         progressBar((Double(cat.waste) / Double(cat.goal) * size.width) - size.width)
                     }
                 }//: VSTACK
                 .frame(height: 50)
             }//: FOR EACH
         }//: HSTACK
         .padding()
         .background(
             .thinMaterial
         )
         .clipShape(RoundedRectangle(cornerRadius: 20))
         .onAppear{
             DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                 withAnimation(.bouncy(duration: 1)) {
                     isExpanded = true
                 }
             }
         }
         .onDisappear {
             isExpanded = false
         }
     }
     
     // MARK: - CUSTOM PROGRESS BAR
     private func progressBar(_ val: Double) -> some View {
         Capsule()
             .stroke(lineWidth: 1)
             .fill(Color.second)
             .frame(height: 28)
             .overlay {
                 ZStack(alignment: .leading) {
                     GeometryReader { proxy in
                         Capsule()
                             .fill(.clear)
                             .padding(.horizontal, 5)
                             .frame(height: 20)
                             .onAppear {
                                 size = proxy.size
                             }
                     }
                     
                     Capsule()
                         .fill(.accent)
                         .padding(.horizontal, 5)
                         .frame(height: 25)
                         .mask {
                             Capsule()
                                 .fill(.accent)
                                 .padding(.horizontal, 5)
                                 .frame(height: 15)
                                 .offset(x: val)
                                 .transition(.move(edge: .leading))
                         }
                 }
             }
     }
 }

 #Preview {
     ProgressBars()
 }
 
 
