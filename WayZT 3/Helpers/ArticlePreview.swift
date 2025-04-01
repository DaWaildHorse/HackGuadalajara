//
//  ArticlePreview.swift
//  Waste Manager
//
//  Created by Ultiimate Dog on 03/03/24.
//

import SwiftUI

struct ArticlePreview: View {
    // MARK: - ATTRIBUTES
    var modelData: ModelData = .shared
    let data: Article
    
    // MARK: - BODY
    var body: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(.mainBackground)
            .frame(height: 140)
            .overlay {
                HStack {
                    data.previewImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 120, height: 120)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    
                    VStack(alignment: .leading, spacing: 0) {
                        Text(data.title)
                            .font(.headline)
                            .bold()
                            .foregroundStyle(.second)
                            .multilineTextAlignment(.leading)
                        Spacer()
                        HStack {
                            data.authorPicture
                                .resizable()
                                .scaledToFit()
                                .frame(width: 25)
                                .clipShape(Circle())
                            
                            Text(data.author)
                                .font(.caption)
                                .italic()
                                .lineLimit(1)
                                .foregroundStyle(.second)
                            
                            Spacer()
                            
                            Text(data.date, style: .date)
                                .font(.caption)
                                .italic()
                                .lineLimit(1)
                                .foregroundStyle(.second)
                        }
                    }
                }//: HSTACK
                .padding(.all, 10)
            }
    }
}

#Preview {
    ArticlePreview(data: Article.testArticles[0])
        .background(.black)
}
