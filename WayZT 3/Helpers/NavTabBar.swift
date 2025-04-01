//
//  NavTabBarView.swift
//  WayZT 3
//
//  Created by Ultiimate Dog on 01/04/25.
//

import SwiftUI

struct NavTabBar: View {
    // MARK: - ATTRIBUTES
    @Binding var selected: Tab
    let bgColor: Color = .init(white: 0.9)
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            TabsLayoutView(selectedTab: $selected)
                .padding()
                .background(
                    Capsule()
                        .fill(.mainBackground)
                        .frame(height: 55)
                        .shadow(color: .mainBackground.opacity(0.5), radius: 5)
                )
                .frame(maxWidth: 400)
                .padding(.horizontal)
                .padding(.vertical, 10)
        }//: VSTACK
    }
}

// MARK: - LAYOUT
fileprivate struct TabsLayoutView: View {
    @Binding var selectedTab: Tab
    @Namespace var namespace
    
    var body: some View {
        HStack {
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
            }
        }
    }
    
    private struct TabButton: View {
        // MARK: - ATTRIBUTES
        let tab: Tab
        @Binding var selectedTab: Tab
        var namespace: Namespace.ID
        @State private var selectedOffset: CGFloat = 0
        @State private var rotationAngle: CGFloat = 0
        
        // MARK: - BODY
        var body: some View {
            Button {
                withAnimation(.easeInOut) {
                    selectedTab = tab
                }
                
                selectedOffset = -60
                if tab < selectedTab {
                    rotationAngle += 360
                } else {
                    rotationAngle -= 360
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    selectedOffset = 0
                    if tab < selectedTab {
                        rotationAngle += 0
                    } else {
                        rotationAngle -= 0
                    }
                }
            } label: {
                ZStack {
                    if isSelected {
                        Capsule()
                            .fill(.accent)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                            .frame(height: 40)
                    }
                    HStack(spacing: 10) {
                        Image(systemName: tab.image)
                            .font(.system(size: 20, weight: .semibold, design: .rounded))
                            .foregroundColor(.second)
                            .rotationEffect(.degrees(rotationAngle))
                            .scaleEffect(isSelected ? 1 : 0.9)
                            .animation(.easeInOut, value: rotationAngle)
                            .padding(.leading, isSelected ? 20 : 0)
                            .padding(.horizontal, selectedTab != tab ? 10 : 0)
                            .offset(y: selectedOffset)
                            .animation(.default, value: selectedOffset)
                        
                        if isSelected {
                            Text(tab.tabName)
                                .font(.system(size: 20, weight: .semibold, design: .rounded))
                                .foregroundColor(.second)
                                .padding(.trailing, 20)
                        }
                    }
                    .padding(.vertical, 10)
                }
            }
            .buttonStyle(.plain)
        }
        
        private var isSelected: Bool {
            selectedTab == tab
        }
    }
}


// MARK: - PREVIEW
#Preview {
    NavTabBar(selected: .constant(.Profile))
}

