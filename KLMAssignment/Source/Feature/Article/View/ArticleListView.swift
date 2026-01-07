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
            .frame(width: 80, height: 100)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .accessibilityIdentifier("showArticleImage")
            
            VStack(alignment: .leading, spacing: 8) {
                Text(article.title ?? "")
                    .font(.headline)
                    .foregroundColor(.primary)
                    .accessibilityIdentifier("articleTitle")
            }
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
        .background(Color(.systemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
        .shadow(radius: 2)
        .listRowBackground(Color.clear)
    }
}
