//
//  ArticleDisplay.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 05/03/24.
//

import SwiftUI

struct ArticleDisplay: View {
    // MARK: - ATTRIBUTES
    let data: Article
    
    // MARK: - BODY
    var body: some View {
        ScrollView(showsIndicators: false) {
            HStack {
                Text(data.title)
                    .font(.title)
                    .bold()
                    .foregroundStyle(.second)
                Link(destination: URL(string: data.URL)!, label: {
                    Image(systemName: "link.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30)
                })
            }
            HStack {
                Text(data.author)
                    .foregroundStyle(.second)
                    .bold()
                    .italic()
                Divider()
                Text(data.date, style: .date)
                    .foregroundStyle(.second)
                    .bold()
                    .italic()
            }
            ForEach(0..<data.textBody.count, id:\.self) { i in
                Text(data.textBody[i])
                    .foregroundStyle(.second)
                    .padding(.top, 10)
            }
            Link(destination: URL(string: data.URL)!, label: {
                Image(systemName: "link.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 40)
            })
        }
        .padding(.horizontal, 15)
        .background(.mainBackground)
    }
}

#Preview {
    ArticleDisplay(data: Article.testArticles[0])
}
