## KLM Assignment

A clean, modern iOS app displaying real-time spaceflight news from Spaceflight News API v4. Built with SwiftUI, MVVM architecture, async/await, Core Data caching, and comprehensive unit tests.

## ScreenShots

<img width="250" height="500" alt="Simulator Screenshot - iPhone 17 Pro - 2026-01-07 at 18 21 49" src="https://github.com/user-attachments/assets/22e9d340-721a-486e-ad8d-728e9719b76f" />

<img width="250" height="500" alt="Simulator Screenshot - iPhone 17 Pro - 2026-01-07 at 18 21 57" src="https://github.com/user-attachments/assets/f9fae0d0-421d-4678-807b-052a17b19e89" />

<img width="250" height="500" alt="Simulator Screenshot - iPad mini (A17 Pro) - 2026-01-07 at 18 22 40" src="https://github.com/user-attachments/assets/8f7be021-f5f6-401c-b0e5-24141fba408a" />

<img width="250" height="500" alt="Simulator Screenshot - iPad mini (A17 Pro) - 2026-01-07 at 18 22 46" src="https://github.com/user-attachments/assets/e6e01e43-77b0-481f-96fc-1e09e3196803" />

 ## Feature
* Live Spaceflight News:  NASA, SpaceX, SpaceNews articles via v4 API
* Offline Support: Core Data cache fallback 
* Error Handling: Loading/Empty/Error states 
* MVVM Architecture: ViewModel → Service
* Testing 60%+ coverage: Unit tests

 ## Key Patterns
 * Dependency Injection: Mockable services for tests.
 * LoadingState Enum:  .idle | .loading | .loaded | .empty | .error.
 * Async/Await: Modern concurrency throughout

 ## Project Structure 
```
KLMAssignmentApp/
├── Models/
│   ├── Article.swift              
│   └── ArticleModel.swift        
├── Services/
│   ├── ArticleService.swift       
│   └── ArticleServiceProtocol.swift
├── ViewModels/
│   └── ArticleViewModel.swift     
├── Views/
│   ├── ArticleView.swift          
│   ├── ArticleListView.swift      
│   └── ArticleDetailView.swift
├── CoreData/
│   └── DataManager.swift          
├── Networking/
│   └── APIClient.swift            
└── Tests/
    ├── UnitTests/                 
    └── UITests/
```
 ## Prerequisites
 * Xcode 16.0+
 * iOS 16.0+
	
 ## Tech Stack
  * SwiftUI: Declarative UI with  @StateObject, .task.
  * Async/Await: Modern networking + Core Data.
  * Core Data: Offline caching with  DataManagerProtocol.
  * XCTest: Comprehensive unit.
