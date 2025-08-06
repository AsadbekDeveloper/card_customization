# ✨ Card Customization App ✨

**A robust Flutter application for dynamic digital card personalization.**

This application provides a powerful platform for users to customize digital cards with advanced visual controls, built on a scalable BLoC architecture.

## 🚀 Core Features

-   **Image Management**: Select predefined assets or import images from the device gallery.
-   **Transformations**: Apply precise scaling and positioning to card elements.
-   **Color Gradients**: Define primary and secondary background colors for rich visual effects.
-   **Blur Effects**: Implement adjustable Gaussian blur for background depth.
-   **Data Persistence (Mocked)**: Simulate saving customized card configurations via a mocked API.

## 🏗️ Technical Architecture (BLoC Pattern)

The application leverages the **BLoC (Business Logic Component) pattern** for clear separation of concerns, ensuring high maintainability, scalability, and testability.

-   **`presentation/bloc`**: Manages application state and business logic, reacting to events and emitting new states.
-   **`domain`**: Encapsulates core business rules and use cases, defining abstract contracts for repositories.
-   **`data`**: Implements data access logic, interacting with external sources (e.g., `image_picker`, mocked API).

## 🛠️ Setup & Run

### Prerequisites

-   Flutter SDK (>=3.8.1)

### Installation

```bash
git clone https://github.com/AsadbekDeveloper/card_customization.git
cd card_customization
flutter pub get
flutter run
```

## ✅ Unit Testing

Comprehensive unit tests validate the `CardCustomizationBloc`'s behavior across critical scenarios, including state transitions for image selection, property updates, and data saving operations.

To execute tests:

```bash
flutter test test/features/card_customization/presentation/bloc/card_customization_bloc_test.dart
```