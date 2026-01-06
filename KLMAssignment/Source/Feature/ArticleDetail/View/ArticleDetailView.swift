import Foundation
import SwiftUI

struct ArticleDetailView: View {
    
    @StateObject private var articleDetailViewModel = ArticleDetailViewModel()
    
    let id: Int
    
    init(id: Int) {
        self.id = id
    }
    
    var body: some View {
        Group {
            if articleDetailViewModel.isLoading {
                LoadingView()
                    .accessibilityIdentifier("articleDetail.loading")
            } else if let articleDetail = articleDetailViewModel.articleDetail {
                
                detailContent(articleDetail)
                    .navigationTitle(articleDetail.title ?? "")
                    .navigationBarTitleDisplayMode(.large)
                
            } else {
                ErrorView(
                    message: "Failed to load article details"
                )
                .accessibilityIdentifier("articleDetail.error")
            }
        }
        .task {
            await articleDetailViewModel.getArticleByIdFromDataManager(by: id)
        }
    }
    
    @ViewBuilder
    private func detailContent(_ articleDetail: Article) -> some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let articleImage = articleDetail.imageURL {
                    AsyncImage(url: URL(string: articleImage)) { image in
                        image.resizable()
                            .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 400)
                            .clipped()
                    } placeholder: {
                        Rectangle().foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, minHeight: 250, maxHeight: 400)
                    .clipped()
                    .overlay(
                        LinearGradient(
                            gradient: Gradient(colors: [Color.black.opacity(0.3), Color.clear]),
                            startPoint: .top,
                            endPoint: .center
                        )
                    )
                    .accessibilityHidden(true)
                }
                
                VStack(alignment: .leading, spacing: 12) {
                    Text("News Site")
                        .font(.title2)
                        .bold()
                        .padding(.top)
                        .accessibilityIdentifier("newsSite")
                    
                    Text(articleDetail.newsSite ?? "")
                        .font(.body)
                        .accessibilityIdentifier("newsSite.newsSiteText")
                    
                    if let name = articleDetail.title {
                        Text(name)
                            .font(.largeTitle)
                            .bold()
                            .accessibilityIdentifier("articleDetail.titleText")
                    }
                    
                    if let blog = articleDetail.summary {
                        Text(blog)
                            .font(.subheadline)
                            .italic()
                            .foregroundColor(.secondary)
                    }
                }
                .padding(.top, 8)
                .padding()
            }
            .padding(.bottom, 16)
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}
