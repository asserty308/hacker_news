# AGENTS.md for Flutter

## Packages to use

- Use cubit from `flutter_bloc` for state management.
- Use `flutter_riverpod` for dependency injection.
- Use `go_router` for navigation.
- Use `flutter_test` for widget testing.
- Use `mockito` for mocking dependencies in tests.
- Use `flutter_localizations` for localization support.
- Use `intl` for internationalization and localization.
- Use `hive_ce_flutter` for local storage.
- Use `shared_preferences` for key-value storage.
- Use `http` for making network requests.
- Use `logger` for logging.

## Coding Guidelines

- Use clean architecture principles.
- Follow Test-Driven Development (TDD) principles.
- Write clean, readable, and maintainable code.
- Follow the SOLID principles.
- Write meaningful comments and documentation.
- Ensure proper error handling and logging.
- Always separate business logic from UI code.
- Always consider maintainability. 
- Use descriptive names for all classes, methods, and variables.
- Avoid using magic numbers and strings.
- Keep widget build methods clean and concise.
- Follow Dart and Flutter best practices.
- Use dart formatting tools like `dart format` to maintain code style.
- Avoid unnecessary complexity in your code.
- Keep your widget tree shallow.
- Avoid using user-facing strings directly in the code. Use localization instead.
- Use gaps (vGap16, hGap16, etc.) from `flutter_core` for spacing.
- Separate business logic into use cases or services.
- Use cases should have a execute() method.
- Prefer `const` constructions when possible.
- Constants should be prefixed with `k` (e.g., kDefaultPadding).
- Make constants globally accessible without class wrappers.

## Git Guidelines

- When committing code, use semantic commit messages.
- Make atomic commits that focus on a single change or feature.

## Testing Guidelines

- Write unit tests for all features.
- Write widget tests for UI components.
- Ensure high test coverage.
