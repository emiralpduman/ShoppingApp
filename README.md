# ShoppingApp

![CI](https://github.com/emiralpduman/ShoppingApp/actions/workflows/ci.yml/badge.svg)
![Coverage](https://codecov.io/gh/emiralpduman/ShoppingApp/branch/main/graph/badge.svg)
![Swift](https://img.shields.io/badge/Swift-5.7-F05138?style=flat&logo=swift&logoColor=white)
![Platform](https://img.shields.io/badge/Platform-iOS%2015+-blue?style=flat&logo=apple&logoColor=white)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-6C757D?style=flat)
![UIKit](https://img.shields.io/badge/UI-Programmatic%20UIKit-2396F3?style=flat)
![SwiftLint](https://img.shields.io/badge/SwiftLint-Enabled-B1178E?style=flat&logo=swift&logoColor=white)
![License](https://img.shields.io/badge/License-MIT-green?style=flat)

An e-commerce iOS app where users can browse products, view details, manage a shopping cart, and place orders. Built as the final project for the **Patika.dev Pazarama iOS Bootcamp** (Oct – Nov 2022). All UI is written programmatically with UIKit and SnapKit — no storyboards.

## Screenshots

| Sign In | Sign Up | Products & Details | Cart & Checkout | Profile |
|---|---|---|---|---|
| ![signIn](https://user-images.githubusercontent.com/83015729/200600070-cb1e4603-699d-4554-ac7c-a03017272021.gif) | ![signUp](https://user-images.githubusercontent.com/83015729/200608654-09f89dff-ce67-4a6a-9681-7de748850434.gif) | ![products](https://user-images.githubusercontent.com/83015729/200606033-9606598f-ed0f-4aaa-a657-a728c5e6c2d3.gif) | ![cart](https://user-images.githubusercontent.com/83015729/200605897-a3f5fb07-9029-47a4-bdcf-309096a83550.gif) | ![profile](https://user-images.githubusercontent.com/83015729/200606198-2393504f-df59-43df-a9ee-d5cd3532bfa3.gif) |

## Tech Stack

| Category | Tools |
|---|---|
| **Language** | Swift 5.7 |
| **UI** | UIKit (programmatic), SnapKit |
| **Architecture** | MVVM, Delegate pattern, Protocol-Oriented Programming |
| **Networking** | Moya (FakeStore API) |
| **Persistence** | Realm |
| **Image Loading** | Kingfisher |
| **Auth & Backend** | Firebase |
| **Dependency Management** | Swift Package Manager |

## Architecture

```mermaid
graph TD
    A[AppDelegate] --> B[MainTabBarController]
    B --> C[ProductsViewController]
    B --> D[CartViewController]
    B --> E[ProfileViewController]

    C --> F[ProductsViewModel]
    D --> G[CartViewModel]
    E --> H[ProfileViewModel]

    F -->|Delegate Pattern| C
    G -->|Delegate Pattern| D
    H -->|Delegate Pattern| E

    F --> I[ShoppingAppAPIMoya Service Layer]
    F --> J[RealmReachableProtocol Extension]
    G --> J
    H --> J

    I -->|REST| K[FakeStore API]
    J -->|Persistence| L[Realm DB]

    style I fill:#f9f,stroke:#333
    style J fill:#bbf,stroke:#333
```

```
ShoppingApp/
├── App/
│   ├── Core/Protocols/       # RealmReachable protocol (DI via protocol extensions)
│   └── Delegates/            # AppDelegate
├── Screens/
│   ├── Authentication/       # Sign in / Sign up (Firebase Auth)
│   ├── Launch/               # Splash screen
│   ├── Products/             # Product listing, detail, add-to-cart
│   ├── Cart/                 # Cart management & checkout
│   ├── Profile/              # User profile & sign out
│   └── Main/                 # TabBarController
└── ShoppingAppAPI/           # Separate module — Moya service layer
```

Each screen follows **MVVM**: `View` (programmatic UIKit) → `ViewController` → `ViewModel`. ViewModels communicate with ViewControllers via the **delegate pattern**. Data persistence is abstracted through the `RealmReachable` protocol, injected via protocol extensions.

> For a detailed breakdown of architectural decisions, see [ARCHITECTURE.md](ARCHITECTURE.md).

## Prerequisites

- Xcode 14+
- iOS 15+
- Swift 5.7

## Installation

```bash
git clone https://github.com/emiralpduman/ShoppingApp.git
cd ShoppingApp
open Shopping\ App.xcworkspace
```

All dependencies are resolved automatically via Swift Package Manager.

## Setup

This app requires a Firebase project for authentication. The `GoogleService-Info.plist` file is **not** included in the repository for security reasons.

1. Go to the [Firebase Console](https://console.firebase.google.com/) and create a new project (or use an existing one).
2. Add an iOS app with your bundle identifier.
3. Download the generated `GoogleService-Info.plist` file.
4. Place it at:
   ```
   Shopping App/App/Plists/GoogleService-Info.plist
   ```
5. Build and run. The plist is gitignored and will not be committed.

> See `GoogleService-Info-example.plist` in the same directory for the expected structure.

## License

Distributed under the MIT License.

## Contact

Emiralp Duman — [LinkedIn](https://linkedin.com/in/emiralp-duman) — emiralpduman@gmail.com
