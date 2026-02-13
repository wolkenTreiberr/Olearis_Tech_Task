# Olearis Tech Task

Flutter test task — two-screen app (Sign In + Home) with adaptive layout, Cubit state management, and repository pattern.

<p align="center">
  <img src="assets/demo/demo.gif" width="100%" alt="Demo">
</p>

## Getting Started

```bash
flutter pub get
flutter run
```

**Requirements:** Flutter 3.35.3+, Dart 3.9.2+

**Platforms:** iOS, Android

## Project Structure

```
lib/
├── app/
│   ├── app.dart                    — MaterialApp setup
│   └── app_provider.dart           — DI (RepositoryProvider)
├── repositories/
│   └── auth/
│       └── auth_repository.dart    — Auth data source
├── styles/
│   ├── app_colors.dart             — AppColors (ThemeExtension)
│   └── app_theme.dart              — Theme configuration
├── utils/
│   ├── result.dart                 — Result<T> sealed class (Success/Failure)
│   └── app_bloc_observer.dart      — Debug logging for state changes
├── views/
│   ├── sign_in/
│   │   ├── sign_in_view.dart       — Sign In screen
│   │   ├── sign_in_cubit.dart      — Sign In logic
│   │   └── sign_in_state.dart      — Sign In state
│   └── home/
│       ├── home_view.dart          — Home screen
│       ├── home_cubit.dart         — Home logic
│       ├── home_state.dart         — Home state
│       └── widgets/
│           ├── logo_card.dart      — Logo with border
│           └── tiles_grid.dart     — Items grid (2 columns)
└── main.dart
```

## Architecture

**Bloc architecture** with Cubit as a lightweight alternative to full Bloc. Layers: View → Cubit → Repository.

**Cubit over Bloc** — Cubit is more intuitive for this scope. There are no incoming event streams or complex event transformations that would justify full Bloc. Cubit provides the same testability with less boilerplate.

**Repository pattern** — `AuthRepository` is injected via `RepositoryProvider` into `SignInCubit`. This separates data access from UI logic and makes the codebase ready for real API integration.

**Result type** — `Result<T>` sealed class with `Success` and `Failure` variants. Repositories return `Result` instead of throwing exceptions, enabling explicit error handling via pattern matching in Cubits.

**BlocObserver** — `AppBlocObserver` logs all state changes in debug mode for monitoring and debugging.

**BlocListener for side effects** — Navigation and error SnackBars are handled via `BlocListener`, separating side effects from UI rendering.

**No service layer** — For a 2-screen app, an additional service layer between Cubit and Repository would be overengineering. In a production app with shared business logic across features, a service layer (as Cubit) would be added.

**No GoRouter** — `Navigator.push/pop` is sufficient for 2 screens. GoRouter adds value with deep linking, guards, and complex navigation graphs — none of which apply here.

**No Freezed** — States have 2-3 fields each. Manual `copyWith` is written in seconds and avoids build_runner dependency.

**Minimal dependencies** — Only packages that directly serve the task requirements:
| Package | Purpose |
|---------|---------|
| `flutter_bloc` | State management (Cubit) |
| `flutter_svg` | SVG logo rendering |
| `flutter_lints` | Static analysis rules |

## Layout Approach

- **LayoutBuilder** for all layout decisions (not OrientationBuilder or MediaQuery.of)
- **SafeArea** with `top: false` when AppBar is present — handles notch/Dynamic Island in landscape
- **GridView.count** for tiles — native aspect ratio and spacing calculation
- **SingleChildScrollView + ConstrainedBox** pattern for scroll-on-overflow behavior

## Screens

### Sign In
- Adaptive logo positioning (percentage-based)
- Form validation — Continue button enabled only when both fields are filled
- Loading state with CircularProgressIndicator on submit
- Error handling via Result type + SnackBar
- Scrollable content when keyboard appears
- Portrait & landscape support

### Home (Markup Test)
- Dynamic item list (+/- buttons in AppBar)
- Logo centered in available space above tiles
- Tiles: 2 columns, 4:1 aspect ratio, 12px margins
- Automatic switch to scroll mode when content overflows
- Portrait & landscape support
