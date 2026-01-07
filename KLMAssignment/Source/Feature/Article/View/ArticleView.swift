import SwiftUI

struct ArticleView: View {
    
    @StateObject var viewModel = ArticleViewModel()

    var body: some View {
        NavigationStack {
            Group {
                content
            }
            .navigationTitle("Articles")
        }
        .task {
            await viewModel.getAllArticles()
        }
    }
    
    @ViewBuilder
    private var content: some View {
        switch viewModel.loadingState {
        case .idle:
            Color.clear
        case .loading:
            LoadingView()
                .accessibilityIdentifier("loader")
        case .loaded(let articles):
            List(articles) { article in
                NavigationLink(value: article) {
                    ArticleListView(article: article)
                        .accessibilityIdentifier("articleList")
                }
                .buttonStyle(.plain)
                .listRowSeparator(.hidden)
                .navigationLinkIndicatorVisibility(.hidden)
                .scrollContentBackground(.hidden)
            }
            .navigationDestination(for: Article.self) { article in
                ArticleDetailView(id: article.id)
            }
        case .empty:
            ErrorView (message: "No Article Found")
        case .error(let error):
            ErrorView (message: "Errror Found \(error.localizedDescription)")
        }
    }
}

#Preview {
    ArticleView(viewModel: ArticleViewModel())
}
