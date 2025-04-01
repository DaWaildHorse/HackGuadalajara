//
//  SearchButton.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 01/03/24.
//

import SwiftUI

struct SearchBar: View {
    // MARK: - ATTRIBUTES
    @State var searchText = ""
    let placeholderText: String
    
    // MARK: - BODY
    var body: some View {
        HStack {
            // MARK: - SEARCH
            Button {
                //
            } label: {
                Image(systemName: "sparkle.magnifyingglass")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.accent)
                    .fontWeight(.semibold)
                    .frame(height: 28)
                    
            }
            .padding(.leading, 12)
            
            // MARK: - TEXT
            TextField(placeholderText, text: $searchText)
                .foregroundStyle(.second)
                .bold()
            
            // MARK: - CANCEL
            Button {
                searchText = ""
            } label: {
                Image(systemName: "xmark")
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.accent)
                    .fontWeight(.semibold)
                    .frame(height: 20)
            }
        }
        .padding(.trailing, 20)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(.mainBackground)
            .frame(height: 40)
        )
    }
}

#Preview {
    SearchBar(placeholderText: "Busca un servicio")
        .background(.black)
}
