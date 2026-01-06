import Foundation
import CoreData

// Core Data Model Extensions
extension ArticleEntity {
    func articleEntity() -> Article {
        Article (id: Int(id),
                 title: title ?? "",
                 url: "",
                 imageURL: imageurl,
                 newsSite: newssite ?? "",
                 summary: summary ?? "",
        )
    }
}

protocol DataManagerProtocol {
    func saveArticleList(_ articles: [Article]) async throws
    func fetchArticlesFromCoreData() async throws -> [Article]
    func fetchArticleDetailById(id: Int) async throws -> Article?
}

final class DataManager: DataManagerProtocol {
    
    static let shared = DataManager()
    
    private let container: NSPersistentContainer
    
    private var mainContext: NSManagedObjectContext {
        container.viewContext
    }
    
    private lazy var backgroundContext: NSManagedObjectContext = {
        let backGroundContainer = container.newBackgroundContext()
        backGroundContainer.automaticallyMergesChangesFromParent = true
        backGroundContainer.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        return backGroundContainer
    }()
    
    private init() {
        container = NSPersistentContainer(name: "KLMAssignment")
        container.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Failed to load Core Data: \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
    }
    
    func saveArticleList(_ articles: [Article]) async throws {
        try await backgroundContext.perform {
            for article in articles {
                let entity = ArticleEntity(context: self.backgroundContext)
                entity.id = Int64(article.id)
                entity.title = article.title
                entity.imageurl = article.imageURL
                entity.newssite = article.newsSite
                entity.summary = article.summary
            }
            if self.backgroundContext.hasChanges {
                try self.backgroundContext.save()
            }
        }
    }
    
    func fetchArticlesFromCoreData() async throws -> [Article] {
        try await mainContext.perform {
            let request = ArticleEntity.fetchRequest()
            let entities = try self.mainContext.fetch(request)
            return entities.map { $0.articleEntity() }
        }
    }
    
    func fetchArticleDetailById(id: Int) async throws -> Article? {
        try await mainContext.perform {
            
            let articleRequest = ArticleEntity.fetchRequest()
            
            articleRequest.predicate = NSPredicate(format: "id == %d", id)
            
            return try self.mainContext.fetch(articleRequest).first?.articleEntity()
        }
        
    }
}
