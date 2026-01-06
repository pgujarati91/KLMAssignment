import SwiftUI
import CoreData

@main
struct KLMAssignmentApp: App {
    let persistenceController = PersistenceController.shared

    let viewModel = ArticleViewModel()
    
    var body: some Scene {
        WindowGroup {
            ArticleView(viewModel: viewModel)
        }
    }
}
