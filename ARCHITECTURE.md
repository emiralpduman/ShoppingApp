# Architecture

## Overview

ShoppingApp follows the **MVVM (Model-View-ViewModel)** pattern with a clear separation between UI, business logic, and data layers. All views are built programmatically with UIKit and SnapKit — no storyboards or xibs.

## Layer Breakdown

### View Layer
Each screen has a dedicated `View` class (e.g., `ProductsView`, `CartView`) that owns layout and styling. Views are configured by their parent ViewController and do not hold business logic.

### ViewController Layer
ViewControllers manage the lifecycle and act as the bridge between View and ViewModel. They conform to ViewModel delegate protocols to receive data updates.

### ViewModel Layer
ViewModels hold business logic and data. They expose data to ViewControllers through properties and notify changes via the **delegate pattern**. ViewModels never import UIKit.

## Key Design Decisions

### Protocol-Oriented Dependency Injection
Data access is abstracted through the `RealmReachable` protocol. ViewModels conform to `RealmReachable` and gain database access via a protocol extension.

**Trade-off:** Simpler than constructor injection for a project of this scope, but less testable. A production app would use constructor-injected protocols for full mockability.

### Separate API Module (ShoppingAppAPI)
Networking is isolated in a separate Swift module using Moya. This enforces a compile-time boundary between the app and its network layer.

### Delegate Pattern over Closures/Combine
ViewModels communicate back to ViewControllers via delegate protocols. Chosen for clarity and consistency with UIKit conventions.

## Data Flow

1. User action → ViewController receives the event
2. ViewController calls a method on ViewModel
3. ViewModel fetches data (via Moya or Realm)
4. ViewModel updates its state and calls delegate method
5. ViewController updates the View

## Dependencies

| Library | Purpose | Why chosen |
|---|---|---|
| **SnapKit** | Auto Layout DSL | Cleaner programmatic constraints |
| **Realm** | Local persistence | Simpler API than Core Data for this scope |
| **Moya** | Network abstraction | Type-safe API layer on top of Alamofire |
| **Kingfisher** | Image downloading/caching | Industry standard for async image loading |
| **Firebase** | Authentication | Quick auth setup for a bootcamp project |

## Screen Map

| Screen | Purpose | Key Components |
|---|---|---|
| Launch | Splash + auth check | LaunchViewModel |
| Authentication | Sign in / Sign up | Firebase Auth, UserEntity (Realm) |
| Products | Product listing + detail + add to cart | FakeStore API, ProductEntity |
| Cart | Cart management + checkout | OrderEntity, cart total calculation |
| Profile | User info + sign out | Firebase sign out |
| Main | Tab bar navigation | MainTabBarController |
