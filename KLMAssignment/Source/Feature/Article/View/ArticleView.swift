import SwiftUI

struct ArticleView: View {
    
    @StateObject var viewModel = ArticleViewModel()

    var body: some View {
        NavigationStack {
            content
                .navigationTitle("Articles")
        }
        .task {
            await viewModel.getAllArticles()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        if viewModel.isLoading && viewModel.article.isEmpty {
            LoadingView()
                .accessibilityIdentifier("loader")
            
        } else if viewModel.article.isEmpty {
            ErrorView (message: "No Article Found")
        }
        else {
            List(viewModel.article) { article in
                
                NavigationLink(value: article) {
                    ArticleListView(article: article)
                        .accessibilityIdentifier("articleList")
                }
                
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .navigationLinkIndicatorVisibility(.hidden)
            }
            .accessibilityIdentifier("articleList")
            .navigationDestination(for: Article.self) { article in
                ArticleDetailView(id: article.id)
            }
        }
    }
}

#Preview {
    ArticleView(viewModel: ArticleViewModel())
}
