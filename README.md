KLM Assignment

A clean, modern iOS app displaying real-time spaceflight news from Spaceflight News API v4. Built with SwiftUI, MVVM architecture, async/await, Core Data caching, and comprehensive unit/UI tests.

<img width="250" height="500" alt="Simulator Screenshot - iPhone 17 Pro - 2026-01-07 at 18 21 49" src="https://github.com/user-attachments/assets/22e9d340-721a-486e-ad8d-728e9719b76f" />

<img width="250" height="500" alt="Simulator Screenshot - iPhone 17 Pro - 2026-01-07 at 18 21 57" src="https://github.com/user-attachments/assets/f9fae0d0-421d-4678-807b-052a17b19e89" />

<img width="250" height="500" alt="Simulator Screenshot - iPad mini (A17 Pro) - 2026-01-07 at 18 22 40" src="https://github.com/user-attachments/assets/8f7be021-f5f6-401c-b0e5-24141fba408a" />

<img width="250" height="500" alt="Simulator Screenshot - iPad mini (A17 Pro) - 2026-01-07 at 18 22 46" src="https://github.com/user-attachments/assets/e6e01e43-77b0-481f-96fc-1e09e3196803" />

## ✨ Features

<div align="center">

| 🎯 Feature | ✅ Status |
|------------|----------|
| Live Spaceflight News (NASA, SpaceX) | ✅ Complete |
| Offline Core Data Cache | ✅ Complete |
| Loading/Empty/Error States | ✅ Complete |
| MVVM + Clean Architecture | ✅ Complete |
| Unit/UI Tests (60%+) | ✅ Complete |
| Pull-to-Refresh | ✅ Complete |
| Responsive iPhone + iPad | ✅ Complete |

</div>

  Key Patterns:
	•	Dependency Injection: Mockable services for tests.
	•	LoadingState Enum:  .idle | .loading | .loaded | .empty | .error .
	•	Async/Await: Modern concurrency throughout.

  KLMAssignmentApp/
├── Models/
│   ├── Article.swift          # Codable Article struct
│   └── ArticleModel.swift     # API response wrapper
├── Services/
│   ├── ArticleService.swift   # Network + Cache repo
│   └── protocols.swift        # ArticleServiceProtocol
├── ViewModels/
│   └── ArticleViewModel.swift # LoadingState enum
├── Views/
│   ├── ArticleView.swift      # SwiftUI NavigationStack
│   ├── ArticleListView.swift  # List + refreshable
│   └── ArticleDetailView.swift
├── CoreData/
│   └── DataManager.swift      # Persistence layer
├── Networking/
│   └── APIClient.swift        # URLSession async/await
└── Tests/
    ├── Unit/                  # ViewModel, Service tests
    └── UI/                    # XCUITest full flows


  Tech Stack
	•	SwiftUI: Declarative UI with  @StateObject, .task  .
	•	Async/Await: Modern networking + Core Data.
	•	Core Data: Offline caching with  DataManagerProtocol .
	•	XCTest: Comprehensive unit.
