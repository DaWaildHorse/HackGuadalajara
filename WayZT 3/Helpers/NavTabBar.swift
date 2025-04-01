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
    
    // MARK: - BODY
    var body: some View {
        VStack {
            Spacer()
            ZStack {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.mainBackground)
                    .strokeBorder(.accent, lineWidth: 0)
                    .frame(height: 50)
                    .shadow(color: .mainBackground.opacity(0.4),
                            radius: 12, x: 0, y: 10)
                
                
                
                TabsLayoutView(selectedTab: $selected)
            }
            .frame(maxWidth: 400)
            .padding(.horizontal)
            .padding(.bottom, 10)
        }//: VSTACK
    }
}

// MARK: - LAYOUT
fileprivate struct TabsLayoutView: View {
    @Binding var selectedTab: Tab
    @Namespace var namespace
    
    var body: some View {
        HStack {
            Spacer(minLength: 0)
            
            ForEach(Tab.allCases) { tab in
                TabButton(tab: tab, selectedTab: $selectedTab, namespace: namespace)
                    .frame(width: 65, height: 65, alignment: .center)
                
                Spacer(minLength: 0)
            }
        }
    }
    
    // MARK: - BUTTON
    private struct TabButton: View {
        // MARK: - ATTRIBUTES
        let tab: Tab
        @Binding var selectedTab: Tab
        var namespace: Namespace.ID
        
        // MARK: - BODY
        var body: some View {
            Button {
                withAnimation {
                    selectedTab = tab
                }
            } label: {
                ZStack {
                    if isSelected {
                        Circle()
                            .fill(.mainBackground)
                            .shadow(color: .mainBackground.opacity(0.2),
                                    radius: 5)
                            .background {
                                Circle()
                                    .stroke(lineWidth: 5)
                                    .foregroundColor(.accent)
                            }
                            .offset(y: -20)
                            .matchedGeometryEffect(id: "Selected Tab", in: namespace)
                            .animation(.spring(), value: selectedTab)
                    }
                    
                    Image(systemName: tab.rawValue)
                        .font(.system(size: 23, weight: .semibold, design: .rounded))
                        .foregroundColor(.second)
                        .scaleEffect(isSelected ? 1 : 0.8)
                        .offset(y: isSelected ? -20 : 0)
                        .animation(isSelected ? .spring(response: 0.5, dampingFraction: 0.3, blendDuration: 1) : .spring(), value: selectedTab)
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

