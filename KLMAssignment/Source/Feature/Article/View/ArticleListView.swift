import SwiftUI

struct ArticleListView: View {
    let article: Article
    
    var body: some View {
        HStack(alignment: .center) {
            AsyncImage(url: URL(string: article.imageURL ?? "")) { image in
                image.resizable()
            } placeholder: {
                Rectangle().foregroundColor(.gray)
            }
            .frame(width: 100, height: 150)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .accessibilityIdentifier("showArticleImage")
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibilityIdentifier("articleTitle")
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
    }
}
