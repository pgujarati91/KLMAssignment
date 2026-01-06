import Foundation

struct ArticleModel: Codable {
    let count: Int
    let next, previous: String?
    let results: [Article]
}

// MARK: - Article
struct Article: Codable, Identifiable, Hashable {
    let id: Int
    let title: String?
    let url: String?
    let imageURL: String?
    let newsSite: String?
    let summary: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, url
        case imageURL = "image_url"
        case newsSite = "news_site"
        case summary
    }
    
//    static func == (lhs: Article, rhs: Article) -> Bool {
//        lhs.id == rhs.id
//    }
}
