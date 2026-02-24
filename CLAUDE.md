# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

iOS e-commerce shopping app (Patika.dev Pazarama Bootcamp final project). Users authenticate via Firebase, browse products from the FakeStore API, manage a shopping cart, and check out.

## Build & Run

- Open `Shopping App.xcworkspace` (not the `.xcodeproj`) — the workspace includes both the main app and the `ShoppingAppAPI` local framework.
- Dependencies are managed via **Swift Package Manager** (resolved through Xcode).
- Build and run the `Shopping App` scheme targeting an iOS simulator.
- Tests live in `ShoppingAppAPI/ShoppingAppAPITests/` — run with `Cmd+U` in Xcode or `xcodebuild test -workspace "Shopping App.xcworkspace" -scheme ShoppingAppAPI -destination 'platform=iOS Simulator,name=iPhone 16'`.

## Architecture

**MVVM per screen** — each screen under `Shopping App/Screens/` follows this layout:

```
ScreenName/
  ViewController/  — UIViewController subclass, owns the View and ViewModel
  ViewModel/       — Business logic, communicates back via a delegate protocol
  View/            — Programmatic UI built with SnapKit constraints
  Model/           — Screen-specific data types (if any)
```

ViewController ↔ ViewModel communication uses **delegate protocols** (e.g. `ProductsViewModelDelegate`, `AuthViewModelDelegate`). ViewModels call delegate methods to push state changes back to the ViewController.

**Screens:** Launch, Authentication, Main (tab bar), Products (includes ProductDetail and AddToCart sub-flows), Cart, Profile. The Search tab exists as a placeholder (empty `UIViewController`).

**App launch flow:** `AppDelegate` → `LaunchViewController` (fetches products from API and persists to Realm) → `AuthViewController` (Firebase sign-in/up) → `MainTabBarController` (3 tabs: Products, Search, Profile).

## Key Dependencies

| Library | Purpose |
|---------|---------|
| **Moya** | Network abstraction over Alamofire — API routes defined in `ShoppingAppAPI/ShoppingAppAPI/Services/FakeStoreService.swift` |
| **RealmSwift** | Local persistence — entity models in `ShoppingAppAPI/ShoppingAppAPI/Entity/` and `Shopping App/Screens/` |
| **FirebaseAuth** | Email/password authentication |
| **SnapKit** | Programmatic Auto Layout DSL (all views are code-based, no XIBs) |
| **Kingfisher** | Async image loading & caching |

## Networking

- API base URL: `https://fakestoreapi.com`
- Routes defined as a Moya `TargetType` enum in `ShoppingAppAPI/ShoppingAppAPI/Services/FakeStoreService.swift`.
- One endpoint: `getProducts` (`/products`).

## Data Flow

API JSON → `Product` / `Rating` structs (Decodable, in `ShoppingAppAPI/ShoppingAppAPI/Entity/Product.swift`) → Realm `ProductEntity` / `RatingEntity` (in `Shopping App/Screens/Products/Model/`) → persisted via Realm.

Cart items use `OrderEntity` (in `Shopping App/Screens/Authentication/Model/OrderEntity.swift`). Orders are stored as a Realm `List<OrderEntity>` on the `UserEntity` (keyed by Firebase UID).

## Realm Configuration

Defined in the `RealmReachable` protocol extension (`Shopping App/App/Core/Protocols/RealmReachable.swift`). Schema version 0 with `deleteRealmIfMigrationNeeded: true` — the DB is wiped on any schema change. Classes that need Realm access conform to `RealmReachable` to get a computed `realm` property.

## Conventions

- **All UI is programmatic** — SnapKit for constraints, no storyboards except `LaunchScreen.storyboard` (launch screen entry point only).
- Git branching: `main` is the release branch, `develop` is the working branch.
